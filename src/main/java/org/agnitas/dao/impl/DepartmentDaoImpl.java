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

package org.agnitas.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.agnitas.beans.impl.DepartmentImpl;
import org.agnitas.dao.DepartmentDao;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.object.SqlUpdate;
import org.springframework.jdbc.support.GeneratedKeyHolder;

/**
 * 
 * @author aso
 */
public class DepartmentDaoImpl extends BaseDaoImpl implements DepartmentDao {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(DepartmentDaoImpl.class);

	@Override
	public DepartmentImpl getDepartment(int id) {

		return selectObjectDefaultNull(logger,
				"SELECT id, company_id, department_name, description, deleted, disabled FROM mbf_department_tbl WHERE id = ? ",
				new Department_RowMapper(), id);
	}

	protected class Department_RowMapper implements ParameterizedRowMapper<DepartmentImpl> {
		@Override
		public DepartmentImpl mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				DepartmentImpl readTarget = new DepartmentImpl();
				readTarget.setId(resultSet.getInt("id"));
				readTarget.setCompanyId(resultSet.getInt("company_id"));
				readTarget.setDepartmentName(resultSet.getString("department_name"));
				readTarget.setDescription(resultSet.getString("description"));
				readTarget.setDeleted(resultSet.getInt("deleted"));
				readTarget.setDisabled(resultSet.getInt("disabled"));
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	@Override
	public void saveDepartment(DepartmentImpl entity) {
		if (entity.getId() == 0) {
			SqlUpdate sqlUpdate = new SqlUpdate(getDataSource(),
					"INSERT INTO mbf_department_tbl (company_id, department_name, description, deleted, disabled) VALUES (?, ?, ?, ?, ?)",
					new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.INTEGER , Types.INTEGER });

			sqlUpdate.setReturnGeneratedKeys(true);
			sqlUpdate.setGeneratedKeysColumnNames(new String[] { "id" });
			sqlUpdate.compile();
			GeneratedKeyHolder key = new GeneratedKeyHolder();

			Object[] paramsWithNext = new Object[5];
			paramsWithNext[0] = entity.getCompanyId();
			paramsWithNext[1] = entity.getDepartmentName();
			paramsWithNext[2] = entity.getDescription();
			paramsWithNext[3] = entity.getDeleted();
			paramsWithNext[4] = entity.getDisabled();

			sqlUpdate.update(paramsWithNext, key);
			
			int newID = key.getKey().intValue();
			entity.setId(newID);
		} else {
			update(logger, "UPDATE mbf_department_tbl SET department_name = ?, description = ?, company_id=? WHERE id = ?",
					entity.getDepartmentName(), entity.getDescription(), entity.getCompanyId(), entity.getId());
		}
	}
	
	@Override
	public void disabledDepartment(int id, int stattus) {
		update(logger, "UPDATE mbf_department_tbl SET disabled = ? WHERE id = ? ", stattus, id);
	}

	@Override
	public void deleteDepartment(int id) {
		update(logger, "UPDATE mbf_department_tbl SET deleted = 1 WHERE id = ? ", id);
	}
	
	@Override
	public boolean checkDepartmentByCompany(int companyId) {
		return selectInt(logger, "SELECT COUNT(*) FROM mbf_department_tbl WHERE deleted = 0 AND company_id = ?", companyId) > 0; 
	}
	
	@Override
	public List<DepartmentImpl> getDepartments() {

		List<DepartmentImpl> departmentImpls = select(logger,
				"SELECT id, company_id, department_name, description, deleted, disabled FROM mbf_department_tbl WHERE deleted = 0",
				new Department_RowMapper());
		return departmentImpls;
	}

	@Override
	public boolean departmentExists(String departmentName, Integer company_id) {
		return selectInt(logger, "SELECT COUNT(*) FROM mbf_department_tbl WHERE deleted=0 AND department_name = ? AND company_id = ?", departmentName, company_id) > 0;
	}

	@Override
	public List<DepartmentImpl> getDepartmentsByCompanyId(int companyId) {
		String strQuery = "SELECT id, company_id, department_name, description, deleted, disabled FROM mbf_department_tbl WHERE company_id = " + companyId + " AND deleted = 0"; 
		List<DepartmentImpl> departmentImpls = select(logger,strQuery, new Department_RowMapper());
		return departmentImpls;
	}

}