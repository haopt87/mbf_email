package org.agnitas.beans.impl;

import java.io.Serializable;
import java.util.Date;

public class MbfSettingSystemImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String sendEmail;
	private String replyEmail;
	private int backupType;
	private int priceAnEmail;
	private String backupTime;
	private int deleted;
	private int log_user_action;
	private int price_an_email;

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

	public int getBackupType() {
		return backupType;
	}

	public void setBackupType(int backupType) {
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

	/**
	 * @return the priceAnEmail
	 */
	public int getPriceAnEmail() {
		return priceAnEmail;
	}

	/**
	 * @param priceAnEmail the priceAnEmail to set
	 */
	public void setPriceAnEmail(int priceAnEmail) {
		this.priceAnEmail = priceAnEmail;
	}

	/**
	 * @return the price_an_email
	 */
	public int getPrice_an_email() {
		return price_an_email;
	}

	/**
	 * @param price_an_email the price_an_email to set
	 */
	public void setPrice_an_email(int price_an_email) {
		this.price_an_email = price_an_email;
	}

	/**
	 * @return the log_user_action
	 */
	public int getLog_user_action() {
		return log_user_action;
	}

	/**
	 * @param log_user_action the log_user_action to set
	 */
	public void setLog_user_action(int log_user_action) {
		this.log_user_action = log_user_action;
	}


}