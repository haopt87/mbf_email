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
package org.agnitas.service;

import java.util.List;
import java.util.concurrent.Callable;

import org.agnitas.beans.AdminEntry;
import org.agnitas.web.forms.UserActivityLogForm;
import org.displaytag.pagination.PaginatedList;

/**
 * @author Viktor Gema
 */
public class UserActivityLogQueryWorker implements Callable<PaginatedList> {
    private UserActivityLogService userActivityLogService;
    private int adminID;
    private int pageNumber;
    private int rownums;
    private UserActivityLogForm aForm;
    private String sort;
    private String direction;
    private List<AdminEntry> admins;

    public UserActivityLogQueryWorker(UserActivityLogService userActivityLogService, int adminID, int pageNumber, int rownums, UserActivityLogForm aForm, String sort, String direction, List<AdminEntry> admins) {
        this.userActivityLogService = userActivityLogService;
        this.adminID = adminID;
        this.pageNumber = pageNumber;
        this.rownums = rownums;
        this.aForm=aForm;
        this.sort=sort;
        this.direction=direction;
        this.admins =admins;

    }

    public PaginatedList call() throws Exception {
        return userActivityLogService.getUserActivityLogByFilter(aForm, pageNumber, rownums, adminID, sort, direction, admins);
    }
}
