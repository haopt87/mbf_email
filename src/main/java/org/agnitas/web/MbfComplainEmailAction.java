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
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.beans.impl.MbfComplainEmailImpl;
import org.agnitas.dao.MbfComplainEmailDao;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.util.AgnUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.springframework.beans.factory.annotation.Required;

public class MbfComplainEmailAction extends StrutsActionBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfComplainEmailAction.class);

	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE = ACTION_LAST + 3;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_CONFIRM_DELETE = ACTION_LAST + 4;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE_YES = ACTION_LAST + 5;

	protected ConfigService configService;
	private MbfComplainEmailDao mbfComplainEmailDao;

	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {

		MbfComplainEmailForm aForm = null;
		ActionForward destination = null;
		ActionMessages errors = new ActionMessages();
		ActionMessages messages = new ActionMessages();

		if (!AgnUtils.isUserLoggedIn(req)) {
			return mapping.findForward("logon");
		}

		if (form != null) {
			aForm = (MbfComplainEmailForm) form;
		} else {
			aForm = new MbfComplainEmailForm();
		}

		try {
			switch (aForm.getAction()) {
			case MbfComplainEmailAction.ACTION_LIST:

				List<MbfComplainEmailImpl> listsEntity = this.mbfComplainEmailDao.getMbfComplainEmails();
				List<MbfComplainEmailForm> lists = new ArrayList<MbfComplainEmailForm>();
				for (MbfComplainEmailImpl item : listsEntity) {
					MbfComplainEmailForm obj = new MbfComplainEmailForm();
					BeanUtils.copyProperties(obj, item);
					lists.add(obj);
				}
				req.setAttribute("complainemailList", lists);
				aForm.clearAllData();
				destination = mapping.findForward("list");
				break;

			case MbfComplainEmailAction.ACTION_VIEW:
				req.setAttribute("statusList", getStatusList());
				if (aForm.getId() != 0) {
					aForm.setAction(MbfComplainEmailAction.ACTION_SAVE);
					loadComplainEmail(aForm, req);
				} else {
					aForm.setAction(MbfComplainEmailAction.ACTION_NEW);
				}
				destination = mapping.findForward("view");
				break;

			case MbfComplainEmailAction.ACTION_SAVE:

				MbfComplainEmailImpl entity = this.mbfComplainEmailDao.getMbfComplainEmail(aForm.getId());
				if (entity == null) {
					entity = new MbfComplainEmailImpl();
					entity.setId(0);					
					entity.setCustomerName(aForm.getCustomerName());
					entity.setCustomerMobile(aForm.getCustomerMobile());
					entity.setEmailAddress(aForm.getEmailAddress());
					entity.setOtherInformation(aForm.getOtherInformation());
					entity.setStatus(0);
					entity.setDeleted(0);
					this.mbfComplainEmailDao.saveMbfComplainEmail(entity);
					messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				} else {
					entity.setId(aForm.getId());
					entity.setCustomerName(aForm.getCustomerName());
					entity.setCustomerMobile(aForm.getCustomerMobile());
					entity.setEmailAddress(aForm.getEmailAddress());
					entity.setOtherInformation(aForm.getOtherInformation());
					entity.setStatus(aForm.getStatus());
					entity.setDeleted(0);
					this.mbfComplainEmailDao.saveMbfComplainEmail(entity);
					messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				}

				req.setAttribute("statusList", getStatusList());
				req.setAttribute("complainemailList", this.mbfComplainEmailDao.getMbfComplainEmails());
				// Always go back to overview
				aForm.setAction(MbfComplainEmailAction.ACTION_SAVE);

				destination = mapping.findForward("view");
				break;
			case ACTION_DELETE:
				this.mbfComplainEmailDao.deleteMbfComplainEmail(aForm.getId());
				aForm.clearAllData();
				List<MbfComplainEmailImpl> listsEntity1 = this.mbfComplainEmailDao.getMbfComplainEmails();
				List<MbfComplainEmailForm> lists1 = new ArrayList<MbfComplainEmailForm>();
				for (MbfComplainEmailImpl item : listsEntity1) {
					MbfComplainEmailForm obj = new MbfComplainEmailForm();
					BeanUtils.copyProperties(obj, item);
					lists1.add(obj);
				}
				req.setAttribute("complainemailList", lists1);
				
				req.setAttribute("statusList", getStatusList());
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
		if (!messages.isEmpty()) {
			saveMessages(req, messages);
		}

		return destination;
	}

	// private boolean companyChangedToExisting(MbfComplainEmailForm aForm) {
	// int copanyID = aForm.getId();
	// if (copanyID != 0) {
	// MbfCompanyImpl mbfCompanyImpl =
	// this.mbfComplainEmailDao.getMbfComplainEmail(copanyID);
	// if (mbfCompanyImpl != null &&
	// mbfCompanyImpl.getCompanyName().equals(aForm.getCompanyName())){
	// return false;
	// }
	// }
	// return this.mbfCompanyDao.mailinglistExists(aForm.getCompanyName());
	// }

	private List<MbfStatusComplain> getStatusList() {
		List<MbfStatusComplain> statusList = new ArrayList<>();
		statusList.add(new MbfStatusComplain(0,"Chưa xử lý"));
		statusList.add(new MbfStatusComplain(1,"Chờ duyệt"));
		statusList.add(new MbfStatusComplain(2,"Đang xử lý"));
		statusList.add(new MbfStatusComplain(3,"Đã xử lý"));		
		return statusList;
	}
	
	private void loadComplainEmail(MbfComplainEmailForm aForm, HttpServletRequest req) {

		MbfComplainEmailImpl obj = this.mbfComplainEmailDao.getMbfComplainEmail(aForm.getId());
		if (obj.getId() == 0) {
			logger.warn("loadCompany: could not load MbfCompanyImpl " + aForm.getId());
			obj = new MbfComplainEmailImpl();
			obj.setId(aForm.getId());
		}
		aForm.setCustomerName(obj.getCustomerName());
		aForm.setCustomerMobile(obj.getCustomerMobile());
		aForm.setEmailAddress(obj.getEmailAddress());
		aForm.setOtherInformation(obj.getOtherInformation());
		aForm.setStatus(obj.getStatus());
		
	}

	/**
	 * @return the mbfComplainEmailDao
	 */
	public MbfComplainEmailDao getMbfComplainEmailDao() {
		return mbfComplainEmailDao;
	}

	/**
	 * @param mbfComplainEmailDao
	 *            the mbfComplainEmailDao to set
	 */
	public void setMbfComplainEmailDao(MbfComplainEmailDao mbfComplainEmailDao) {
		this.mbfComplainEmailDao = mbfComplainEmailDao;
	}

}