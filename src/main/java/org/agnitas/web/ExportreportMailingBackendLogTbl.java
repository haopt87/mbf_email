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

import org.agnitas.web.forms.StrutsFormBase;
import org.apache.log4j.Logger;

/**
 *
 * @author mobifone
 */
public class ExportreportMailingBackendLogTbl extends StrutsFormBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(ExportreportMailingBackendLogTbl.class);

	private int mailing_id;
	private int current_mails;
	private int total_mails;
	private int status_id;;
	
	public ExportreportMailingBackendLogTbl() {
	}

	public int getMailing_id() {
		return mailing_id;
	}

	public void setMailing_id(int mailing_id) {
		this.mailing_id = mailing_id;
	}

	public int getCurrent_mails() {
		return current_mails;
	}

	public void setCurrent_mails(int current_mails) {
		this.current_mails = current_mails;
	}

	public int getTotal_mails() {
		return total_mails;
	}

	public void setTotal_mails(int total_mails) {
		this.total_mails = total_mails;
	}

	public int getStatus_id() {
		return status_id;
	}

	public void setStatus_id(int status_id) {
		this.status_id = status_id;
	}
	

}