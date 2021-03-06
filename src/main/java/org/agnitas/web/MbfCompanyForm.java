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
public class MbfCompanyForm extends StrutsFormBase {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfCompanyForm.class);

	private static final long serialVersionUID = 0L;

	private int id;
	private String companyName;
	private String description;
	private int deleted;
	private int action;
	private int previousAction;
	private int disabled;
	private String disabledTag = "";

	public void clearAllData() {
		this.id = 0;
		this.companyName = "";
		this.description = "";
		this.deleted = 0;
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
	 * @return the disabledTag
	 */
	public String getDisabledTag() {
		if (this.disabled == 0) {
			disabledTag = "Đang hoạt động";
		} else {
			disabledTag = "Đang khóa";
		}
		return disabledTag;
	}

	/**
	 * @param disabledTag
	 *            the disabledTag to set
	 */
	public void setDisabledTag(String disabledTag) {
		this.disabledTag = disabledTag;
	}

	/**
	 * @return the disabled
	 */
	public int getDisabled() {
		return disabled;
	}

	/**
	 * @param disabled
	 *            the disabled to set
	 */
	public void setDisabled(int disabled) {
		this.disabled = disabled;
	}

}