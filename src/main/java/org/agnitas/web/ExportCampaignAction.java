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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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

public class ExportCampaignAction extends StrutsActionBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(ExportCampaignAction.class);

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
	
	private List<ExportreportForm> loadMbfSettingSystem(ActionMessages errors){
		List<MbfSettingSystemImpl> lists = this.mbfSettingSystemDao.getMbfSettingSystemImpls();
		
		List<ExportreportForm> results = new ArrayList<ExportreportForm>();
		try {
			for (MbfSettingSystemImpl item : lists) {
				ExportreportForm obj = new ExportreportForm(); 
				BeanUtils.copyProperties(obj, item);
				results.add(obj);
			}		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			logger.error("execute: " + e, e);
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.exception",
					configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
		}
		return results;
	}
	
	private void loadExportreport(ExportreportForm aForm) {

		MbfSettingSystemImpl obj = this.mbfSettingSystemDao.getMbfSettingSystemImpl(aForm.getId());
		if (obj.getId() == 0) {
			logger.warn("loadCompany: could not load MbfCompanyImpl " + aForm.getId());
			obj = new MbfSettingSystemImpl();
			obj.setId(aForm.getId());
		}
		
		aForm.setSendEmail(obj.getSendEmail());
		aForm.setReplyEmail(obj.getReplyEmail());
		aForm.setBackupType(obj.getBackupType());
		aForm.setBackupTime(obj.getBackupTime());
	}	

	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {

		ExportreportForm aForm = null;
		ActionForward destination = null;
		ActionMessages errors = new ActionMessages();
        ActionMessages messages = new ActionMessages();

		if (!AgnUtils.isUserLoggedIn(req)) {
			return mapping.findForward("logon");
		}

		if (form != null) {
			aForm = (ExportreportForm) form;
		} else {
			aForm = new ExportreportForm();
		}


		try {
			List<ExportreportForm> mbfCompanyList = null;			
			switch (aForm.getAction()) {
			case ExportCampaignAction.ACTION_LIST:
				List<ExportreportForm> list = loadMbfSettingSystem(errors);
				
				req.setAttribute("settingSystemLists", list);				
				destination = mapping.findForward("list");
				break;

			case ExportCampaignAction.ACTION_VIEW:
				if (aForm.getId() != 0) {
					aForm.setAction(ExportCampaignAction.ACTION_SAVE);
					loadExportreport(aForm);
				} else {
					aForm.clearAllData();
					aForm.setAction(ExportCampaignAction.ACTION_NEW);
				}
				destination = mapping.findForward("view");
				break;

			case ExportCampaignAction.ACTION_SAVE:	
				if (aForm.getSendEmail()== null || aForm.getSendEmail().equals("")) {
                    errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mbf.setting.system.name.empty"));
				} else {
					MbfSettingSystemImpl entity = this.mbfSettingSystemDao.getMbfSettingSystemImpl(aForm.getId());
					if (entity == null) {
//						if (!companyChangedToExisting(aForm)) {
//							entity = new MbfCompanyImpl();
//							entity.setId(0);
//							entity.setCompanyName(aForm.getCompanyName());
//							entity.setDescription(aForm.getDescription());
//							entity.setDeleted(0);
//							this.mbfCompanyDao.saveMbfCompany(entity);
//							aForm.setId(entity.getId());
//			                messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
//						}else {
//	                        errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.mailinglist.duplicate", aForm.getCompanyName()));
//	                    }
					} else {
						entity.setId(aForm.getId());
						entity.setSendEmail(aForm.getSendEmail());
						entity.setReplyEmail(aForm.getReplyEmail());
						entity.setBackupTime(aForm.getBackupTime());
						entity.setBackupType(aForm.getBackupType());
						
						this.mbfSettingSystemDao.saveMbfSettingSystemImpl(entity);
		                messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
					}
				}	
	            aForm.setAction(MbfCompanyAction.ACTION_SAVE);				
				destination = mapping.findForward("view");
				
				break;
			case 12:
				destination = mapping.findForward("export_detail");
				req.setAttribute("sessionId", req.getSession().getId());
                //load company list
				List<ExportreportUser> userList = this.mbfSettingSystemDao.getExportreportUsers();  
                req.setAttribute("userList", userList);
                
				break;
			case 13:
				exportDetail(req, res, aForm);				
				break;
			case 22:
				destination = mapping.findForward("view-over");
				req.setAttribute("sessionId", req.getSession().getId());
                //load company list
//				List<ExportreportUser> userList = this.mbfSettingSystemDao.getExportreportUsers();  
//                req.setAttribute("userList", userList);
                
				break;
			case 32:
				destination = mapping.findForward("view");
				req.setAttribute("sessionId", req.getSession().getId());
                //load company list
//				List<ExportreportUser> userList = this.mbfSettingSystemDao.getExportreportUsers();  
//                req.setAttribute("userList", userList);
                
				break;
				
			default:
				req.setAttribute("company_mngCompanyList", mbfCompanyList);
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
	
	@SuppressWarnings("unused")
	private void exportDetail(HttpServletRequest req,
			HttpServletResponse res, ExportreportForm aForm) throws IOException, ServletException {
		

		res.setContentType("text/plain");
		String outFileName = "ExportDetailCampaign";
		String outFile = "";		
		res.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
		res.setCharacterEncoding("");
		
		ActionMessages errors = new ActionMessages();
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Sheet0");
		Map<String, Object[]> data = new TreeMap<String, Object[]>();
		String[] rows = outFile.split("\r\n");
		Object[] header = new Object[8];
		header[0] = "Stt";
		header[1] = "Tên chiến dịch";
		header[2] = "Ngày tạo chiến dịch";
		header[3] = "Ngày gửi chiến dịch";
		header[4] = "Tên khách hàng";
		header[5] = "Họ & đệm khách hàng";
		header[6] = "Giới tính khách hàng";
		header[7] = "Email của khách hàng";		
		data.put(0 + "", header);
				
		/**
		 *Get list campaign by user 
		 */
		List<ExportreportMailingBackendLogTbl> mailingBackendLogTbl 
			= this.mbfSettingSystemDao.getExportreportMailingBackendLogTblById(aForm.getUserId());
		
		if (mailingBackendLogTbl != null && !mailingBackendLogTbl.isEmpty()) {	
			int count = 0;
			for (ExportreportMailingBackendLogTbl exportreportMailingBackendLogTbl : mailingBackendLogTbl) {
				/**
				 * get detail email send to each user in campaign
				 */
				List<ExportreportDataDetail> lists = this.mbfSettingSystemDao.getExportreportDataDetail(
						exportreportMailingBackendLogTbl.getMailing_id(),
						exportreportMailingBackendLogTbl.getStatus_id());
				for (ExportreportDataDetail exportreportDataDetail : lists) {
					count++;
					Object[] content = new Object[8];
					content[0] = count;
					content[1] = exportreportDataDetail.getShortname();
					content[2] = exportreportDataDetail.getCreation_date();
					content[3] = exportreportDataDetail.getChange_date();
					content[4] = exportreportDataDetail.getFirstname();
					content[5] = exportreportDataDetail.getLastname();
					content[6] = exportreportDataDetail.getGender() == 0 ? "Nam":"Nữ";
					content[7] = exportreportDataDetail.getEmail();
					data.put(count + "", content);
				}				
			}
		}
		
		
		// Iterate over data and write to sheet
		Set<String> keyset = data.keySet();
		int rownum = 0;
		for (String key : keyset) {
			Row row = sheet.createRow(rownum++);
			Object[] objArr = data.get(key);
			int cellnum = 0;
			for (Object obj : objArr) {
				Cell cell = row.createCell(cellnum++);
				if (obj instanceof String){
					cell.setCellValue((String) obj);
				}	
				else if (obj instanceof Integer){
					cell.setCellValue((Integer) obj);
				}	
				else if (obj instanceof Date){
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					String stDate = dateFormat.format(((Date) obj).getTime());
					cell.setCellValue(stDate);	
				}					
			}
		}		
		
		try {
			// Write the workbook in file system
			File fileOutput = new File(
					EXPORT_FILE_DIRECTORY + File.separator + "ExportData_" + System.currentTimeMillis() + ".xlsx");
			// System.out.println(fileOutput.getAbsolutePath());
			FileOutputStream out1 = new FileOutputStream(fileOutput);
			workbook.write(out1);
			out1.close();
			byte bytes[] = new byte[16384];
			int len = 0;
			if (fileOutput != null) {
				FileInputStream instream = null;
				try {
					instream = new FileInputStream(fileOutput);
					res.setContentType("application/zip");
					res.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
					res.setContentLength((int) fileOutput.length());
					ServletOutputStream ostream = res.getOutputStream();
					while ((len = instream.read(bytes)) != -1) {
						ostream.write(bytes, 0, len);
					}
				} finally {
					if (instream != null) {
						instream.close();
					}
				}
			} else {
				errors.add("global", new ActionMessage("error.export.file_not_ready"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
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