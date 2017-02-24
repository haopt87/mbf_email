package org.agnitas.emm.extension.sqlparser.validator.impl;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.agnitas.emm.extension.exceptions.DatabaseScriptException;
import org.apache.log4j.Logger;

/**
 * Implementation of the StatementValidation interface providing validation of the <code>CREATE TABLE...</code> statemtn.
 * 
 * @author md
 *
 * @see StatementValidation
 */
class CreateTableValidation extends BasicValidation {
	private static final transient Logger logger = Logger.getLogger(CreateTableValidation.class);
	
	/** Regular expression used for statement recognition. */
	private final Pattern CREATE_TABLE_PATTERN = Pattern.compile( "^\\s*create\\s+table\\s+(?:if\\s+not\\s+exists\\s+)?(.*?)\\s*\\((.*)\\)[^)]*$", Pattern.CASE_INSENSITIVE | Pattern.DOTALL | Pattern.UNICODE_CASE);

	@Override
	public boolean validate(String statement, String namePrefix) throws DatabaseScriptException {
		Matcher matcher = CREATE_TABLE_PATTERN.matcher( statement);
		
		if( !matcher.matches()) {
			if( logger.isInfoEnabled())
				logger.info( "Statement does not match regular expression");
			
			return false;
		}
		
		String tableName = matcher.group( 1);
		String columnDefinitions = matcher.group( 2);

		if( logger.isDebugEnabled()) {
			logger.debug( "table: " + tableName);
			logger.debug( "columns: " + columnDefinitions);
		}
		
		validateTableName( tableName, namePrefix);
		
		return true;
	}
	
}
