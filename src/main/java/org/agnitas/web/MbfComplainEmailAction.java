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

import org.agnitas.beans.impl.MbfComplainEmailImpl;
import org.agnitas.dao.MbfComplainEmailDao;
import org.agnitas.emm.core.commons.util.ConfigService;
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

public class MbfComplainEmailAction extends StrutsActionBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfComplainEmailAction.class);

	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE = ACTION_LAST + 3;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_CONFIRM_DELETE = ACTION_LAST + 4;
	public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE_YES = ACTION_LAST + 5;
	
	private static final String CHARSET = "UTF-8";
	public static final String EXPORT_FILE_DIRECTORY = AgnUtils.getTempDir() + File.separator + "RecipientExport";
	
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
				List<MbfComplainEmailForm> lists = loadListComplain();
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
					aForm.clearAllData();
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
					entity.setResolveInformation(aForm.getResolveInformation());
					entity.setCreationDate(new Date());
					entity.setStatus(0);
					entity.setDeleted(0);
					this.mbfComplainEmailDao.saveMbfComplainEmail(entity);
					aForm.setId(entity.getId());
					messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				} else {
					entity.setId(aForm.getId());
					entity.setCustomerName(aForm.getCustomerName());
					entity.setCustomerMobile(aForm.getCustomerMobile());
					entity.setEmailAddress(aForm.getEmailAddress());
					entity.setOtherInformation(aForm.getOtherInformation());
					entity.setResolveInformation(aForm.getResolveInformation());
					entity.setStatus(aForm.getStatus());
					entity.setResolveDate(new Date());
					entity.setDeleted(0);
					this.mbfComplainEmailDao.saveMbfComplainEmail(entity);
					messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("default.changes_saved"));
				}

				req.setAttribute("statusList", getStatusList());
				
				// Always go back to overview
				aForm.setAction(MbfComplainEmailAction.ACTION_SAVE);
				destination = mapping.findForward("view");
				break;
			case ACTION_DELETE:
				this.mbfComplainEmailDao.deleteMbfComplainEmail(aForm.getId());				
				req.setAttribute("complainemailList", loadListComplain());
				req.setAttribute("statusList", getStatusList());
				aForm.clearAllData();
				destination = mapping.findForward("list");
				break;
			case 10:
				destination = mapping.findForward("export");
				req.setAttribute("sessionId", req.getSession().getId());
				break;
			case 11:
				exportData(req, res);
				break;
			default:
				req.setAttribute("complainemailList", loadListComplain());
				req.setAttribute("statusList", getStatusList());
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
	
	@SuppressWarnings("unused")
	private void exportData(HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {
		
		res.setContentType("text/plain");
		String outFileName = "ExportComplainEmail"; // contains the Filename, build from the
									// timestamp
		String outFile = ""; // contains the actual data.		
		res.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
		res.setCharacterEncoding("");
		
		ActionMessages errors = new ActionMessages();
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Sheet0");
		Map<String, Object[]> data = new TreeMap<String, Object[]>();
		String[] rows = outFile.split("\r\n");
		Object[] header = new Object[8];
		header[0] = "Tên khách hàng";
		header[1] = "Điện thoại";
		header[2] = "Email";
		header[3] = "Trạng thái xử lý";
		header[4] = "Thông tin khiếu nại";
		header[5] = "Thông tin phản hồi";
		header[6] = "Ngày khiếu nại";
		header[7] = "Ngày gửi phản hồi";
		
		data.put(0 + "", header);	
		
		int count = 1;
		List<MbfComplainEmailForm> lists = loadListComplain();
		for (MbfComplainEmailForm item : lists) {
			count++;
			Object[] content = new Object[8];
			content[0] = item.getCustomerName();
			content[1] = item.getCustomerMobile();
			content[2] = item.getEmailAddress();
			String statusProcess = "Chưa xử lý"; 
			int status = item.getStatus(); 
			switch (status) {
			case 0:
				statusProcess = "Chưa xử lý";
				break;
			case 1:
				statusProcess = "Chờ duyệt";
				break;
			case 2:
				statusProcess = "Đang xử lý";
				break;
			case 3:
				statusProcess = "Đã xử lý";
				break;
			default:
				statusProcess = "Chưa xử lý";
				break;
			}			
			content[3] = statusProcess;
			content[4] = item.getOtherInformation();
			content[5] = item.getResolveInformation();
			content[6] = item.getCreationDate();
			content[7] = item.getActualeResolveDate();
			data.put(count + "", content);		
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

	private List<MbfComplainEmailForm> loadListComplain() {
		List<MbfComplainEmailForm> lists = null;
		
		try {
			lists = new ArrayList<MbfComplainEmailForm>();
			List<MbfComplainEmailImpl> listsEntity = this.mbfComplainEmailDao.getMbfComplainEmails();
			for (MbfComplainEmailImpl item : listsEntity) {
				MbfComplainEmailForm obj = new MbfComplainEmailForm();	
				BeanUtils.copyProperties(obj, item);
				if (item.getResolveDate() != null) {
					obj.setActualeResolveDate(item.getResolveDate());
				}
				lists.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			lists = new ArrayList<MbfComplainEmailForm>();
		}
		
		return lists;
	}

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
		aForm.setResolveInformation(obj.getResolveInformation());
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