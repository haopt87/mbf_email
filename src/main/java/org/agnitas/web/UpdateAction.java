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
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.beans.impl.MbfExportImpl;
import org.agnitas.dao.MbfExportDao;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.util.AgnUtils;
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

/**
 * Implementation of <strong>Action</strong> that handles Account Admins
 *
 * @author Nicole Serek
 */

public final class UpdateAction extends StrutsActionBase {
	private static final transient Logger logger = Logger.getLogger(UpdateAction.class);
	
	protected ConfigService configService;
	private MbfExportDao mbfExportDao;	

	/**
	 * @return the mbfExportDao
	 */
	public MbfExportDao getMbfExportDao() {
		return mbfExportDao;
	}

	/**
	 * @param mbfExportDao the mbfExportDao to set
	 */
	@Required
	public void setMbfExportDao(MbfExportDao mbfExportDao) {
		this.mbfExportDao = mbfExportDao;
	}
	
	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

    // ---------------------------------------- Public Methods

    /**
     * Process the specified HTTP request, and create the corresponding HTTP
     * response (or forward to another web component that will create it).
     * Return an <code>ActionForward</code> instance describing where and how
     * control should be forwarded, or <code>null</code> if the response has
     * already been completed.
     *
     * ACTION_LIST: launches Automatic update of OpenEMM, <br>
     *          forwards to success or error page <br>
     * <br><br>
     * ACTION_VIEW: forwards to jsp with question to confirm update
     * <br><br>
     * ACTION_NEW: forwards to administration list page
     * <br><br>
     * Any other ACTION_* would cause a forward to "list"
     * <br><br>
     * @param mapping The ActionMapping used to select this instance
     * @param form
     * @param req
     * @param res
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet exception occurs
     * @return destination
     */
    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest req,
            HttpServletResponse res)
            throws IOException, ServletException {

        UpdateForm aForm = null;
        ActionMessages errors = new ActionMessages();
        ActionForward destination=null;

        if(!AgnUtils.isUserLoggedIn(req)) {
            return mapping.findForward("logon");
        }
        
        if(form!=null) {
            aForm=(UpdateForm)form;
        } else {
            aForm=new UpdateForm();
        }

        try {
            switch(aForm.getAction()) {
                case UpdateAction.ACTION_LIST:
                    if(allowed("update.show", req)) {
                    	String cmd = "/home/openemm/bin/upgrade.sh start";
                    	int rc;
                    	Runtime rtime = Runtime.getRuntime ();
                        Process proc = rtime.exec (cmd);
                        rc = proc.waitFor ();
                        if (rc == 0) {
                        	destination=mapping.findForward("success");
                        }
                    } else {
                        errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
                        destination=mapping.findForward("error");
                    }
                    break;
                    
                case UpdateAction.ACTION_VIEW:
                	destination=mapping.findForward("question");
                	break;
                	
                case UpdateAction.ACTION_NEW:
                	aForm.setAction(UpdateAction.ACTION_VIEW);
                	destination=mapping.findForward("list");
                	break;

                case 22:
                	destination=mapping.findForward("export");
    				req.setAttribute("sessionId", req.getSession().getId());
                	break;
                case 23:
    				exportData(req, res);
                	break;
                	
                default:
                    aForm.setAction(UpdateAction.ACTION_VIEW);
                    destination=mapping.findForward("list");
            }
        } catch (Exception e) {
            logger.error("execute: "+e, e);
            errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.exception", configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
            throw new ServletException(e);
        }

        // Report any errors we have discovered back to the original form
        if (!errors.isEmpty()) {
            saveErrors(req, errors);
        }
        return destination;
    }
    
    private static final String CHARSET = "UTF-8";
	public static final String EXPORT_FILE_DIRECTORY = AgnUtils.getTempDir() + File.separator + "RecipientExport";
	
	@SuppressWarnings("unused")
	private void exportData(HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {
		
		res.setContentType("text/plain");
		String outFileName = "ExportBillByUser";
		String outFile = "";		
		res.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
		res.setCharacterEncoding("");
		
		ActionMessages errors = new ActionMessages();
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Sheet0");
		Map<String, Object[]> data = new TreeMap<String, Object[]>();
		String[] rows = outFile.split("\r\n");
		Object[] header = new Object[7];
		header[0] = "Mã NV";
		header[1] = "Tài khoản";
		header[2] = "Tên tài khoản";
		header[3] = "Số email";
		header[4] = "Đơn giá";
		header[5] = "Tổng chi phí";
		header[6] = "Ngày tạo";
				
		data.put(0 + "", header);	
		
		int count = 1;
		
		List<MbfExportImpl> lists = this.getMbfExportDao().getMbfExportImpls(16);
		
		for (MbfExportImpl mbfExportImpl : lists) {
			count++;
			Object[] content = new Object[7];
			content[0] = mbfExportImpl.getId();
			content[1] = mbfExportImpl.getUserName();
			content[2] = mbfExportImpl.getFullName();
			content[3] = mbfExportImpl.getTotalMailsOfCampain();
			content[4] = "1000";
			content[5] = mbfExportImpl.getTotalMailsOfCampain() * 1000;
			content[6] = mbfExportImpl.getCreationDate();		
			
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
					System.out.println("obj:"+ obj);
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

}
