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
package org.agnitas.mailing.web;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.beans.Admin;
import org.agnitas.dao.MailingDao;
import org.agnitas.util.AgnUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.springframework.web.struts.DispatchActionSupport;

public class MailingSendAjaxAction extends DispatchActionSupport {

	private MailingDao mailingDao;

	public ActionForward transmissionRunning(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		Admin admin = AgnUtils.getAdmin(request);
		if(  admin == null ) {
			return null;
		}

		if( !admin.permissionAllowed("mailing.send.admin\\|mailing.send.test")) {
			return null;
		}

		String message = "TRUE";
		String mailingIDStr = request.getParameter("mailingID");
		if( StringUtils.isNotEmpty(mailingIDStr) && StringUtils.isNumeric(mailingIDStr)) {
			boolean transmissionRunning = mailingDao.isTransmissionRunning(Integer.parseInt(mailingIDStr));
			message = transmissionRunning ? "TRUE": "FALSE";
		}

		response.setContentType("text/plain");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter pw = response.getWriter();
		pw.write(message);
		pw.close();

		return null;
	}

	public void setMailingDao(MailingDao mailingDao) {
		this.mailingDao = mailingDao;
	}

}
