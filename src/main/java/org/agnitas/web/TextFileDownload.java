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
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.util.AgnUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

public class TextFileDownload extends HttpServlet {

	private static final long serialVersionUID = 5844323149267914354L;

	private static final String CHARSET = "UTF-8";
	public static final String EXPORT_FILE_DIRECTORY = AgnUtils.getTempDir() + File.separator + "RecipientExport";

	/**
	 * Gets file parameters from request. <br>
	 * reads file from session. <br>
	 * build filepath (timestamp + .csv) and set it to response header <br>
	 * write parameters and file to response <br>
	 * <br>
	 */
	@SuppressWarnings("unused")
	public void doGet(HttpServletRequest req, HttpServletResponse response) 
                      throws IOException, ServletException {


		// response.setContentType("text/plain");
		// Hashtable map;
		// map = (Hashtable)(req.getSession().getAttribute("map"));
		//
		// String outFileName = ""; // contains the Filename, build from the
		// timestamp
		// String outFile = ""; // contains the actual data.
		//
		// outFileName = (String) req.getParameter("key");
		// outFile = (String)map.get(req.getParameter("key")); // get the key
		// from the Hashmap.
		//
		// // build filepath (timestamp + .csv) and return it.
		// response.setHeader("Content-Disposition", "attachment; filename=\"" +
		// outFileName + ".csv\";");
		// response.setCharacterEncoding(CHARSET);
		//
		// PrintWriter writer = response.getWriter();
		// writer.print(outFile);	


        
		// Start create excel
		// file==================================================
		// Blank workbook

		response.setContentType("text/plain");
		Hashtable map;
		map = (Hashtable) (req.getSession().getAttribute("map"));

		String outFileName = ""; // contains the Filename, build from the
									// timestamp
		String outFile = ""; // contains the actual data.

		outFileName = (String) req.getParameter("key");
		outFile = (String) map.get(req.getParameter("key")); // get the key from
																// the Hashmap.

		// build filepath (timestamp + .csv) and return it.
		// response.setHeader("Content-Disposition", "attachment; filename=\"" +
		// outFileName + ".csv\";");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
		response.setCharacterEncoding(CHARSET);
		// PrintWriter writer = response.getWriter();
		// writer.print(outFile);
		
		
		ActionMessages errors = new ActionMessages();
		XSSFWorkbook workbook = new XSSFWorkbook();
		// Create a blank sheet
		XSSFSheet sheet = workbook.createSheet("Sheet0");
		Map<String, Object[]> data = new TreeMap<String, Object[]>();
		String[] rows = outFile.split("\r\n");
		int count = 0;
		for (String items : rows) {			
			count++;
			String[] cells = items.split(";");
			int lengthCell = cells.length;
			Object[] content = new Object[lengthCell];
			
			for (int i = 0; i < content.length; i++) {
				content[i] = cells[i].replaceAll("\"", "");
			}
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
				if (obj instanceof String)
					cell.setCellValue((String) obj);
				else if (obj instanceof Integer)
					cell.setCellValue((Integer) obj);
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
					response.setContentType("application/zip");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + outFileName + ".xlsx\";");
					response.setContentLength((int) fileOutput.length());
					ServletOutputStream ostream = response.getOutputStream();
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

		// End create excel
		// file==================================================

	}
}
