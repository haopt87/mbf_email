package org.agnitas.beans.impl;

import java.io.Serializable;
import java.util.Date;

public class MbfSettingSystemImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String sendEmail;
	private String replyEmail;
	private String backupType;
	private String backupTime;
	private int deleted;

	public MbfSettingSystemImpl() {
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

	public String getBackupType() {
		return backupType;
	}

	public void setBackupType(String backupType) {
		this.backupType = backupType;
	}

	public String getBackupTime() {
		return backupTime;
	}

	public void setBackupTime(String backupTime) {
		this.backupTime = backupTime;
	}

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}


}