package org.agnitas.beans.impl;

import java.io.Serializable;

public class MbfCompanyImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;

	private String companyName;

	private String description;

	private int deleted;

	public MbfCompanyImpl() {
	}

	public MbfCompanyImpl(int id, String companyName, String description, int statusDelete) {
		this.id = id;
		this.companyName = companyName;
		this.description = description;
		this.deleted = statusDelete;
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
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
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
	 * @return the companyName
	 */
	public String getCompanyName() {
		return companyName;
	}

	/**
	 * @param companyName
	 *            the companyName to set
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
}