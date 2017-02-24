/*********************************************************************************
 * The contents of this file are subject to the Common Public Attribution
 * License Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.openemm.org/cpal1.html. The License is based on the Mozilla
 * Public License Version 1.1 but Sections 14 and 15 have been added to cover
 * use of software over a computer network and provide for limited attribution
 * for the Original Developer. In addition, Exhibit A has been modified to be
 * consistent with Exhibit B.
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * 
 * The Original Code is OpenEMM.
 * The Original Developer is the Initial Developer.
 * The Initial Developer of the Original Code is AGNITAS AG. All portions of
 * the code written by AGNITAS AG are Copyright (c) 2014 AGNITAS AG. All Rights
 * Reserved.
 * 
 * Contributor(s): AGNITAS AG. 
 ********************************************************************************/

package org.agnitas.web;

import org.agnitas.beans.Mailing;
import org.agnitas.beans.MailingBase;
import org.agnitas.beans.MailingComponent;
import org.agnitas.beans.MediatypeEmail;
import org.agnitas.beans.factory.MailingFactory;
import org.agnitas.cms.utils.dataaccess.CMTemplateManager;
import org.agnitas.cms.utils.dataaccess.ContentModuleManager;
import org.agnitas.cms.webservices.generated.CMTemplate;
import org.agnitas.cms.webservices.generated.ContentModuleLocation;
import org.agnitas.dao.CampaignDao;
import org.agnitas.dao.MailingDao;
import org.agnitas.dao.MailinglistDao;
import org.agnitas.dao.TargetDao;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.emm.core.mailing.service.MailingModel;
import org.agnitas.exceptions.CharacterEncodingValidationException;
import org.agnitas.preview.AgnTagError;
import org.agnitas.preview.AgnTagException;
import org.agnitas.preview.PreviewHelper;
import org.agnitas.preview.TAGCheck;
import org.agnitas.preview.TAGCheckFactory;
import org.agnitas.service.MailingsQueryWorker;
import org.agnitas.util.AgnUtils;
import org.agnitas.util.CharacterEncodingValidator;
import org.agnitas.util.SafeString;
import org.agnitas.web.forms.MailingBaseForm;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.TransientDataAccessResourceException;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;

/**
 * Implementation of <strong>Action</strong> that handles Mailings
 *
 * @author Martin Helff
 */

public class MailingBaseAction extends StrutsActionBase {
	
	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MailingBaseAction.class);

	public static final String FUTURE_TASK = "GET_MAILING_LIST";
	
    public static final int ACTION_SELECT_TEMPLATE = ACTION_LAST+1;
    
    public static final int ACTION_REMOVE_TARGET = ACTION_LAST+2;
    
    public static final int ACTION_VIEW_WITHOUT_LOAD = ACTION_LAST+3;
    
    public static final int ACTION_CLONE_AS_MAILING = ACTION_LAST+4;
    
    public static final int ACTION_USED_ACTIONS = ACTION_LAST + 5;

    public static final int ACTION_VIEW_TABLE_ONLY = ACTION_LAST +6;
    
    public static final int ACTION_MAILING_BASE_LAST = ACTION_LAST+6;

    protected MailinglistDao mailinglistDao;

    protected MailingDao mailingDao;

    protected AbstractMap<String, Future> futureHolder;

    protected TargetDao targetDao;

    protected TAGCheckFactory tagCheckFactory;

    protected ExecutorService executorService;

    protected CampaignDao campaignDao;

    protected CharacterEncodingValidator characterEncodingValidator;

    protected MailingFactory mailingFactory;
    
	protected ConfigService configService;
	
	private CMTemplateManager cmTemplateManager;
	
	private ContentModuleManager contentModuleManager;

	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}
	
	public void setCmTemplateManager(CMTemplateManager cmTemplateManager) {
		this.cmTemplateManager = cmTemplateManager;
	}

	public void setContentModuleManager(ContentModuleManager contentModuleManager) {
		this.contentModuleManager = contentModuleManager;
	}

    // --------------------------------------------------------- Public Methods
    
    
    /**
     * Process the specified HTTP request, and create the corresponding HTTP
     * response (or forward to another web component that will create it).
     * Return an <code>ActionForward</code> instance describing where and how
     * control should be forwarded, or <code>null</code> if the response has
     * already been completed.
     * <br>
	 * ACTION_LIST: Initializes columns width list for the mailings-list-table, forwards to "list"
	 * <br><br>
	 * ACTION_SAVE: validates character encoding in mailing subject, mailing components and content blocks;
     *     saves mailing in database;
     *     if the current mailing is template - updates all mailings using this template with dynamic-template
     *     property set and saves these mailings to database;
     *     loads saved mailing into form;
     *     if the mailing was cloned and the original mailing has cms data, clones cms data for the saved mailing;
     *     forwards to "view".
	 * <br><br>
     * ACTION_VIEW: loads mailing data from database into a form, forwards to "view". Also resets showTemplate property
     *     of form which indicates if new need to show the template-section of a mailing.
     * <br><br>
     * ACTION_NEW: checks if there is at least one mailinglist in database: shows error message if no mailing list was found,
     *     if the mailinglist exists - clears the form and forwards to "view".
     * <br><br>
     * ACTION_REMOVE_TARGET: removes given target group from the list of chosen target groups; forwards to "view".
     * <br><br>
     * ACTION_SELECT_TEMPLATE: loads the settings of chosen template into current form (mailing type, mailinglist,
     *     target-groups etc.); doesn't save mailing to database; forwards to "view".
     * <br><br>
     * ACTION_CLONE_AS_MAILING: clears the form; sets the properties of original mailing to form (original mailing
     *     is mailing used as source for cloning); names the new mailing as "Copy of " + name of original; stores
     *     the id of original mailing in form as templateID; forwards to mailing view page.
     * <br><br>
     * ACTION_USED_ACTIONS: loads map of emm actions used by current mailing into form; forwards to mailing actions
     *     page (forward is "action").
     * <br><br>
     * ACTION_VIEW_WITHOUT_LOAD: just forwards to "view" without reloading form data (is used after failing form
     *     validation).
     * <br><br>
	 * ACTION_CONFIRM_DELETE: loads mailing into form; forwards to jsp with question to confirm deletion (forward
     *     is "delete").
	 * <br><br>
	 * ACITON_DELETE: marks the mailing as deleted in database; forwards to "list".
	 * <br><br>
	 * Any other ACTION_* would cause a forward to "list"
     * <br><br>
     * If destination is "list" - calls a FutureHolder to get the list of mailings/templates according to selected
     * mailing types and isTemplate form-property (indicates if we we work with templates or mailings). <br>
     * If the Future object is not ready, increases the page refresh time by 50ms until it reaches 1 second.
     * (The page refresh time - is the wait-time before calling the action again while the FutureHolder is
     * running; the initial value is 250ms). While the FutureHolder is running - destination is "loading".<br>
     * When the FutureHolder is finished - the list of mailings/templates is set to request, the destination is "list".
     * <br><br>
     * If destination is "view": updates oldMailFormat property with the current value;<br>
     * loads list of templates and template name to form;<br>
     * loads mailinglists, campaigns, target groups and selected target groups into form.
     * <br><br>
     * If destination is null and there are errors found - forwards to "list"
     * @param form  ActionForm object
     * @param req   request
     * @param res   response
     * @param mapping The ActionMapping used to select this instance
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet exception occurs
     * @return destination
     */
    @Override
    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest req,
            HttpServletResponse res)
            throws IOException, ServletException {
        
        // Validate the request parameters specified by the user
        MailingBaseForm aForm=null;
        ActionMessages errors = new ActionMessages();
    	ActionMessages messages = new ActionMessages();
    	ActionForward destination=null;
        boolean showTemplates=false;
        ApplicationContext aContext = WebApplicationContextUtils.getRequiredWebApplicationContext(req.getSession().getServletContext());

        if(!AgnUtils.isUserLoggedIn(req)) {
            return mapping.findForward("logon");
        }
        
        aForm=(MailingBaseForm)form;

        if (logger.isInfoEnabled()) logger.info("execute: action "+aForm.getAction());

        boolean hasAnyPermission = true;
 
        if(aForm.isIsTemplate()) {
            if(!allowed("template.show", req)) {
                errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                saveErrors(req, errors);
                hasAnyPermission = false;
                //return null;
            }
        } else {
            if(!allowed("mailing.show", req)) {
                errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                saveErrors(req, errors);
                hasAnyPermission = false;
                //return null;
            }
        }

        req.setAttribute("hasPermission", hasAnyPermission);

        if(hasAnyPermission){
       
            if (aForm.getAction() != MailingBaseAction.ACTION_SAVE) {
                aForm.setOriginalMailingId(0);
            }

            try {
                switch(aForm.getAction()) {
                    case MailingBaseAction.ACTION_LIST:
                        if (aForm.getColumnwidthsList() == null) {
                            aForm.setColumnwidthsList(getInitializedColumnWidthList(5));
                        }
                        destination=mapping.findForward("list");
                        break;
                    case MailingBaseAction.ACTION_NEW:
                        if(allowed("mailing.new", req)) {
                            List mlists=mailinglistDao.getMailinglists(AgnUtils.getCompanyID(req));

                            if(mlists.size() > 0) {
                                aForm.setAction(MailingBaseAction.ACTION_SAVE);
                                int campaignID = aForm.getCampaignID();
                                aForm.clearData();
                                aForm.setMailingID(0);
                                aForm.setCampaignID(campaignID);
                                destination=mapping.findForward("view");
                            } else {
                                errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.mailing.noMailinglist"));
                            }
                        } else {
                            errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        }
                        break;

                    case MailingBaseAction.ACTION_VIEW:
                        aForm.setAction(MailingBaseAction.ACTION_SAVE);
                        resetShowTemplate(req, aForm);
                        loadMailing(aForm, req);
                        destination=mapping.findForward("view");
                        break;

                    case MailingBaseAction.ACTION_VIEW_WITHOUT_LOAD:
                        aForm.setAction(MailingBaseAction.ACTION_SAVE);
                        destination=mapping.findForward("view");
                        break;

                    case MailingBaseAction.ACTION_REMOVE_TARGET:
                        removeTarget(aForm, req);
                        aForm.setAction(MailingBaseAction.ACTION_SAVE);
                        destination=mapping.findForward("view");
                        break;

                    case MailingBaseAction.ACTION_SAVE:
                        if(allowed("mailing.change", req)) {
                            destination=mapping.findForward("view");

                            try {
                                validateMailing(aForm, req);
                            } catch(CharacterEncodingValidationException e) {
                                if(!e.isSubjectValid()) {
                                    errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.charset.subject"));
                                }
                                for(String mailingComponent : e.getFailedMailingComponents()) {
                                    errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.charset.component", mailingComponent));
                                }
                                for(String dynTag : e.getFailedDynamicTags()) {
                                    errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.charset.content", dynTag));
                                }
                            }

                            try {
                                saveMailing(aForm, req, errors, messages);
                                loadMailing(aForm, req);
                                // Show "changes saved"
                                messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
                            } catch (AgnTagException e) {
                                req.setAttribute("errorReport", e.getReport());
                                errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.template.dyntags"));
                            } catch (TransientDataAccessResourceException e) {
                                logger.error("execute: " + e, e);
                                errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.hibernate.attachmentTooLarge"));
                            }

                            showTemplates=aForm.isShowTemplate();
                            aForm.setShowTemplate(showTemplates);

                            // copy CMS data of cloned mailing if the original
                            // mailing included CMS content
                            if(aForm.getOriginalMailingId() != 0) {
                                if(mailingHasCmsData(aForm.getOriginalMailingId(), aContext)) {
                                    cloneMailingCmsData(aForm.getOriginalMailingId(), aForm.getMailingID(), aContext);
                                }
                                aForm.setOriginalMailingId(0);
                            }

                        } else {
                            errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        }
                        break;

                    case MailingBaseAction.ACTION_SELECT_TEMPLATE:
                        loadTemplateSettings(aForm, req);
                        aForm.setAction(MailingBaseAction.ACTION_SAVE);
                        destination=mapping.findForward("view");
                        break;

                    case MailingBaseAction.ACTION_CLONE_AS_MAILING:
                        if(allowed("mailing.copy", req)) {
                            aForm = fillFormWithOriginalData(aForm, req);
                            destination=mapping.findForward("view");
                        } else {
                            errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        }
                        break;

                    case MailingBaseAction.ACTION_CONFIRM_DELETE:
                        if(allowed("mailing.delete", req)) {
                            aForm.setAction(MailingBaseAction.ACTION_DELETE);
                            loadMailing(aForm, req);
                            destination=mapping.findForward("delete");
                        } else {
                            errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        }
                        break;

                    case MailingBaseAction.ACTION_DELETE:
                        if(allowed("mailing.delete", req)) {
                            aForm.setAction(MailingBaseAction.ACTION_LIST);
                            deleteMailing(aForm, req);
                            destination=mapping.findForward("list");

                            messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
                            aForm.setMessages(messages);
                        } else {
                            errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        }
                        break;

                    case MailingBaseAction.ACTION_USED_ACTIONS:
                        loadActions(aForm, req);
                        destination = mapping.findForward("action");
                        break;

                    default:
                        aForm.setAction(MailingBaseAction.ACTION_LIST);
                        destination=mapping.findForward("list");
                }

            } catch (Exception e) {
                logger.error("execute: "+e, e);
                errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.exception", configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
            }

            if(destination != null &&  "list".equals(destination.getName())) {
                try {
                    if (!aForm.isNumberOfRowsChanged()) {
                        setNumberOfRows(req, aForm);
                    }

                    destination = mapping.findForward("loading");
                    String key =  FUTURE_TASK+"@"+ req.getSession(false).getId();

                    if( !futureHolder.containsKey(key) ) {
                        Future mailingListFuture = getMailingListFuture(req,aForm.getTypes(), aForm.isIsTemplate(), aForm );
                        futureHolder.put(key,mailingListFuture);
                    }

                    if (futureHolder.containsKey(key) && futureHolder.get(key).isDone()) {
                        req.setAttribute("mailinglist", futureHolder.get(key).get());
                        destination = mapping.findForward("list");
                        futureHolder.remove(key);
                        aForm.setRefreshMillis(RecipientForm.DEFAULT_REFRESH_MILLIS);
                        saveMessages(req, aForm.getMessages());
                        saveErrors(req, aForm.getErrors());
                        aForm.setNumberOfRowsChanged(false);
                        aForm.setMessages(null);
                        aForm.setErrors(null);
                    }
                    else {
                        if( aForm.getRefreshMillis() < 1000 ) { // raise the refresh time
                            aForm.setRefreshMillis( aForm.getRefreshMillis() + 50 );
                        }
                        aForm.setError(false);
                    }

                } catch (Exception e) {
                   logger.error("getMailingList: "+e, e);
                    errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionMessage("error.exception", configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
                    aForm.setError(true); // do not refresh when an error has been occurred
                }
            }

            checkShowDynamicTemplateCheckbox( aForm, req);

            if (destination != null && "view".equals(destination.getName())) {
                if (aForm.getMediaEmail() != null) {
                    aForm.setOldMailFormat(aForm.getMediaEmail().getMailFormat());
                }
                aForm.setTemplateMailingBases(mailingDao.getTemplateMailingsByCompanyID(AgnUtils.getCompanyID(req)));
                if(aForm.getTemplateID() != 0) {
                   MailingBase mb = mailingDao.getMailingForTemplateID(aForm.getTemplateID(),AgnUtils.getCompanyID(req));
                   aForm.setTemplateShortname(mb.getShortname().compareTo("") != 0 ? mb.getShortname() : SafeString.getLocaleString("mailing.No_Template", (Locale) req.getSession().getAttribute(Globals.LOCALE_KEY)));
                }
                else {
                	aForm.setTemplateShortname(SafeString.getLocaleString("mailing.No_Template", (Locale) req.getSession().getAttribute(Globals.LOCALE_KEY)));
                }

                aForm.setMailingLists(mailinglistDao.getMailinglists(AgnUtils.getCompanyID(req)));
                aForm.setCampaigns(campaignDao.getCampaignList(AgnUtils.getCompanyID(req),"lower(shortname)",1));
                aForm.setTargetGroupsList(targetDao.getTargetGroup(AgnUtils.getCompanyID(req), aForm.getTargetGroups(), true));
                aForm.setTargets(targetDao.getUnchoosenTargets(AgnUtils.getCompanyID(req),aForm.getTargetGroups()));
            }
        }

        // Report any errors we have discovered back to the original form
        if (!errors.isEmpty()) {
            saveErrors(req, errors);
            if(destination == null) {
                destination=mapping.findForward("list");
            }
        }

        // Report any message (non-errors) we have discovered
        if (!messages.isEmpty()) {
        	saveMessages(req, messages);
        }
        
        return destination;
    }

    /**
     * Validates mailing subject, mailing components and dynamic tags
     *
     * @param form MailingBaseForm object
     * @param req  request
     * @throws CharacterEncodingValidationException contains numbers of line and position of wrong character
     */
    protected void validateMailing( MailingBaseForm form, HttpServletRequest req) throws CharacterEncodingValidationException {
    	Mailing mailing = mailingDao.getMailing(form.getMailingID(), AgnUtils.getCompanyID(req));
		characterEncodingValidator.validate( form, mailing);
    }
    
	protected void resetShowTemplate(HttpServletRequest req, MailingBaseForm aForm) {
		String showTemplate = req.getParameter("showTemplate");
		if(showTemplate == null || !showTemplate.equals("true")) {
			aForm.setShowTemplate(false);
		}
	}
    
    /**
     * Loads mailing data from db.
     *
     * @param aForm  MailingBaseForm object
     * @param req request
     * @throws Exception
     */
    protected void loadMailing(MailingBaseForm aForm, HttpServletRequest req) throws Exception {
        MediatypeEmail type=null;
        MailingComponent comp=null;
        Mailing aMailing=mailingDao.getMailing(aForm.getMailingID(), AgnUtils.getCompanyID(req));
        ApplicationContext aContext = WebApplicationContextUtils.getRequiredWebApplicationContext(req.getSession().getServletContext());
        if(aMailing==null) {
            aMailing=mailingFactory.newMailing();
            aMailing.init(AgnUtils.getCompanyID(req), aContext);
            aMailing.setId(0);
            aForm.setMailingID(0);
        }
        
        aForm.setShortname(aMailing.getShortname());
        aForm.setDescription(aMailing.getDescription());
        aForm.setMailingType(aMailing.getMailingType());
        aForm.setMailinglistID(aMailing.getMailinglistID());
        aForm.setTemplateID(aMailing.getMailTemplateID());
        aForm.setTargetGroups(aMailing.getTargetGroups());
        aForm.setMediatypes(aMailing.getMediatypes());
        aForm.setArchived(aMailing.getArchived() != 0 );
        aForm.setCampaignID(aMailing.getCampaignID());
        aForm.setTargetMode( aMailing.getTargetMode() );
        aForm.setWorldMailingSend(aMailing.isWorldMailingSend());
        aForm.setUseDynamicTemplate(aMailing.getUseDynamicTemplate());
        
        type=aMailing.getEmailParam();
        if(type!=null) {
            aForm.setEmailSubject(type.getSubject());
            aForm.setEmailOnepixel(type.getOnepixel());
            try {
                aForm.setEmailReplytoEmail(new InternetAddress(type.getReplyAdr()).getAddress());
            } catch (Exception e) {
                // do nothing
            }
            try {
                aForm.setEmailReplytoFullname(new InternetAddress(type.getReplyAdr()).getPersonal());
            } catch (Exception e) {
                // do nothing
            }
            aForm.setEmailLinefeed(type.getLinefeed());
            aForm.setEmailCharset(type.getCharset());
        }
        
        comp=aMailing.getTextTemplate();
        if(comp!=null) {
            aForm.setTextTemplate(comp.getEmmBlock());
        }
        
        comp=aMailing.getHtmlTemplate();
        if(comp!=null) {
            aForm.setHtmlTemplate(comp.getEmmBlock());
        }

        writeUserActivityLog(AgnUtils.getAdmin(req), "do load", getMailingDescription(aForm));

        if (logger.isInfoEnabled()) logger.info("loadMailing: mailing loaded");
    }

    /**
     * Removes target group from the list of chosen targets.
     *
     * @param aForm  MailingBaseForm object
     * @param req request
     * @throws Exception
     */
    protected void removeTarget(MailingBaseForm aForm, HttpServletRequest req) throws Exception {
        Collection<Integer> allTargets=aForm.getTargetGroups();
        Integer tmpInt=null;
        
        if(allTargets!=null) {
            Iterator<Integer> aIt=allTargets.iterator();
            while(aIt.hasNext()) {
                tmpInt = aIt.next();
                if(aForm.getTargetID()==tmpInt.intValue()) {
                    allTargets.remove(tmpInt);
                    break;
                }
            }
        }
        
        if(allTargets.isEmpty()) {
            aForm.setTargetGroups(null);
        }
    }

    /**
     * Gets mailing template data from db and calls method for loading the data into form.
     *
     * @param aForm  MailingBaseForm object
     * @param req  request
     * @throws Exception
     */
    protected void loadTemplateSettings(MailingBaseForm aForm, HttpServletRequest req) throws Exception {
        Mailing aTemplate=null;
        
        if(aForm.getTemplateID()!=0) {
            
            aTemplate=mailingDao.getMailing(aForm.getTemplateID(), AgnUtils.getCompanyID(req));
            if(aTemplate!=null) {
            	copyTemplateSettingsToMailingForm(aTemplate, aForm, req);
            }
        }
    }

    /**
     * Loads chosen mailing template data into form.
     *
     * @param template  Mailing bean object, contains mailing template data
     * @param mailingBaseForm  MailingBaseForm object
     */
    protected void copyTemplateSettingsToMailingForm(Mailing template, MailingBaseForm mailingBaseForm, HttpServletRequest req){
        MailingComponent tmpComp=null;

        mailingBaseForm.setMailingType(template.getMailingType());
        mailingBaseForm.setMailinglistID(template.getMailinglistID());
        mailingBaseForm.setTargetMode(template.getTargetMode());
        mailingBaseForm.setTargetGroups(template.getTargetGroups());
        mailingBaseForm.setMediatypes(template.getMediatypes());
        mailingBaseForm.setArchived(template.getArchived() != 0);
        mailingBaseForm.setCampaignID(template.getCampaignID());
        mailingBaseForm.setNeedsTarget(template.getNeedsTarget());
        mailingBaseForm.setUseDynamicTemplate(template.getUseDynamicTemplate());

        // load template for this mailing
        if((tmpComp=template.getHtmlTemplate())!=null) {
            mailingBaseForm.setHtmlTemplate(tmpComp.getEmmBlock());
        }

        if((tmpComp=template.getTextTemplate())!=null) {
            mailingBaseForm.setTextTemplate(tmpComp.getEmmBlock());
        }
        MediatypeEmail type=template.getEmailParam();
        if(type!=null) {
            mailingBaseForm.setEmailOnepixel(type.getOnepixel());
            try {
                mailingBaseForm.setEmailReplytoEmail(new InternetAddress(type.getReplyAdr()).getAddress());
            } catch (Exception e) {
                // do nothing
            }
            try {
                mailingBaseForm.setEmailReplytoFullname(new InternetAddress(type.getReplyAdr()).getPersonal());
            } catch (Exception e) {
                // do nothing
            }
            mailingBaseForm.setEmailLinefeed(type.getLinefeed());
            mailingBaseForm.setEmailCharset(type.getCharset());
        }
    }

    /**
     * Saves current mailing in DB (including mailing components, content blocks, dynamic tags, dynamic tags contents
     * and trackable links)
     *
     * @param aForm MailingBaseForm object
     * @param req  request
     * @param messages  not in use
     * @throws Exception
     */
    protected void saveMailing(MailingBaseForm aForm, HttpServletRequest req, ActionMessages errors, ActionMessages messages) throws Exception {
        Mailing aMailing=null;
        Mailing aTemplate=null;
        MediatypeEmail paramEmail=null;
        boolean newMail = false;
        ApplicationContext aContext = WebApplicationContextUtils.getRequiredWebApplicationContext(req.getSession().getServletContext());
        
        if(aForm.getMailingID()!=0) {
            aMailing=mailingDao.getMailing(aForm.getMailingID(), AgnUtils.getCompanyID(req));
        } else {
        	newMail = true;
        	if(aForm.getTemplateID()!=0) {
                aTemplate=mailingDao.getMailing(aForm.getTemplateID(), AgnUtils.getCompanyID(req));
                aMailing=(Mailing)aTemplate.clone(aContext);
                aMailing.setId(0);
                aMailing.setMailTemplateID(aForm.getTemplateID());
                aMailing.setCompanyID(AgnUtils.getCompanyID(req));
            }
        }
        
        if(aMailing==null) {
            aMailing=mailingFactory.newMailing();
            aMailing.init(AgnUtils.getCompanyID(req), aContext);
            aMailing.setId(0);
            aForm.setMailingID(0);
        }

		if (aForm.getMediaEmail().getMailFormat() == 0) {
			aForm.getMediaEmail().setHtmlTemplate("");
		} else if (aForm.getOldMailFormat() == 0) {
			if (aForm.getMediaEmail() != null && StringUtils.isEmpty(aForm.getMediaEmail().getHtmlTemplate())) {
				aForm.getMediaEmail().setHtmlTemplate("[agnDYN name=\"HTML-Version\"/]");
			}
		}

        List<String> actions = null;
        if (!newMail) {
            actions = getEditActionStrings(aForm, aMailing);
        }
        aMailing.setTargetGroups(aForm.getTargetGroups());
        aMailing.setMailingType(aForm.getMailingType());
        aMailing.setMailinglistID(aForm.getMailinglistID());
        aMailing.setIsTemplate(aForm.isIsTemplate());
        aMailing.setCampaignID(aForm.getCampaignID());
        aMailing.setDescription(aForm.getDescription());
        aMailing.setShortname(aForm.getShortname());
        aMailing.setArchived(aForm.isArchived()?1:0);
        aMailing.setTargetMode(aForm.getTargetMode());
        aMailing.setMediatypes(aForm.getMediatypes());
        aMailing.setUseDynamicTemplate(aForm.getUseDynamicTemplate());

        try {
            paramEmail=aMailing.getEmailParam();
            
            paramEmail.setSubject(aForm.getEmailSubject());
            paramEmail.setLinefeed(aForm.getEmailLinefeed());
            paramEmail.setCharset(aForm.getEmailCharset());
            paramEmail.setOnepixel(aForm.getEmailOnepixel());
           
            aForm.getMediaEmail().syncTemplate(aMailing, aContext);
            
            aMailing.buildDependencies(true, aContext, aForm.isCopyFlag());
        } catch (Exception e) {
            logger.error("Error in save mailing id: "+aForm.getMailingID()+" msg: "+e.getMessage());
        }

        // validate the components
		if(!newMail) {
			List<String[]> errorReports = new ArrayList<String[]>();
			boolean hasErrors = false;
			
			Map<String, List<AgnTagError>> agnTagErrorMap = aMailing.checkAgnTagSyntax(aContext);
			if (agnTagErrorMap != null) {
				for (String componentName : agnTagErrorMap.keySet()) {
					AgnTagError firstAgnTagSyntaxError = agnTagErrorMap.get(componentName).get(0);
					String displayComponentName = componentName;
					if (displayComponentName.startsWith("agn")) {
						displayComponentName = displayComponentName.substring(3);
					}
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.agntag.mailing.component", displayComponentName, firstAgnTagSyntaxError.getFullAgnTagText()));
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(firstAgnTagSyntaxError.getErrorKey().getMessageKey(), firstAgnTagSyntaxError.getAdditionalErrorDataWithLineInfo()));
					
					for (AgnTagError agnTagError : agnTagErrorMap.get(componentName)) {
						appendErrorToList(errorReports, componentName, agnTagError.getFullAgnTagText(), agnTagError.getLocalizedMessage(req.getLocale()));
					}
				}
				hasErrors = true;
			}
			
			if (!hasErrors) {
	            // fix the &quot; in agn-tags brought by CKEditor
	            MailingComponent htmlVersionComponent = aMailing.getComponents().get("agnHtml");
	            if (htmlVersionComponent != null) {
	                String htmlVersion = htmlVersionComponent.getEmmBlock();
	                String fixedHtmlVersion = AgnUtils.fixQuotesInAgnTags(htmlVersion);
	                htmlVersionComponent.setEmmBlock(fixedHtmlVersion);
	            }
	
				Set<Entry<String,MailingComponent>>  componentEntries = aMailing.getComponents().entrySet();
				Vector<String> outFailures = new Vector<String>();
				TAGCheck tagCheck =tagCheckFactory.createTAGCheck(aMailing.getId());
				
				for(Entry<String,MailingComponent> mapEntry:componentEntries) {
					String tagName = mapEntry.getKey();
					MailingComponent component = mapEntry.getValue();
					String emmBlock = component.getEmmBlock();
					StringBuffer contentOutReport = new StringBuffer();
					if(!tagCheck.checkContent(emmBlock, contentOutReport, outFailures) ) {
						appendErrorsToList(tagName, errorReports, contentOutReport);
					}
					
				}
			}
			
			if( errorReports.size() > 0) {
				throw new AgnTagException("error.template.dyntags",errorReports);
			}
		}
        
        mailingDao.saveMailing(aMailing);
        aForm.setMailingID(aMailing.getId());

        if( aMailing.isIsTemplate()) {
        	updateMailingsWithDynamicTemplate(aMailing);
        }

        final String description = getMailingDescription(aForm);
        if(newMail){
            writeUserActivityLog(AgnUtils.getAdmin(req), "create", description);
        } else {
            if(actions == null){
                writeUserActivityLog(AgnUtils.getAdmin(req),"edit " , description);
            } else {
                for(String action : actions){
                    writeUserActivityLog(AgnUtils.getAdmin(req),action, description);
                }
            }
        }
        
        aForm.setCopyFlag(false);
    }

    /**
     * Create list of fields changed in mailing
     * @param aForm - MailingBaseForm object from user side
     * @param aMailing - not yet changed mailing loaded from database
     * @return - list of string description of changes scheduled
     */
    protected List<String> getEditActionStrings(MailingBaseForm aForm, Mailing aMailing) {
        final String editKeyword = "edit ";
        StringBuilder actionMessage = new StringBuilder(editKeyword);
        List<String> actions = new LinkedList<>();

        if((aMailing.getTargetGroups() == null && aForm.getTargetGroups() != null) ||
                (aMailing.getTargetGroups() != null && !aMailing.getTargetGroups().equals(aForm.getTargetGroups()))){
            Set<Integer> oldGroups = new HashSet<>();
            if(aMailing.getTargetGroups() != null) {
                oldGroups.addAll(aMailing.getTargetGroups());
            }
            Set<Integer> newGroups = new HashSet<>();
            Set<Integer> groupsUpdate = new HashSet<>();
            if(aForm.getTargetGroups() != null){
                groupsUpdate.addAll(aForm.getTargetGroups());
                newGroups.addAll(groupsUpdate);
            }
            newGroups.removeAll(oldGroups);
            oldGroups.removeAll(groupsUpdate);
            if(oldGroups.size() != 0){
                actionMessage.append("removed ");
                for (Integer next : oldGroups) {
                    actionMessage.append(next).append(", ");
                }
            }
            if(newGroups.size() != 0){
                actionMessage.append("added ");
                for (Integer next : newGroups) {
                    actionMessage.append(next).append(", ");
                }
            }
            if(actionMessage.length() != editKeyword.length()){
                actionMessage.delete(actionMessage.length()-2,actionMessage.length()); //remove last two characters: comma and space
                actionMessage.insert(editKeyword.length(),"target groups ");
                actions.add(actionMessage.toString());
                actionMessage.delete(editKeyword.length(), actionMessage.length());
            }
        }

        if(aMailing.getMailingType() != aForm.getMailingType()){
            actionMessage.append("mailing type from ")
                    .append(mailingTypeToString(aMailing.getMailingType()))
                    .append(" to ")
                    .append(mailingTypeToString(aForm.getMailingType()));
            actions.add(actionMessage.toString());
            actionMessage.delete(editKeyword.length(), actionMessage.length());
        }

        if(aMailing.getMailinglistID() != aForm.getMailinglistID()){
            actionMessage.append("mailing list changed from ").append(aMailing.getMailinglistID()).append(" to ").append(aForm.getMailinglistID());
            actions.add(actionMessage.toString());
            actionMessage.delete(editKeyword.length(), actionMessage.length());
        }

        return actions;
    }

    /**
     * Converts mailing type integer constant to human readable string representation.
     * @param mailingType - mailing type integer constant
     * @return - mailing type string representation
     */
    protected String mailingTypeToString(int mailingType) {
        return MailingModel.getMailingType(mailingType).getName();
    }

    /**
     * Construct mailing description acceptable for user log
     * @param aForm MailingBaseForm data
     * @return mailing description including type, name and ID.
     */
    protected String getMailingDescription(MailingBaseForm aForm) {
        StringBuilder description = new StringBuilder();
        if(aForm.isIsTemplate()){
            description.append("template");
        } else {
            description.append("mailing");
        }
        description.append(" ")
                .append(aForm.getShortname())
                .append("(")
                .append(aForm.getMailingID())
                .append(")");

        return description.toString();
    }
    /**
     * Marks mailing as deleted and updated mailing data in database
     *
     * @param aForm MailingBaseForm object
     * @param req  request
     * @throws Exception
     */
    protected void deleteMailing(MailingBaseForm aForm, HttpServletRequest req) throws Exception {
        mailingDao.deleteMailing(aForm.getMailingID(), AgnUtils.getCompanyID(req));
        writeUserActivityLog(AgnUtils.getAdmin(req), "delete", getMailingDescription(aForm));
    }

    /**
     * Loads list of emm actions into form
     *
     * @param aForm MailingBaseForm object
     * @param req request
     * @throws Exception
     */
    protected void loadActions(MailingBaseForm aForm, HttpServletRequest req) throws Exception {
        List<Map<String, String>> map = mailingDao.loadAction(aForm.getMailingID(), AgnUtils.getCompanyID(req));
    	aForm.setActions(map);
    }

    /**
     * Creates paginated list by given sorting parameters and filter conditions (templates or mailings, mailings of certain types).
     *
     * @param req  request
     * @param types listed mailing types, separated with comma
     * @param isTemplate  true == templates
     *                    false==mailings
     * @param mailingBaseForm  MailingBaseForm object
     * @return Future object
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public Future getMailingListFuture(HttpServletRequest req , String types, boolean isTemplate, MailingBaseForm mailingBaseForm ) throws IllegalAccessException, InstantiationException {

    	String sort = getSort(req, mailingBaseForm);
     	
     	String direction = req.getParameter("dir");
     	if( direction == null ) {
     		direction = mailingBaseForm.getOrder();     		
     	} else {
     		mailingBaseForm.setOrder(direction);
     	}
     	
     	String pageStr  = req.getParameter("page");
     	if ( pageStr == null || "".equals(pageStr.trim()) ) {
     		if ( mailingBaseForm.getPage() == null || "".equals(mailingBaseForm.getPage().trim())) {
     			mailingBaseForm.setPage("1");
     		}
     		pageStr = mailingBaseForm.getPage();
     		
     	}
     	else {
     		mailingBaseForm.setPage(pageStr);
     	}
     	
     	if( mailingBaseForm.isNumberOfRowsChanged() ) {
     		mailingBaseForm.setPage("1");
     		pageStr = "1";
     	}
     	
     	int page = Integer.parseInt(pageStr);
     	
     	int rownums = mailingBaseForm.getNumberOfRows();
        Future future = executorService.submit(new MailingsQueryWorker(mailingDao, AgnUtils.getCompanyID(req), types, isTemplate, sort, direction, page, rownums ));
        return future;
    	
    }

	protected String getSort(HttpServletRequest request, MailingBaseForm aForm) {
		String sort = request.getParameter("sort");  
		 if( sort == null ) {
			 sort = aForm.getSort();			 
		 } else {
			 aForm.setSort(sort);
		 }
		return sort;
	}

    protected void appendErrorToList(List<String[]> errorReports, String blockName, String errorneousText, String errorDescription) {
		errorReports.add(new String[] { blockName, errorneousText, errorDescription });
	}

    /**
     * Creates report about errors in dynamic tags.
     *
     * @param blockName name of content block with invalid content
     * @param errorReports  list of messages about parsing errors (is changing inside the method)
     * @param templateReport content with errors
     */
	protected void appendErrorsToList(String blockName, List<String[]> errorReports, StringBuffer templateReport) {
		Map<String,String> tagsWithErrors = PreviewHelper.getTagsWithErrors(templateReport);
		for(Entry<String,String> entry:tagsWithErrors.entrySet()) {
			String[] errorRow = new String[3];
			errorRow[0] = blockName; // block
			errorRow[1] =  entry.getKey(); // tag
			errorRow[2] =  entry.getValue(); // value
			
			errorReports.add(errorRow);
		}
		List<String> errorsWithoutATag = PreviewHelper.getErrorsWithoutATag(templateReport);
		for(String error:errorsWithoutATag){
			String[] errorRow = new String[3];
			errorRow[0] = blockName;
			errorRow[1] = "";
			errorRow[2] = error;
			errorReports.add(errorRow);
		}
	}

    public MailingDao getMailingDao() {
        return mailingDao;
    }

    public void setMailingDao(MailingDao mailingDao) {
        this.mailingDao = mailingDao;
    }

    public void setFutureHolder(AbstractMap<String, Future> futureHolder) {
        this.futureHolder = futureHolder;
    }

    public CampaignDao getCampaignDao() {
        return campaignDao;
    }

    public void setCampaignDao(CampaignDao campaignDao) {
        this.campaignDao = campaignDao;
    }

    public MailinglistDao getMailinglistDao() {
        return mailinglistDao;
    }

    public void setMailinglistDao(MailinglistDao mailinglistDao) {
        this.mailinglistDao = mailinglistDao;
    }

    public CharacterEncodingValidator getCharacterEncodingValidator() {
        return characterEncodingValidator;
    }

    public void setCharacterEncodingValidator(CharacterEncodingValidator characterEncodingValidator) {
        this.characterEncodingValidator = characterEncodingValidator;
    }

    public TargetDao getTargetDao() {
        return targetDao;
    }

    public void setTargetDao(TargetDao targetDao) {
        this.targetDao = targetDao;
    }

    public TAGCheckFactory getTagCheckFactory() {
        return tagCheckFactory;
    }

    public void setTagCheckFactory(TAGCheckFactory tagCheckFactory) {
        this.tagCheckFactory = tagCheckFactory;
    }

    public void setExecutorService(ExecutorService executorService) {
        this.executorService = executorService;
    }

    public MailingFactory getMailingFactory() {
        return mailingFactory;
    }

    public void setMailingFactory(MailingFactory mailingFactory) {
        this.mailingFactory = mailingFactory;
    }

	protected void updateMailingsWithDynamicTemplate( Mailing mailTemplate) {
		List<Integer> referencingMailings = mailingDao.getTemplateReferencingMailingIds( mailTemplate);
		if( referencingMailings == null)
			return;

		int companyId = mailTemplate.getCompanyID();

		Mailing mailing;
		MailingComponent mailingComponent;
		MailingComponent templateComponent;

		for( int mailingId : referencingMailings) {
			mailing = mailingDao.getMailing(mailingId, companyId);

			// First, handle text template
			templateComponent = mailTemplate.getTextTemplate();
			mailingComponent = mailing.getTextTemplate();

			// Modify text template only if mailing and template have both a text template
			if( templateComponent != null && mailingComponent != null) {
				mailingComponent.setEmmBlock( templateComponent.getEmmBlock());
			}

			// Next, handle HTML template
			templateComponent = mailTemplate.getHtmlTemplate();
			mailingComponent = mailing.getHtmlTemplate();

			// Modify HTML template only if mailing and template have both a HTML template
			if( templateComponent != null && mailingComponent != null) {
				mailingComponent.setEmmBlock( templateComponent.getEmmBlock());
			}

			try {
				mailing.buildDependencies( true, getWebApplicationContext(), false);
				mailingDao.saveMailing( mailing);
			} catch( Exception e) {
				logger.error( "unable to update mailing ID " + mailingId + ": " + e.getMessage());

				if( logger.isDebugEnabled())
					logger.debug( "unable to update mailing ID " + mailingId, e);
			}

		}
	}

	protected void checkShowDynamicTemplateCheckbox( MailingBaseForm mailingBaseForm, HttpServletRequest request) {
		boolean showCheckbox = false;

		if( mailingBaseForm.isIsTemplate()) {
			// For templates checkbox is always show and enabled
			showCheckbox = true;
		} else if( mailingBaseForm.getTemplateID() != 0) {
			// For mailings, checkbox is always shows if and only if referenced mailing-record defines template
			// Checkbox is only enabled, if such a mailing has ID 0 (new mailing)

			showCheckbox = mailingDao.checkMailingReferencesTemplate( mailingBaseForm.getTemplateID(), AgnUtils.getCompanyID( request));
		} else {
			// in all other cases, the checkbox is hidden
			showCheckbox = false;
		}

		request.setAttribute("show_dynamic_template_checkbox", showCheckbox);
	}

    protected WebApplicationContext getApplicationContext(HttpServletRequest req){
        return WebApplicationContextUtils.getRequiredWebApplicationContext(req.getSession().getServletContext());
    }
    
    protected MailingBaseForm fillFormWithOriginalData(MailingBaseForm aForm, HttpServletRequest req) {
    	try {
    		aForm.setOriginalMailingId(aForm.getMailingID());
            int tmpTemplateID=aForm.getMailingID();
            int tmpMlId=aForm.getMailinglistID();
            String sname = aForm.getShortname();
            int tmpFormat=aForm.getMediaEmail().getMailFormat();
            boolean tmpl=aForm.isIsTemplate();
            String tempDescription = aForm.getDescription();
            aForm.clearData();
            aForm.setTemplateID(tmpTemplateID);
            aForm.setIsTemplate(tmpl);
            loadTemplateSettings(aForm, req);
            aForm.setMailinglistID(tmpMlId);
            aForm.getMediaEmail().setMailFormat(tmpFormat);
            aForm.setMailingID(0);
            aForm.setAction(MailingBaseAction.ACTION_SAVE);
            aForm.setShortname(SafeString.getLocaleString("mailing.CopyOf", (Locale)req.getSession().getAttribute(Globals.LOCALE_KEY)) + " " + sname);
            aForm.setDescription( tempDescription);
            aForm.setCopyFlag(true);
    	} catch (Exception e) {
            logger.error("execute: "+e, e);
        }

    	return aForm;
    }

	protected boolean mailingHasCmsData(int mailingId, ApplicationContext context) {
		CMTemplate template = cmTemplateManager.getCMTemplateForMailing(mailingId);
		if (template == null) {
			List<Integer> assignedCms = contentModuleManager.getAssignedCMsForMailing(mailingId);
			if (assignedCms.isEmpty()) {
				return false;
			}
		}
		return true;
	}

	protected void cloneMailingCmsData(int sourceMailingId, int newMailingId, ApplicationContext context) {
		// get CM bindings of current mailing
		List<Integer> cmIds = contentModuleManager.getAssignedCMsForMailing(sourceMailingId);
		List<ContentModuleLocation> cmLocations = contentModuleManager.getCMLocationsForMailingId(sourceMailingId);

		// copy CM bindings to new mailing
		contentModuleManager.addMailingBindingToContentModules(cmIds, newMailingId);
		for (ContentModuleLocation location : cmLocations) {
			location.setMailingId(newMailingId);
		}
		contentModuleManager.addCMLocations(cmLocations);

		// copy CM Template assignment
		CMTemplate template = cmTemplateManager.getCMTemplateForMailing(sourceMailingId);
		if (template != null) {
			cmTemplateManager.addMailingBindings(template.getId(), Collections.singletonList(newMailingId));
		}
	}
}
