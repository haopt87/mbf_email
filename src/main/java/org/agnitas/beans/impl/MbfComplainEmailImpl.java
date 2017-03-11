package org.agnitas.beans.impl;

import java.io.Serializable;

public class MbfComplainEmailImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String customerName;
	private String customerMobile;
	private String emailAddress;
	private String otherInformation;
	private int status;
	private int deleted;

	public MbfComplainEmailImpl() {
	}

	public MbfComplainEmailImpl(int id, String customerName, String customerMobile, String emailAddress,
			String otherInfomation, int status, int deleted) {
		super();
		this.id = id;
		this.customerName = customerName;
		this.customerMobile = customerMobile;
		this.emailAddress = emailAddress;
		this.otherInformation = otherInfomation;
		this.status = status;
		this.deleted = deleted;
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
	 * @return the otherInfomation
	 */
	public String getOtherInformation() {
		return otherInformation;
	}

	/**
	 * @param otherInfomation
	 *            the otherInfomation to set
	 */
	public void setOtherInformation(String otherInfomation) {
		this.otherInformation = otherInfomation;
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

}