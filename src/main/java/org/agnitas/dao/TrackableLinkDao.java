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

package org.agnitas.dao;

import org.agnitas.beans.TrackableLink;
import org.agnitas.emm.core.velocity.VelocityCheck;

/**
 *
 * @author mhe
 */
public interface TrackableLinkDao {
    /**
     * Deletes trackableLink.
     *
     * @return true==success
     *false==errror
     */
    public boolean deleteTrackableLink(int linkID, @VelocityCheck int companyID);

    /**
     * Getter for property trackableLink by link id and company id.
     *
     * @return Value of trackableLink.
     */
    public TrackableLink getTrackableLink(int linkID, @VelocityCheck int companyID);
    
    /**
     * Getter for property trackableLink by link id and company id.
     *
     * @return Value of trackableLink.
     */
    public TrackableLink getTrackableLink(String url, @VelocityCheck int companyID, int mailingID);

    /**
     * Saves trackableLink.
     *
     * @return Saved trackableLink id.
     * @throws Exception 
     */
    public int saveTrackableLink(TrackableLink link);

  //  public boolean setDeeptracking(int deepTracking, @VelocityCheck int companyID, int mailingID);

	/**
	 * Logs a click for trackable link in rdirlog_tbl
	 *
	 * @param link the link which was clicked.
	 * @param customerID the id of the recipient who clicked the link.
	 * @param remoteAddr the ip address of the recipient. 
	 * @return True on success.
	 */
    public boolean logClickInDB(TrackableLink link, int customerID, String remoteAddr);
}
