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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.agnitas.beans.Admin;
import org.agnitas.beans.Mailinglist;
import org.agnitas.beans.impl.DepartmentImpl;
import org.agnitas.beans.impl.MbfCompanyImpl;
import org.agnitas.beans.impl.MbfComplainEmailImpl;
import org.agnitas.beans.impl.MbfExportImpl;
import org.agnitas.beans.impl.MbfSettingSystemImpl;
import org.agnitas.dao.DepartmentDao;
import org.agnitas.dao.MbfCompanyDao;
import org.agnitas.dao.MbfSettingSystemDao;
import org.agnitas.dao.exception.target.TargetGroupLockedException;
import org.agnitas.dao.exception.target.TargetGroupPersistenceException;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.emm.core.target.exception.TargetGroupIsInUseException;
import org.agnitas.util.AgnUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.springframework.beans.factory.annotation.Required;

public class MbfSettingSystemAction extends StrutsActionBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfSettingSystemAction.class);

	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE = ACTION_LAST + 3;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_CONFIRM_DELETE = ACTION_LAST + 4;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE_YES = ACTION_LAST + 5;
	
	private static final String CHARSET = "UTF-8";
	public static final String EXPORT_FILE_DIRECTORY = AgnUtils.getTempDir() + File.separator + "RecipientExport";
	
	protected ConfigService configService;
	private MbfCompanyDao mbfCompanyDao;
	private DepartmentDao departmentDao;
	private MbfSettingSystemDao mbfSettingSystemDao;
	

	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}
	
    protected SimpleDateFormat getLocaleFormat(Admin admin) {
		Locale locale = admin.getLocale();
		return (SimpleDateFormat) SimpleDateFormat.getDateInstance( DateFormat.SHORT, locale);
	}
    

	private List<MbfSettingSystemBackUpType> getBackupTypeList() {		
		List<MbfSettingSystemBackUpType> statusList = new ArrayList<>();
		statusList.add(new MbfSettingSystemBackUpType(0,"Tự động"));
		statusList.add(new MbfSettingSystemBackUpType(1,"Lưu thủ công"));
		return statusList;
	}
    
    private List<MbfSettingSystemLogType> getLogTypeList() {		
		List<MbfSettingSystemLogType> statusList = new ArrayList<>();				
		statusList.add(new MbfSettingSystemLogType(0,"đăng nhập"));
		statusList.add(new MbfSettingSystemLogType(1,"tạo chiến dịch"));	
			
		return statusList;
	}
    
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {

		MbfSettingSystemForm aForm = null;
		ActionForward destination = null;
		ActionMessages errors = new ActionMessages();
        ActionMessages messages = new ActionMessages();

		if (!AgnUtils.isUserLoggedIn(req)) {
			return mapping.findForward("logon");
		}

		if (form != null) {
			aForm = (MbfSettingSystemForm) form;
		} else {
			aForm = new MbfSettingSystemForm();
		}


//        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        HttpSession session = req.getSession();		
		Admin admin1 = (Admin) session.getAttribute("emm.admin");
        SimpleDateFormat localeFormat = getLocaleFormat(admin1);
        aForm.setAutoImportTime(localeFormat.format(new Date()));
        
		try {	
			switch (aForm.getAction()) {
			case MbfSettingSystemAction.ACTION_LIST:				
				destination = mapping.findForward("list");
				break;

			case MbfSettingSystemAction.ACTION_VIEW:
				MbfSettingSystemImpl entityEdit = this.mbfSettingSystemDao.getMbfSettingSystemImpl(1);
				aForm.setId(entityEdit.getId());
				aForm.setSendEmail(entityEdit.getSendEmail());
				aForm.setReplyEmail(entityEdit.getReplyEmail());
				aForm.setBackupType(entityEdit.getBackupType());
				aForm.setIntPriceAnEmail(entityEdit.getPriceAnEmail());
				aForm.setPriceAnEmail(entityEdit.getPriceAnEmail() + "");
				aForm.setBackupTime("");
				aForm.setLogUserType(entityEdit.getLog_user_action());
				aForm.setDeleted(0);
				
				if (aForm.getId() != 0) {
					aForm.setAction(MbfSettingSystemAction.ACTION_SAVE);					
				} else {
					aForm.setAction(MbfSettingSystemAction.ACTION_NEW);
				}
				destination = mapping.findForward("view");
				break;

			case MbfSettingSystemAction.ACTION_SAVE:	
				if (aForm.getSendEmail()== null || aForm.getSendEmail().equals("")) {
                    errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mbf.setting.system.name.empty"));
				} else if (aForm.getReplyEmail() == null || aForm.getReplyEmail().equals("")) {
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mbf.setting.system.ReplyEmail.empty"));
				} 
				try {
					aForm.setIntPriceAnEmail(Integer.parseInt(aForm.getPriceAnEmail()));
				} catch (Exception e) {
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mbf.setting.system.PriceAnEmail.empty"));
					destination = mapping.findForward("view");
					break;
				}
				
				
				this.mbfSettingSystemDao.saveMbfSettingSystemImplAFrom(aForm);
	               messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				 
//				MbfSettingSystemImpl entity = this.mbfSettingSystemDao.getMbfSettingSystemImpl(aForm.getId());				
//				if (entity == null) {
//				} else {
//					entity.setId(aForm.getId());
//					entity.setSendEmail(aForm.getSendEmail());
//					entity.setReplyEmail(aForm.getReplyEmail());
//					entity.setBackupTime(aForm.getBackupTime());
//					entity.setBackupType(aForm.getBackupType());
//					entity.setPriceAnEmail(aForm.getIntPriceAnEmail());
//					
//					this.mbfSettingSystemDao.saveMbfSettingSystemImpl(entity);
//		               messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));				
//				}	
	            aForm.setAction(MbfCompanyAction.ACTION_SAVE);				
				destination = mapping.findForward("view");
				
				break;
				
			default:		
				destination = mapping.findForward("view");
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

		req.setAttribute("backupTypeList", getBackupTypeList());				
		req.setAttribute("logUserTypeList", getLogTypeList());
		
		return destination;
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

	/**
	 * @return the departmentDao
	 */
	public DepartmentDao getDepartmentDao() {
		return departmentDao;
	}

	/**
	 * @param departmentDao the departmentDao to set
	 */
	public void setDepartmentDao(DepartmentDao departmentDao) {
		this.departmentDao = departmentDao;
	}

	/**
	 * @return the mbfSettingSystemDao
	 */
	public MbfSettingSystemDao getMbfSettingSystemDao() {
		return mbfSettingSystemDao;
	}

	/**
	 * @param mbfSettingSystemDao the mbfSettingSystemDao to set
	 */
	public void setMbfSettingSystemDao(MbfSettingSystemDao mbfSettingSystemDao) {
		this.mbfSettingSystemDao = mbfSettingSystemDao;
	}

}