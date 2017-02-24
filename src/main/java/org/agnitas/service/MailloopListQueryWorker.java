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

import java.util.concurrent.Callable;

import org.agnitas.dao.MailloopDao;
import org.agnitas.emm.core.velocity.VelocityCheck;
import org.displaytag.pagination.PaginatedList;

/**
 * wrapper for a long sql query. It will be used for asynchronous tasks
 * @author viktor gema
 *
 */
public class MailloopListQueryWorker implements Callable<PaginatedList> {
	private MailloopDao mailloopDao;
	private String sort;
	private String direction;
	private int page;
	private int rownums;
	private int companyID;

    public MailloopListQueryWorker(MailloopDao dao, @VelocityCheck int companyID, String sort, String direction, int page, int rownums ) {
		this.mailloopDao = dao;
		this.sort = sort;
		this.direction = direction;
		this.page = page;
		this.rownums = rownums;
		this.companyID = companyID;
	}

    public PaginatedList call() throws Exception {
	   return mailloopDao.getMailloopList(companyID, sort, direction, page, rownums);
	}
}