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

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.agnitas.web.forms.StrutsFormBase;
import org.apache.log4j.Logger;

/**
 *
 * @author mobifone
 */
public class MbfComplainEmailForm extends StrutsFormBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfComplainEmailForm.class);

	private static final long serialVersionUID = 0L;

	private int id;
	private String customerName;
	private String customerMobile;
	private String emailAddress;
	private String otherInformation;
	private int status;
	private int deleted;

	private String statusName;
	private String subOtherInformation;

	private int action;
	private int previousAction;
	

	public void clearAllData() {
		this.id = 0;
		this.customerName = "";
		this.customerMobile = "";
		this.emailAddress = "";
		this.otherInformation = "";
		this.status = 0;
		this.deleted = 0;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the customerName
	 */
	public String getCustomerName() {
		return customerName;
	}

	/**
	 * @param customerName
	 *            the customerName to set
	 */
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	/**
	 * @return the customerMobile
	 */
	public String getCustomerMobile() {
		return customerMobile;
	}

	/**
	 * @param customerMobile
	 *            the customerMobile to set
	 */
	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}

	/**
	 * @return the emailAddress
	 */
	public String getEmailAddress() {
		return emailAddress;
	}

	/**
	 * @param emailAddress
	 *            the emailAddress to set
	 */
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return the deleted
	 */
	public int getDeleted() {
		return deleted;
	}

	/**
	 * @param deleted
	 *            the deleted to set
	 */
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	/**
	 * @return the action
	 */
	public int getAction() {
		return action;
	}

	/**
	 * @param action
	 *            the action to set
	 */
	public void setAction(int action) {
		this.action = action;
	}

	/**
	 * @return the previousAction
	 */
	public int getPreviousAction() {
		return previousAction;
	}

	/**
	 * @param previousAction
	 *            the previousAction to set
	 */
	public void setPreviousAction(int previousAction) {
		this.previousAction = previousAction;
	}

	/**
	 * @return the otherInformation
	 */
	public String getOtherInformation() {
		return otherInformation;
	}

	/**
	 * @param otherInformation
	 *            the otherInformation to set
	 */
	public void setOtherInformation(String otherInformation) {
		this.otherInformation = otherInformation;
	}

	/**
	 * @return the statusName
	 */
	public String getStatusName() {
		this.statusName = "Đã xử lý";
		switch (status) {
		case 0:
			this.statusName = "Chưa xử lý";
			break;
		case 1:
			this.statusName = "Chờ duyệt";
			break;
		case 2:
			this.statusName = "Đang xử lý";
			break;
		case 3:
			this.statusName = "Đã xử lý";
			break;
		default:
			this.statusName = "Đã xử lý";
			break;
		}
		return statusName;
	}

	/**
	 * @param statusName
	 *            the statusName to set
	 */
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	/**
	 * @return the subOtherInformation
	 */
	public String getSubOtherInformation() {
		if (otherInformation.length() < 40) {
			subOtherInformation = otherInformation + "....";
		} else {
			subOtherInformation = otherInformation.substring(0, 39) + "....";
		}
		return subOtherInformation;
	}

	/**
	 * @param subOtherInformation
	 *            the subOtherInformation to set
	 */
	public void setSubOtherInformation(String subOtherInformation) {
		this.subOtherInformation = subOtherInformation;
	}

}
