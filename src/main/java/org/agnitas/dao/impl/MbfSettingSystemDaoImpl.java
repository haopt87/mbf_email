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
import java.util.Date;
import java.util.List;

import org.agnitas.beans.impl.MbfSettingSystemImpl;
import org.agnitas.dao.MbfSettingSystemDao;
import org.agnitas.web.ExportreportDataDetail;
import org.agnitas.web.ExportreportMailingBackendLogTbl;
import org.agnitas.web.ExportreportUser;
import org.agnitas.web.MbfSettingSystemForm;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

/**
 * 
 * @author aso
 */
public class MbfSettingSystemDaoImpl extends BaseDaoImpl implements MbfSettingSystemDao {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(MbfSettingSystemDaoImpl.class);

	protected class MbfSettingSystemImpl_RowMapper implements ParameterizedRowMapper<MbfSettingSystemImpl> {
		@Override
		public MbfSettingSystemImpl mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				MbfSettingSystemImpl readTarget = new MbfSettingSystemImpl();
				readTarget.setId(resultSet.getInt("id"));
				readTarget.setSendEmail(resultSet.getString("send_email"));
				readTarget.setReplyEmail(resultSet.getString("reply_email"));
				readTarget.setBackupType(resultSet.getInt("backup_type"));
				readTarget.setBackupTime(resultSet.getString("backup_time"));
				readTarget.setDeleted(resultSet.getInt("deleted"));
				readTarget.setLog_user_action(resultSet.getInt("log_user_action"));
				readTarget.setPrice_an_email(resultSet.getInt("price_an_email"));
				readTarget.setPriceAnEmail(resultSet.getInt("price_an_email"));
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	protected class ExportreportMailingBackendLogTbl_RowMapper
			implements ParameterizedRowMapper<ExportreportMailingBackendLogTbl> {
		@Override
		public ExportreportMailingBackendLogTbl mapRow(ResultSet resultSet, int row) throws SQLException {
			try {

				ExportreportMailingBackendLogTbl readTarget = new ExportreportMailingBackendLogTbl();
				readTarget.setMailing_id(resultSet.getInt("mailing_id"));
				readTarget.setCurrent_mails(resultSet.getInt("current_mails"));
				readTarget.setTotal_mails(resultSet.getInt("total_mails"));
				readTarget.setStatus_id(resultSet.getInt("status_id"));
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	
	
	
	protected class ExportreportUser_RowMapper implements ParameterizedRowMapper<ExportreportUser> {
		@Override
		public ExportreportUser mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				ExportreportUser readTarget = new ExportreportUser();
				readTarget.setId(resultSet.getInt("admin_id"));
				readTarget.setUsername(resultSet.getString("username"));
				readTarget.setFullname(resultSet.getString("fullname"));
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}
	

	protected class ExportreportDataDetail_RowMapper implements ParameterizedRowMapper<ExportreportDataDetail> {
		@Override
		public ExportreportDataDetail mapRow(ResultSet resultSet, int row) throws SQLException {
			try {
				ExportreportDataDetail readTarget = new ExportreportDataDetail();
				
				readTarget.setMailing_id(resultSet.getInt("mailtrack_id"));
				readTarget.setCustomer_id(resultSet.getInt("customer_id"));
				readTarget.setMailing_id(resultSet.getInt("mailing_id"));
				readTarget.setCompany_id(resultSet.getInt("company_id"));
				readTarget.setChange_date(resultSet.getTimestamp("change_date"));
				readTarget.setStatus_id(resultSet.getInt("status_id"));
				
				readTarget.setEmail(resultSet.getString("email"));
				readTarget.setGender(resultSet.getInt("gender"));
				readTarget.setMailtype(resultSet.getInt("mailtype"));
				readTarget.setFirstname(resultSet.getString("firstname"));
				readTarget.setLastname(resultSet.getString("lastname"));
				
				readTarget.setShortname(resultSet.getString("shortname"));
				readTarget.setCreation_date(resultSet.getTimestamp("creation_date"));
								
				return readTarget;
			} catch (Exception e) {
				throw new SQLException("Cannot create Department item from ResultSet row", e);
			}
		}
	}

	@Override
	public List<ExportreportDataDetail> getExportreportDataDetail(int mailing_id, int status_id) {
		
		List<ExportreportDataDetail> lists = select(logger,
				" SELECT mailtrack_tbl.mailtrack_id, mailtrack_tbl.customer_id, mailtrack_tbl.mailing_id, " +
					 " mailtrack_tbl.company_id, mailtrack_tbl.change_date, mailtrack_tbl.status_id, " +
					 " customer_1_tbl.email, customer_1_tbl.gender, customer_1_tbl.mailtype, customer_1_tbl.firstname, " + 
					 " customer_1_tbl.lastname, " +
					 " mailing_tbl.shortname, mailing_tbl.creation_date  " +
				" FROM mailtrack_tbl, customer_1_tbl , mailing_tbl " +
				" WHERE mailtrack_tbl.customer_id = customer_1_tbl.customer_id  AND mailing_tbl.mailing_id = mailtrack_tbl.mailing_id " +
					" AND mailtrack_tbl.mailing_id = " + mailing_id +
						" AND mailtrack_tbl.status_id = " + status_id,
				new ExportreportDataDetail_RowMapper());
		return lists;
	}
	

	@Override
	public List<ExportreportMailingBackendLogTbl> getExportreportMailingBackendLogTblById(int id) {

		List<ExportreportMailingBackendLogTbl> lists = select(logger,
				"select * from mailing_backend_log_tbl where mbf_user_id = " + id,
				new ExportreportMailingBackendLogTbl_RowMapper());
		
		return lists;
	}

	@Override
	public List<ExportreportUser> getExportreportUsers() {

		List<ExportreportUser> lists = select(logger,
				"SELECT admin_id, username, fullname FROM admin_tbl WHERE disabled = 0",
				new ExportreportUser_RowMapper());
		return lists;
	}

	@Override
	public ExportreportUser getExportreportUser(int id) {

		return selectObjectDefaultNull(logger,
				"SELECT  admin_id, username, fullname FROM admin_tbl WHERE disabled = 0 AND id = ?",
				new ExportreportUser_RowMapper(), id);
	}
	
	@Override
	public MbfSettingSystemImpl getMbfSettingSystemImpl(int id) {

		return selectObjectDefaultNull(logger,
				"SELECT id, send_email, reply_email, backup_type, backup_time, deleted, log_user_action, price_an_email FROM mbf_setting_system WHERE deleted = 0 AND id = ? ",
				new MbfSettingSystemImpl_RowMapper(), id);
	}
	
	@Override
	public void saveMbfSettingSystemImplAFrom(MbfSettingSystemForm entity) {
		update(logger,
				"UPDATE mbf_setting_system SET send_email = ?, reply_email = ? ,"
						+ " backup_type = ? , backup_time = ? , deleted = ? , log_user_action = ? , price_an_email = ?  WHERE id = ?",
				entity.getSendEmail(), entity.getReplyEmail(), entity.getBackupType(), entity.getBackupTime(), entity.getDeleted(),
				entity.getLogUserType(), entity.getPriceAnEmail(), 
				entity.getId());
	}
	
	@Override
	public void saveMbfSettingSystemImpl(MbfSettingSystemImpl entity) {

		if (entity.getId() == 0) {
			// SqlUpdate sqlUpdate = new SqlUpdate(getDataSource(),
			// "INSERT INTO mbf_company_tbl (company_name, description, deleted,
			// disabled) VALUES (?, ?, ?, ?)",
			// new int[] { Types.VARCHAR, Types.VARCHAR, Types.INTEGER,
			// Types.INTEGER});
			//
			// sqlUpdate.setReturnGeneratedKeys(true);
			// sqlUpdate.setGeneratedKeysColumnNames(new String[] { "id" });
			// sqlUpdate.compile();
			// GeneratedKeyHolder key = new GeneratedKeyHolder();
			//
			// Object[] paramsWithNext = new Object[4];
			// paramsWithNext[0] = entity.getCompanyName();
			// paramsWithNext[1] = entity.getDescription();
			// paramsWithNext[2] = entity.getDeleted();
			// paramsWithNext[3] = entity.getDisabled();
			//
			// sqlUpdate.update(paramsWithNext, key);
			//
			// int newID = key.getKey().intValue();
			// entity.setId(newID);
		} else {
			update(logger,
					"UPDATE mbf_setting_system SET send_email = ?, reply_email = ? ,"
							+ " backup_type = ? , backup_time = ? WHERE id = ?",
					entity.getSendEmail(), entity.getReplyEmail(), entity.getBackupType(), entity.getBackupTime(),
					entity.getId());
		}
	}

	@Override
	public void deleteMbfSettingSystemImpl(int id) {
		update(logger, "UPDATE mbf_company_tbl SET deleted = 1 WHERE id = ? ", id);
	}

	@Override
	public List<MbfSettingSystemImpl> getMbfSettingSystemImpls() {

		List<MbfSettingSystemImpl> lists = select(logger,
				"SELECT id, send_email, reply_email, backup_type, backup_time, deleted FROM mbf_setting_system WHERE deleted = 0",
				new MbfSettingSystemImpl_RowMapper());
		return lists;
	}

}
