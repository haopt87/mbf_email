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
public class ExportreportForm extends StrutsFormBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(ExportreportForm.class);

	private static final long serialVersionUID = 0L;

	private int id;
	private String sendEmail;
	private String replyEmail;
	private String backupType;
	private String backupTime;
	private int deleted;
	private int disabled;

	private int userId;
	
	private int action;
	private int previousAction;
	
	public ExportreportForm() {
	}

	public ExportreportForm(int id, String sendEmail, String replyEmail, int deleted, int disabled) {
		super();
		this.id = id;
		this.sendEmail = sendEmail;
		this.replyEmail = replyEmail;
		this.deleted = deleted;
		this.disabled = disabled;
	}

	public void clearAllData() {
		this.id = 0;
		this.sendEmail = "";
		this.replyEmail = "";
		this.deleted = 0;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSendEmail() {
		return sendEmail;
	}

	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}

	public String getReplyEmail() {
		return replyEmail;
	}

	public void setReplyEmail(String replyEmail) {
		this.replyEmail = replyEmail;
	}

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public int getDisabled() {
		return disabled;
	}

	public void setDisabled(int disabled) {
		this.disabled = disabled;
	}

	public int getAction() {
		return action;
	}

	public void setAction(int action) {
		this.action = action;
	}

	public int getPreviousAction() {
		return previousAction;
	}

	public void setPreviousAction(int previousAction) {
		this.previousAction = previousAction;
	}

	/**
	 * @return the backupType
	 */
	public String getBackupType() {
		return backupType;
	}

	/**
	 * @param backupType the backupType to set
	 */
	public void setBackupType(String backupType) {
		this.backupType = backupType;
	}

	/**
	 * @return the backupTime
	 */
	public String getBackupTime() {
		return backupTime;
	}

	/**
	 * @param backupTime the backupTime to set
	 */
	public void setBackupTime(String backupTime) {
		this.backupTime = backupTime;
	}

	/**
	 * @return the userId
	 */
	public int getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(int userId) {
		this.userId = userId;
	}

}