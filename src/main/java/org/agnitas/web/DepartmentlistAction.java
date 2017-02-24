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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.agnitas.beans.impl.DepartmentImpl;
import org.agnitas.beans.impl.MbfCompanyImpl;
import org.agnitas.dao.DepartmentDao;
import org.agnitas.emm.core.commons.util.ConfigService;
import org.agnitas.util.AgnUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.springframework.beans.factory.annotation.Required;

public class DepartmentlistAction extends StrutsActionBase {
	
	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(DepartmentlistAction.class);

    public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE = ACTION_LAST + 3;
    public static final int ACTION_MAILINGLIST_RECIPIENTS_CONFIRM_DELETE = ACTION_LAST + 4;
    public static final int ACTION_MAILINGLIST_RECIPIENTS_DELETE_YES = ACTION_LAST + 5;

	protected ConfigService configService;
	private DepartmentDao departmentDao;

	@Required
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws IOException, ServletException {

		System.out.println(DepartmentlistAction.class + "   xba Log");
		
		DepartmentlistForm aForm=null;
        ActionForward destination=null;
        ActionMessages errors = new ActionMessages();

        if (!AgnUtils.isUserLoggedIn(req)) {
            return mapping.findForward("logon");
        }

        if (form!=null) {
            aForm = (DepartmentlistForm)form;
        } else {
            aForm = new DepartmentlistForm();
        }

//		if (!allowed("department_mng.show", req)) {
//			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.permissionDenied"));
//			saveErrors(req, errors);
//			return null;
//		}
        
        try {
			switch (aForm.getAction()) {
			case DepartmentlistAction.ACTION_LIST:

				List<DepartmentImpl> lists = this.departmentDao.getDepartments();
				req.setAttribute("department_mngObjectList", lists);
				aForm.clearAllData();
				destination = mapping.findForward("list");
				break;

			case DepartmentlistAction.ACTION_VIEW:
				if (aForm.getId() != 0) {
					aForm.setAction(MbfCompanyAction.ACTION_SAVE);
					loadDepartment(aForm, req);
				} else {
					aForm.setAction(MbfCompanyAction.ACTION_NEW);
				}
				destination = mapping.findForward("view");
				break;
			case DepartmentlistAction.ACTION_SAVE:
				
				DepartmentImpl entity = this.departmentDao.getDepartment(aForm.getId());
				if (entity == null) {
					entity = new DepartmentImpl();
					entity.setId(0);
					entity.setDepartmentName(aForm.getDepartmentName());
					entity.setDescription(aForm.getDescription());
					entity.setDeleted(0);
				} else {
					entity.setId(aForm.getId());
					entity.setDepartmentName(aForm.getDepartmentName());
					entity.setDescription(aForm.getDescription());
					entity.setDeleted(0);
				}
				
				this.departmentDao.saveDepartment(entity);

				req.setAttribute("department_mngObjectList", this.departmentDao.getDepartments());
				aForm.clearAllData();
				
				destination = mapping.findForward("list");
				break;
			case ACTION_DELETE:
					this.departmentDao.deleteDepartment(aForm.getId());
					req.setAttribute("department_mngObjectList", this.departmentDao.getDepartments());
					aForm.clearAllData();
					destination = mapping.findForward("list");
				break;
			default:
				destination = mapping.findForward("list");
				break;
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			logger.error("execute: " + e, e);
			errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("error.exception",
					configService.getValue(ConfigService.Value.SupportEmergencyUrl)));
		}
        
        return destination;
    }
	
	private void loadDepartment(DepartmentlistForm aForm, HttpServletRequest req) {

		DepartmentImpl obj = this.departmentDao.getDepartment(aForm.getId());
		if (obj.getId() == 0) {
			logger.warn(
					"loadDepartment: could not load MbfCompanyImpl " + aForm.getId());
			obj = new DepartmentImpl();
			obj.setId(aForm.getId());
		}
		aForm.setDepartmentName(obj.getDepartmentName());
		aForm.setDescription(obj.getDescription());
	}

	/**
	 * @return the departmentDao
	 */
	public DepartmentDao getDepartmentDao() {
		return departmentDao;
	}

	/**
	 * @param departmentDao the departmentDao to set
	 */
	public void setDepartmentDao(DepartmentDao departmentDao) {
		this.departmentDao = departmentDao;
	}

}