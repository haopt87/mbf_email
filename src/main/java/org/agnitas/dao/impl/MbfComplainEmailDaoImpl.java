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
import java.util.Date;
import java.util.List;

import org.agnitas.beans.impl.MbfComplainEmailImpl;
import org.agnitas.dao.MbfComplainEmailDao;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.object.SqlUpdate;
import org.springframework.jdbc.support.GeneratedKeyHolder;

/**
 * 
 * @author aso
 */
public class MbfComplainEmailDaoImpl extends BaseDaoImpl implements MbfComplainEmailDao {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfComplainEmailDaoImpl.class);

	@Override
	public MbfComplainEmailImpl getMbfComplainEmail(int id) {

		return selectObjectDefaultNull(logger,
				"SELECT * FROM mbf_complain_email_tbl WHERE id = ? ",
				new MbfComplainEmail_RowMapper(), id);
	}

	protected class MbfComplainEmail_RowMapper implements ParameterizedRowMapper<MbfComplainEmailImpl> {
		@Override
		public MbfComplainEmailImpl mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				MbfComplainEmailImpl readTarget = new MbfComplainEmailImpl();
				readTarget.setId(resultSet.getInt("id"));
				readTarget.setCustomerName(resultSet.getString("customer_name"));
				readTarget.setCustomerMobile(resultSet.getString("customer_mobile"));
				readTarget.setEmailAddress(resultSet.getString("email_address"));
				readTarget.setOtherInformation(resultSet.getString("other_information"));
				readTarget.setResolveInformation(resultSet.getString("resolve_information"));
				readTarget.setStatus(resultSet.getInt("status"));
				readTarget.setDeleted(resultSet.getInt("deleted"));
				readTarget.setCreationDate(resultSet.getTime("creation_date"));
				readTarget.setResolveDate(resultSet.getTime("resolve_date"));
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	@Override
	public void saveMbfComplainEmail(MbfComplainEmailImpl entity) {

		if (entity.getId() == 0) {
			SqlUpdate sqlUpdate = new SqlUpdate(getDataSource(),
					"INSERT INTO mbf_complain_email_tbl (customer_name, customer_mobile, email_address, other_information,"
					+ " resolve_information, status, deleted, creation_date, resolve_date)"
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
					new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.TIMESTAMP, Types.DATE});

			sqlUpdate.setReturnGeneratedKeys(true);
			sqlUpdate.setGeneratedKeysColumnNames(new String[] { "id" });
			sqlUpdate.compile();
			GeneratedKeyHolder key = new GeneratedKeyHolder();

			Object[] paramsWithNext = new Object[9];
			paramsWithNext[0] = entity.getCustomerName();
			paramsWithNext[1] = entity.getCustomerMobile();
			paramsWithNext[2] = entity.getEmailAddress();
			paramsWithNext[3] = entity.getOtherInformation();
			paramsWithNext[4] = entity.getResolveInformation();
			paramsWithNext[5] = entity.getStatus();
			paramsWithNext[6] = entity.getDeleted();
			paramsWithNext[7] = new Date();
			paramsWithNext[8] = null;

			sqlUpdate.update(paramsWithNext, key);
			int newID = key.getKey().intValue();
			entity.setId(newID);
		} else {
			update(logger, "UPDATE mbf_complain_email_tbl SET customer_name = ?, customer_mobile = ? , "
					+ " email_address = ? , other_information = ?, resolve_information =?, status = ?, resolve_date = ? WHERE id = ?",
					entity.getCustomerName(), entity.getCustomerMobile(), entity.getEmailAddress(), 
					entity.getOtherInformation(), entity.getResolveInformation(), entity.getStatus(), new Date(), entity.getId());
		}
	}
	
	@Override
	public void deleteMbfComplainEmail(int id) {
		update(logger,
				"UPDATE mbf_complain_email_tbl SET deleted = 1 WHERE id = ? ", id);
	}
	
	@Override
	public List<MbfComplainEmailImpl> getMbfComplainEmails() {

		List<MbfComplainEmailImpl> lists = select(logger,
				"SELECT id, customer_name, customer_mobile, email_address, other_information, resolve_information, "
				+ "status, deleted, creation_date, resolve_date FROM mbf_complain_email_tbl WHERE deleted = 0",
				new MbfComplainEmail_RowMapper());
		return lists;
	}
	
}
