package org.agnitas.beans.impl;

import java.io.Serializable;
import java.util.Date;

public class MbfExportImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String fullName;
	private String userName;
	private int totalMailsOfCampain;
    private Date creationDate;;
    private String campainName;
    
	public MbfExportImpl() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getTotalMailsOfCampain() {
		return totalMailsOfCampain;
	}

	public void setTotalMailsOfCampain(int totalMailsOfCampain) {
		this.totalMailsOfCampain = totalMailsOfCampain;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	/**
	 * @return the campainName
	 */
	public String getCampainName() {
		return campainName;
	}

	/**
	 * @param campainName the campainName to set
	 */
	public void setCampainName(String campainName) {
		this.campainName = campainName;
	}
	

}