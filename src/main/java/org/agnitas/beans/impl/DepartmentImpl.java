package org.agnitas.beans.impl;

import java.io.Serializable;

public class DepartmentImpl implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private int companyId;
	private String departmentName;
	private String description;
	private int deleted;
	private int disabled;

	public DepartmentImpl() {
	}

	public DepartmentImpl(int id, String departmentName, String description, int statusDelete) {
		this.id = id;
		this.departmentName = departmentName;
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
	 * @return the departmentName
	 */
	public String getDepartmentName() {
		return departmentName;
	}

	/**
	 * @param departmentName
	 *            the departmentName to set
	 */
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	/**
	 * @return the deleted
	 */
	public int getDeleted() {
		return deleted;
	}

	/**
	 * @param deleted the deleted to set
	 */
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	/**
	 * @return the companyId
	 */
	public int getCompanyId() {
		return companyId;
	}

	/**
	 * @param companyId the companyId to set
	 */
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	/**
	 * @return the disabled
	 */
	public int getDisabled() {
		return disabled;
	}

	/**
	 * @param disabled the disabled to set
	 */
	public void setDisabled(int disabled) {
		this.disabled = disabled;
	}

}