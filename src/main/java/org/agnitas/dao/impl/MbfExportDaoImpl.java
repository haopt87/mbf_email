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
import java.util.List;

import org.agnitas.beans.impl.MbfComplainEmailImpl;
import org.agnitas.beans.impl.MbfExportImpl;
import org.agnitas.dao.MbfExportDao;
import org.agnitas.dao.impl.MbfComplainEmailDaoImpl.MbfComplainEmail_RowMapper;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

/**
 * 
 * @author aso
 */
public class MbfExportDaoImpl extends BaseDaoImpl implements MbfExportDao {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfExportDaoImpl.class);

	@Override
	public MbfExportImpl getMbfExportImpl(int id) {

		String query = "SELECT adm.admin_id, adm.username, adm.fullname, mblt.current_mails, mblt.total_mails, mblt.creation_date"
				+ "FROM admin_tbl adm, mailing_backend_log_tbl mblt"
				+ " where adm.admin_id = mblt.mbf_user_id AND mblt.mbf_user_id = ?";
		
		return selectObjectDefaultNull(logger, query, new MbfExportImpl_RowMapper(), id);
	}

	protected class MbfExportImpl_RowMapper implements ParameterizedRowMapper<MbfExportImpl> {
		@Override
		public MbfExportImpl mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				MbfExportImpl readTarget = new MbfExportImpl();
				 readTarget.setId(resultSet.getInt("admin_id"));
				 readTarget.setUserName(resultSet.getString("username"));
				 readTarget.setFullName(resultSet.getString("fullname"));
				 readTarget.setTotalMailsOfCampain(resultSet.getInt("total_mails"));
				 readTarget.setCreationDate(resultSet.getTimestamp("creation_date"));
				 readTarget.setCampainName(resultSet.getString("shortname"));
				 
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	@Override
	public List<MbfExportImpl> getMbfExportImpls(int id) {
		List<MbfExportImpl> lists = select(logger,
				"SELECT adm.admin_id, adm.username, adm.fullname, mblt.current_mails, mblt.total_mails, mblt.creation_date, mail.shortname "
						 + " FROM admin_tbl adm, mailing_backend_log_tbl mblt, mailing_tbl mail" 
						 + " where adm.admin_id = mblt.mbf_user_id AND mblt.mailing_id = mail.mailing_id  AND mblt.mbf_user_id =" + id,
								 new MbfExportImpl_RowMapper());
						 
//		List<MbfExportImpl> lists = select(logger,
//				"SELECT adm.admin_id, adm.username, adm.fullname, mblt.current_mails, mblt.total_mails, mblt.creation_date"
//						+ " FROM admin_tbl adm, mailing_backend_log_tbl mblt"
//						+ " where adm.admin_id = mblt.mbf_user_id AND mblt.mbf_user_id = " + id,
//				new MbfExportImpl_RowMapper());
		
		return lists;
	}

}
