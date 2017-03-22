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

package org.agnitas.beans;

import java.sql.Timestamp;

public interface AdminEntry {
    public String getUsername();

    public String getFullname();

    public String getFirstname();

    public String getShortname();

    public String getEmail();

    public void setEmail(String email);

    public int getId();
    
    public Timestamp getChangeDate();

	public void setChangeDate(Timestamp changeDate);

	public Timestamp getCreationDate();

	public void setCreationDate(Timestamp creationDate);
	
	public int getDisabled();
	public void setDisabled(int disabled);
	public String getDisabledTag();
	public int getSendSpeed();
	public void setSendSpeed(int sendSpeed);
	public int getSendByDay();
	public void setSendByDay(int sendByDay);
	public int getReplyByDay();
	public void setReplyByDay(int replyByDay);
	public int getSendByMonth();
	public void setSendByMonth(int sendByMonth);
	public int getExtendTenPercent();
	public void setExtendTenPercent(int extendTenPercent);
	public int getBoundByMonth();
	public void setBoundByMonth(int boundByMonth);
	
	

}