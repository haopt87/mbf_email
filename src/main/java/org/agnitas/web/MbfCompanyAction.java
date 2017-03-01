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

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.beans.Mailinglist;
import org.agnitas.beans.impl.MbfCompanyImpl;
import org.agnitas.dao.MbfCompanyDao;
import org.agnitas.dao.exception.target.TargetGroupLockedException;
import org.agnitas.dao.exception.target.TargetGroupPersistenceException;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.emm.core.target.exception.TargetGroupIsInUseException;
import org.agnitas.util.AgnUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.springframework.beans.factory.annotation.Required;

public class MbfCompanyAction extends StrutsActionBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfCompanyAction.class);

	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE = ACTION_LAST + 3;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_CONFIRM_DELETE = ACTION_LAST + 4;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE_YES = ACTION_LAST + 5;

	protected ConfigService configService;
	private MbfCompanyDao mbfCompanyDao;

	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {

		MbfCompanyForm aForm = null;
		ActionForward destination = null;
		ActionMessages errors = new ActionMessages();
        ActionMessages messages = new ActionMessages();

		if (!AgnUtils.isUserLoggedIn(req)) {
			return mapping.findForward("logon");
		}

		if (form != null) {
			aForm = (MbfCompanyForm) form;
		} else {
			aForm = new MbfCompanyForm();
		}

		// if (!allowed("department_mng.show", req)) {
		// errors.add(ActionMessages.GLOBAL_MESSAGE, new
		// ActionMessage("error.permissionDenied"));
		// saveErrors(req, errors);
		// return null;
		// }

		try {
			switch (aForm.getAction()) {
			case MbfCompanyAction.ACTION_LIST:

				List<MbfCompanyImpl> lists = this.mbfCompanyDao.getMbfCompanys();
				req.setAttribute("company_mngCompanyList", lists);
				aForm.clearAllData();
				destination = mapping.findForward("list");
				break;

			case MbfCompanyAction.ACTION_VIEW:
				if (aForm.getId() != 0) {
					aForm.setAction(MbfCompanyAction.ACTION_SAVE);
					loadCompany(aForm, req);
				} else {
					aForm.setAction(MbfCompanyAction.ACTION_NEW);
				}
				destination = mapping.findForward("view");
				break;

			case MbfCompanyAction.ACTION_SAVE:

				MbfCompanyImpl entity = this.mbfCompanyDao.getMbfCompany(aForm.getId());
				if (entity == null) {
					if (!companyChangedToExisting(aForm)) {
						entity = new MbfCompanyImpl();
						entity.setId(0);
						entity.setCompanyName(aForm.getCompanyName());
						entity.setDescription(aForm.getDescription());
						entity.setDeleted(0);
						this.mbfCompanyDao.saveMbfCompany(entity);
		                messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
					}else {
                        errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mailinglist.duplicate", aForm.getCompanyName()));
                    }
				} else {
					entity.setId(aForm.getId());
					entity.setCompanyName(aForm.getCompanyName());
					entity.setDescription(aForm.getDescription());
					entity.setDeleted(0);
					this.mbfCompanyDao.saveMbfCompany(entity);
	                messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				}

				req.setAttribute("company_mngCompanyList", this.mbfCompanyDao.getMbfCompanys());				
				// Always go back to overview
                aForm.setAction(MbfCompanyAction.ACTION_SAVE);
				
				destination = mapping.findForward("view");
				break;
			case ACTION_DELETE:
					this.mbfCompanyDao.deleteMbfCompany(aForm.getId());
					aForm.clearAllData();
					req.setAttribute("company_mngCompanyList", this.mbfCompanyDao.getMbfCompanys());
					destination = mapping.findForward("list");
				break;
			default:
				destination = mapping.findForward("list");
				break;
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			logger.error("execute: " + e, e);
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.exception",
					configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
		}

        if (!errors.isEmpty()) {
            saveErrors(req, errors);
        }
        
        // Report any message (non-errors) we have discovered
        if(!messages.isEmpty()) {
        	saveMessages(req, messages);
        }

		return destination;
	}

	private boolean companyChangedToExisting(MbfCompanyForm aForm) {
		int copanyID = aForm.getId();
        if (copanyID != 0) {
        	MbfCompanyImpl mbfCompanyImpl = this.mbfCompanyDao.getMbfCompany(copanyID);
            if (mbfCompanyImpl != null && mbfCompanyImpl.getCompanyName().equals(aForm.getCompanyName())){
                return false;
            }
        }
        return this.mbfCompanyDao.mailinglistExists(aForm.getCompanyName());
	}

	private void loadCompany(MbfCompanyForm aForm, HttpServletRequest req) {

		MbfCompanyImpl obj = this.mbfCompanyDao.getMbfCompany(aForm.getId());
		if (obj.getId() == 0) {
			logger.warn(
					"loadCompany: could not load MbfCompanyImpl " + aForm.getId());
			obj = new MbfCompanyImpl();
			obj.setId(aForm.getId());
		}
		aForm.setCompanyName(obj.getCompanyName());
		aForm.setDescription(obj.getDescription());
	}

	/**
	 * @return the mbfCompanyDao
	 */
	public MbfCompanyDao getMbfCompanyDao() {
		return mbfCompanyDao;
	}

	/**
	 * @param mbfCompanyDao the mbfCompanyDao to set
	 */
	public void setMbfCompanyDao(MbfCompanyDao mbfCompanyDao) {
		this.mbfCompanyDao = mbfCompanyDao;
	}

}