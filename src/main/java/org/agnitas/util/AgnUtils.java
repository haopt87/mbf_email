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

package org.agnitas.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.TimeZone;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import javax.sql.DataSource;

import org.agnitas.backend.StringOps;
import org.agnitas.beans.Admin;
import org.agnitas.beans.AdminPreferences;
import org.agnitas.beans.Company;
import org.agnitas.dao.CompanyDao;
import org.agnitas.emm.core.velocity.VelocityCheck;
import org.apache.axis.encoding.Base64;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.mail.ByteArrayDataSource;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.validator.EmailValidator;
import org.apache.log4j.Logger;
import org.apache.velocity.exception.MethodInvocationException;
import org.apache.velocity.exception.ParseErrorException;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import bsh.Interpreter;
import bsh.NameSpace;

/**
 *
 * @author mhe, Nicole Serek
 */
public class AgnUtils {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(AgnUtils.class);

	private static Configuration config;
	public static final String DEFAULT_MAILING_HTML_DYNNAME = "HTML-Version";
	public static final String DEFAULT_MAILING_MHTML_DYNNAME = "M-HTML-Version";
	public static final String DEFAULT_MAILING_TEXT_DYNNAME = "Text";

	public static final String[] SUPPORTED_LOCALES = { "de", "de_AT", "de_TW",
			"es", "fr", "nl", "pt", "tr", "zh" };

	private static ResourceBundle defaults = null;

	/**
	 * Extension of {@link FileDataSource} with specifiable content type.
	 *
	 * @author md
	 */
	public static class AgnFileDataSource extends FileDataSource {

		/** Content type. */
		private final String contentType;

		/**
		 * Creates new {@link AgnFileDataSource} for given file and content type.
		 *
		 * @param file file used as source
		 * @param contentType content type
		 */
		public AgnFileDataSource(File file, String contentType) {
			super(file);

			this.contentType = contentType;
		}

		/**
		 * Returns content type.
		 *
		 * @return content type
		 */
		@Override
		public String getContentType() {
			return this.contentType;
		}
	}

	/**
	 * Getter for property currentVersion
	 *
	 * @return version the current version
	 */
	public static String getCurrentVersion() {
		return isOracleDB() ? "15.00" : "2015_R3";
	}

	/**
	 * constant
	 */
	protected static long lastErrorMailingSent = 0;

	/**
	 * Checks if we are running on Oracle
	 */
	public static boolean isOracleDB() {
		org.hibernate.dialect.Dialect dialect = AgnUtils.getHibernateDialect();

		if (dialect instanceof org.hibernate.dialect.Oracle9Dialect
				|| dialect instanceof org.hibernate.dialect.OracleDialect) {
			return true;
		}
		return false;
	}

	/**
	 * returns a date string
	 */
	public static String sqlDateString(String field, String format) {
		if (isOracleDB()) {
			return "TO_CHAR(" + field + ", '" + format + "')";
		} else {
			format = format.replaceAll("yyyy", "%Y");
			format = format.replaceAll("yy", "%y");
			format = format.replaceAll("mm", "%m");
			format = format.replaceAll("dd", "%d");
			return "date_format(" + field + ", '" + format + "')";
		}
	}

	/**
	 * returns the name for the change date field
	 */
	public static String changeDateName() {
		if (isOracleDB()) {
			return "TIMESTAMP";
		} else {
			if (isProjectEMM()) {
				return "TIMESTAMP";
			} else {
				return "change_date";
			}
		}
	}

	// only return true every 30 Seconds
	public static synchronized boolean sendErrorMailingInterval() {
		boolean result = false;
		if (System.currentTimeMillis() - AgnUtils.lastErrorMailingSent > 600000) {
			AgnUtils.lastErrorMailingSent = System.currentTimeMillis();
			result = true;
		}
		return result;
	}

	/**
	 * Getter for property jdbcTemplate.
	 *
	 * @return Value of property jdbcTemplate.
	 *
	 * @Deprecated
	 */
	public static synchronized JdbcTemplate getJdbcTemplate(
			org.springframework.context.ApplicationContext aContext) {
		return new JdbcTemplate((DataSource) aContext.getBean("dataSource"));
	}

	/**
	 * Getter for property dataSource.
	 *
	 * @return Value of property dataSource.
	 */
	public static synchronized DataSource retrieveDataSource(ServletContext aContext) {
		return (DataSource) org.springframework.web.context.support.WebApplicationContextUtils
				.getWebApplicationContext(aContext).getBean("dataSource");
	}

	/**
	 * Getter for property sessionFactory.
	 *
	 * @return Value of property sessionFactory.
	 */
	public static synchronized SessionFactory retrieveSessionFactory(ServletContext aContext) {
		SessionFactory aSource = null;

		aSource = (SessionFactory) org.springframework.web.context.support.WebApplicationContextUtils
				.getWebApplicationContext(aContext).getBean("sessionFactory");

		return aSource;
	}

	/**
	 * Sends an email in the correspondent type.
	 */
	public static boolean sendEmail(String from_adr, String to_adrList, String subject,
			String body_text, String body_html, int mailtype, String charset) {
		return sendEmail(from_adr, to_adrList, null, subject, body_text, body_html, mailtype, charset);
	}

	/**
	 * Sends an email in the correspondent type.
	 */
	public static boolean sendEmail(String from_adr, String to_adrList,
			String cc_adrList, String subject, String body_text,
			String body_html, int mailtype, String charset) {
		try {
			// create some properties and get the default Session
			Properties props = new Properties();
			// TODO: Not a valid property name?
			props.put("system.mail.host", getSmtpMailRelayHostname());
			props.put("mail.smtp.host", getSmtpMailRelayHostname());
			props.put("mail.host", getSmtpMailRelayHostname());
			Session session = Session.getDefaultInstance(props, null);
			// session.setDebug(debug);

			// create a message
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from_adr));
			msg.setSubject(subject, charset);
			msg.setSentDate(new Date());

			// Set to-recipient email addresses
			InternetAddress[] toAddresses = getEmailAddressesFromList(to_adrList);
			if (toAddresses != null && toAddresses.length > 0) {
				msg.setRecipients(Message.RecipientType.TO, toAddresses);
			}

			// Set cc-recipient email addresses
			InternetAddress[] ccAddresses = getEmailAddressesFromList(cc_adrList);
			if (ccAddresses != null && ccAddresses.length > 0) {
				msg.setRecipients(Message.RecipientType.CC, ccAddresses);
			}

			switch (mailtype) {
			case 0:
				msg.setText(body_text == null ? "" : body_text, charset);
				break;

			case 1:
				Multipart mp = new MimeMultipart("alternative");
				MimeBodyPart mbp = new MimeBodyPart();
				mbp.setText(body_text == null ? "" : body_text, charset);
				mp.addBodyPart(mbp);
				mbp = new MimeBodyPart();
				mbp.setContent(body_html, "text/html; charset=" + charset);
				mp.addBodyPart(mbp);
				msg.setContent(mp);
				break;
			}
			Transport.send(msg);
		} catch (Exception e) {
			logger.error("Error sending email in sendEmail()", e);
			return false;
		}
		return true;
	}

	/**
	 * Log an Exception Logs the given comment, exception text and stack trace
	 * to error log and sends an email to the address taken from
	 * mailaddress.error property.
	 *
	 * @param comment
	 *            Text that is added before the exception.
	 * @param e
	 *            The exception to log.
	 * @return true if all went ok.
	 */
	public static boolean sendExceptionMail(String comment, Exception e) {
		String targetMail = AgnUtils.getDefaultValue("mailaddress.error");

		String senderAddress = AgnUtils.getDefaultValue("mailaddress.sender");
		if (StringUtils.isBlank(senderAddress)) {
			senderAddress = AgnUtils.getHostName() + "@agnitas.de";
		}

		StringBuilder messageBuilder = new StringBuilder();
		if (comment != null) {
			messageBuilder.append(comment + "\n");
		}
		messageBuilder.append("Exception:\n" + throwableToString(e, -1));

		String subjectText = "EMM Error (Server: " + getHostName() + " / Exceptiontyp: " + e.getClass().getSimpleName() + ")";

		if (logger.isInfoEnabled()) {
			logger.info("Sending error message:\n" + messageBuilder.toString());
		}

		if (targetMail != null && senderAddress != null) {
			try {
				return sendEmail(senderAddress, targetMail, null, subjectText,
						messageBuilder.toString(), "", 0, "utf-8");
			} catch (Exception me) {
				logger.error("Error sending email with exception", e);
				return false;
			}
		} else {
			return true;
		}
	}

	/**
	 * Creates a String of an Throwable item and its causes. Cause level is
	 * limited by a maximum of 100 to prevent cyclic or excessive causes.
	 *
	 * @param throwable
	 * @param maxSubCauseLevel
	 *            maximum level of causes to show (maximum is 100, -1 equals
	 *            maximum)
	 * @return
	 */
	public static String throwableToString(Throwable throwable,
			int maxSubCauseLevel) {
		StringBuilder returnBuilder = new StringBuilder(throwable.getClass()
				.getSimpleName()
				+ ":\n"
				+ throwable.getMessage()
				+ "\nStackTrace:\n" + getStackTraceAsString(throwable));
		int level = 0;

		// prevent cyclic direct reference in cause
		Throwable previousSubThrowable = throwable;

		Throwable subThrowable = throwable.getCause();
		while ((maxSubCauseLevel < 0 || level < maxSubCauseLevel)
				&& level <= 100 && subThrowable != null
				&& previousSubThrowable != subThrowable) {
			returnBuilder.append("\n\ncaused by\n"
					+ subThrowable.getClass().getSimpleName() + ":\n"
					+ subThrowable.getMessage() + "\nStackTrace:\n"
					+ getStackTraceAsString(subThrowable));
			level++;
			subThrowable = subThrowable.getCause();
		}
		if (level == maxSubCauseLevel) {
			returnBuilder.append("\n\n... cut after level " + maxSubCauseLevel
					+ " ...");
		}
		return returnBuilder.toString();
	}

	/**
	 * Get stacktrace of Exception or Throwable as String
	 *
	 * @return Value of property stackTrace.
	 */
	private static String getStackTraceAsString(Throwable throwable) {
		StringBuilder traceStringBuilder = new StringBuilder();
		StackTraceElement[] stackTraceElements = throwable.getStackTrace();
		if (stackTraceElements != null) {
			for (int i = 0; i < stackTraceElements.length; i++) {
				traceStringBuilder.append(stackTraceElements[i].toString()
						+ "\n");
			}
		}
		return traceStringBuilder.toString();
	}

	/**
	 * Sends the attachment of an email.
	 */
	public static boolean sendEmailAttachment(String from, String to_adrList,
			String cc_adrList, String subject, String txt, byte[] att_data,
			String att_name, String att_type) {
		final Map<String, byte[]> attachments = new HashMap<String, byte[]>();
		if (att_name != null && att_data != null) {
			attachments.put(att_name, att_data);
		}
		return sendEmailAttachments(from, to_adrList, cc_adrList, subject, txt,
				attachments, att_type);
	}

	/**
	 * Prepares a {@link MultiPartEmail} instance with given properties.
	 *
	 * @param from sender address
	 * @param toAddrList list of recipient addresses
	 * @param ccAddrList list of cc-recipient addresses
	 * @param subject subject
	 * @param txt text content
	 *
	 * @return instance of {@link MultiPartEmail}
	 *
	 * @throws EmailException on errors creating mulitpart mail
	 */
	private static MultiPartEmail prepareEmail(String from, String toAddrList, String ccAddrList, String subject, String txt) throws EmailException {
		MultiPartEmail email = new MultiPartEmail();
		email.setCharset("UTF-8");
		email.setHostName(getSmtpMailRelayHostname());
		email.setFrom(from);
		email.setSubject(subject);
		if (txt != null) {
			email.setMsg(txt);
		}

		// bounces and reply forwarded to assistance@agnitas.de
		email.addReplyTo("assistance@agnitas.de");
		email.setBounceAddress("assistance@agnitas.de");

		// Set to-recipient email addresses
		InternetAddress[] toAddresses = getEmailAddressesFromList(toAddrList);
		if (toAddresses != null && toAddresses.length > 0) {
			for (InternetAddress singleAdr : toAddresses) {
				email.addTo(singleAdr.getAddress());
			}
		}

		// Set cc-recipient email addresses
		InternetAddress[] ccAddresses = getEmailAddressesFromList(ccAddrList);
		if (ccAddresses != null && ccAddresses.length > 0) {
			for (InternetAddress singleAdr : ccAddresses) {
				email.addCc(singleAdr.getAddress());
			}
		}
		return email;
	}

	public static boolean sendEmailFileAttachments(String from, String to_adrList,
			String cc_adrList, String subject, String txt,
			Map<String, File> attachments, String att_type) {

		boolean result = true;

		try {
			// Create the email message
			MultiPartEmail email = prepareEmail(from, to_adrList, cc_adrList, subject, txt);

			// Create and add the attachment
			for (String name : attachments.keySet()) {
				File file = attachments.get(name);
				FileDataSource attachment =  new AgnFileDataSource(file, att_type);
				email.attach(attachment, name, "EMM-Report");
			}
			// send the email
			email.send();
		} catch (Exception e) {
			logger.error("Error sending email with attachment", e);
			result = false;
		}
		return result;
	}

	/**
	 * Sends the attachments of an email.
	 */
	public static boolean sendEmailAttachments(String from, String to_adrList,
			String cc_adrList, String subject, String txt,
			Map<String, byte[]> attachments, String att_type) {
		boolean result = true;

		try {
			// Create the email message
			MultiPartEmail email = prepareEmail(from, to_adrList, cc_adrList, subject, txt);

			// Create and add the attachment
			for (String name : attachments.keySet()) {
				final byte[] data = attachments.get(name);
				ByteArrayDataSource attachment = new ByteArrayDataSource(data,
						att_type);
				email.attach(attachment, name, "EMM-Report");
			}
			// send the email
			email.send();
		} catch (Exception e) {
			logger.error("Error sending email with attachment", e);
			result = false;
		}
		return result;
	}

	/**
	 * Reads a file.
	 */
	public static String readFile(String path) {
		String value = null;

		try {
			File aFile = new File(path);
			byte[] b = new byte[(int) aFile.length()];
			DataInputStream in = new DataInputStream(new FileInputStream(aFile));
			in.readFully(b);
			value = new String(b);
			in.close();
		} catch (Exception e) {
			logger.warn("Error reading file " + path, e);
			value = null;
		}
		return value;
	}

	/**
	 * Checks the email adress
	 */
	public static boolean checkEmailAdress(String email) {
		boolean value = false;
		try {
			if (email.length() < 3 || email.indexOf("@") == -1) {
				value = false;
			} else {
				value = true;
			}
		} catch (Exception e) {
			if (logger.isInfoEnabled()) {
				logger.info("Seems not to be a valid email address: " + email, e);
			}
			value = false;
		}
		return value;
	}

	/**
	 * Getter for property parameterMap.
	 *
	 * @return Value of property parameterMap.
	 */
	public static Map<String, String> getRequestParameterMap(ServletRequest req) {
		Map<String, String> parameterMap = new HashMap<String, String>();
		Enumeration<String> e = req.getParameterNames();
		while (e.hasMoreElements()) {
			String parameterName = e.nextElement();
			String paremeterValue = req.getParameter(parameterName);
			parameterMap.put(parameterName, paremeterValue);
		}
		return parameterMap;
	}

	/**
	 * Getter for property defaultIntValue.
	 *
	 * @return Value of property defaultIntValue.
	 */
	public static int getDefaultIntValue(String key) {
		int result = 0;
		String resultString = AgnUtils.getDefaultValue(key);

		if (resultString != null) {
			try {
				result = Integer.parseInt(resultString);
			} catch (Exception e) {
				logger.warn("Conversion to integer failed for value '"
						+ resultString + "' of key '" + key + "'", e);
				// do nothing
			}
		}
		return result;
	}

	/**
	 * Getter for property defaultValue.
	 *
	 * @return Value of property defaultValue.
	 */
	public static String getDefaultValue(String key) {
		if (defaults == null) {
			// Try to load emm.properties and cache it
			try {
				defaults = ResourceBundle.getBundle("emm");
			} catch (Exception e) {
				logger.warn("Error reading resource bundle 'emm'", e);
				return null;
			}
		}

		try {
			return defaults.getString(key);
		} catch (Exception e) {
			logger.error("Error reading value for key '" + key
					+ "' from resource bundle 'emm'", e);
			return null;
		}
	}

	public static boolean existDefaultValue(String key) {
		if (defaults == null) {
			// Try to load emm.properties and cache it
			try {
				defaults = ResourceBundle.getBundle("emm");
			} catch (Exception e) {
				logger.warn("Error reading resource bundle 'emm'", e);
				return false;
			}
		}

		try {
			defaults.getString(key);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * Getter for property hibernateDialect.
	 *
	 * @return Value of property hibernateDialect.
	 */
	public static org.hibernate.dialect.Dialect getHibernateDialect() {
		String dialectName;
		if (isProjectOpenEMM()) {
			dialectName = AgnUtils.getDefaultValue("jdbc.openemmDB.dialect");
		} else {
			dialectName = AgnUtils.getDefaultValue("jdbc.emmDB.dialect");
		}
		return org.hibernate.dialect.DialectFactory.buildDialect(dialectName);
	}

	public static boolean isProjectEMM() {
		String sysName = AgnUtils.getDefaultValue("system.type");
		if (sysName != null && sysName.toLowerCase().equals("emm")) {
			return true;
		} else {
			return false;
		}
	}

	public static boolean isProjectOpenEMM() {
		String sysName = AgnUtils.getDefaultValue("system.type");
		if (sysName.toLowerCase().equals("openemm")) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Matches the target with the collection. You shouldn't use this method
	 * anymore : 1st it's quite slow 2nd it seems to have problems recognizing
	 * blacklist patterns with containing the '%'-sign Use Blacklist instead
	 *
	 * @deprecated
	 */
	public static boolean matchCollection(String target,
			Collection<String> collection) {
		if (target == null || collection == null) {
			return false;
		}

		try {
			for (String mask : collection) {
				if (AgnUtils.match(mask, target)) {
					return true;
				}
			}
		} catch (Exception e) {
			logger.warn("Error in matchCollection()", e);
		}

		return false;
	}

	public static boolean match_old(String mask, String target) {
		// ported almost verbatim from rpb's ages old Turbo Pascal 1.0 routine
		//
		// Compare two strings which may contain the DOS wildcard characters *
		// and ?
		// and return a boolean result indicating their "equivalence".
		// e.g. WCMatcher.match("*.java", "WCMatcher.java") will return true as
		// will WCMatcher.match("w?mat*", "WCMatcher.java"). On the other hand,
		// WCMatcher.match("*.java", "WCMatcher.class") will return false (as
		// you
		// would expect). Note that the name/extension separator (i.e. the
		// period)
		// is treated like any other character in the mask or target when
		// compared
		// with one of the wildcard characters. "*" will match "hosts" or
		// "hosts."
		// or "java.exe" BUT "*." will only match a target that ends in
		// ".something"
		// Clear as mud? Try it ... it's fairly intuitive after observing a few
		// examples.
		//
		// Most usage will involve a filename mask (e.g. *.java) being
		// compared with some filename (e.g. WCMatcher.java). However,
		// either mask or target or both may contain DOS wildcard characters
		// and this routine "should" provide an arguably correct result
		//
		// Note also that this method is case insensitive! i.e. "rpb" == "RPB"
		// (as is DOS). A future todo item might be to optionally allow a
		// case sensitive comparison.
		//
		// caution - it seems to work

		// if anything is null, no match
		if (mask == null || target == null) {
			return false;
		}

		int p1 = 0; // used as character index into mask
		int p2 = 0; // used as character index into target
		boolean matched = true; // Assume true to begin.
		// A warning about side effects here: an initial
		// value of false won't work!! I've just been too
		// lazy to eliminate the assumption (the routine
		// was written this way back in the early 80's)

		if ((mask.length() == 0) && (target.length() == 0)) {
			matched = true;
		} else {
			if (mask.length() == 0) {
				if (target.charAt(0) == '%') {
					matched = true;
				} else {
					matched = false;
				}
			} else {
				if (target.length() == 0) {
					if (mask.charAt(0) == '%') {
						matched = true;
					} else {
						matched = false;
					}
				}
			}
		}

		while ((matched) && (p1 < mask.length()) && (p2 < target.length())) {
			if ((mask.charAt(p1) == '_') || (target.charAt(p2) == '_')) {
				p1++;
				p2++;
			} else {
				if (mask.charAt(p1) == '%') {
					p1++;
					if (p1 < mask.length()) {
						while ((p2 < target.length())
								&& (!match(mask.substring(p1, mask.length()),
										target.substring(p2, target.length())))) {
							p2++;
						}
						if (p2 >= target.length()) {
							matched = false;
						} else {
							p1 = mask.length();
							p2 = target.length();
						}
					} else {
						p2 = target.length();
					}
				} else {
					if (target.charAt(p2) == '%') {
						p2++;
						if (p2 < target.length()) {
							while ((p1 < mask.length())
									&& (!match(
											mask.substring(p1, mask.length()),
											target.substring(p2,
													target.length())))) {
								p1++;
							}
							if (p1 >= mask.length()) {
								matched = false;
							} else {
								p1 = mask.length();
								p2 = target.length();
							}
						} else {
							p1 = mask.length();
						}
					} else {
						if (mask.toLowerCase().charAt(p1) == target
								.toLowerCase().charAt(p2)) {
							p1++;
							p2++;
						} else {
							matched = false;
						}
					}
				}
			}
		}// wend

		if (p1 >= mask.length()) {
			while ((p2 < target.length()) && (target.charAt(p2) == '%')) {
				p2++;
			}
			if (p2 < target.length()) {
				matched = false;
			}
		}

		if (p2 >= target.length()) {
			while ((p1 < mask.length()) && (mask.charAt(p1) == '%')) {
				p1++;
			}
			if (p1 < mask.length()) {
				matched = false;
			}
		}
		return matched;
	}

	public static boolean matchOneway(String mask, String target) {
		// like match, but allows only pattern in mask, not in target
		// everything else is a shameless copy of match

		// if anything is null, no match
		if (mask == null || target == null) {
			return false;
		}

		int p1 = 0; // used as character index into mask
		int p2 = 0; // used as character index into target
		boolean matched = true; // Assume true to begin.
		// A warning about side effects here: an initial
		// value of false won't work!! I've just been too
		// lazy to eliminate the assumption (the routine
		// was written this way back in the early 80's)

		if ((mask.length() == 0) && (target.length() == 0)) {
			matched = true;
		} else {
			if (target.length() == 0) {
				if (mask.charAt(0) == '%') {
					matched = true;
				} else {
					matched = false;
				}
			}
		}

		while ((matched) && (p1 < mask.length()) && (p2 < target.length())) {
			if ((mask.charAt(p1) == '_')) {
				p1++;
				p2++;
			} else {
				if (mask.charAt(p1) == '%') {
					p1++;
					if (p1 < mask.length()) {
						while ((p2 < target.length())
								&& (!match(mask.substring(p1, mask.length()),
										target.substring(p2, target.length())))) {
							p2++;
						}
						if (p2 >= target.length()) {
							matched = false;
						} else {
							p1 = mask.length();
							p2 = target.length();
						}
					} else {
						p2 = target.length();
					}
				} else {
					if (mask.toLowerCase().charAt(p1) == target.toLowerCase()
							.charAt(p2)) {
						p1++;
						p2++;
					} else {
						matched = false;
					}
				}
			}
		}// wend

		if (p2 >= target.length()) {
			while ((p1 < mask.length()) && (mask.charAt(p1) == '%')) {
				p1++;
			}
			if (p1 < mask.length()) {
				matched = false;
			}
		} else
			matched = false;
		return matched;
	}

	/**
	 * Returns a date format.
	 */
	public static String formatDate(Date aDate, String pattern) {
		if (aDate == null) {
			return null;
		}
		SimpleDateFormat aFormat = new SimpleDateFormat(pattern);
		return aFormat.format(aDate);
	}

	public static SimpleDateFormat getLocaleDateFormat(HttpServletRequest req) {
		Locale locale = getAdmin(req).getLocale();
		return (SimpleDateFormat) SimpleDateFormat.getDateInstance(
				DateFormat.MEDIUM, locale);
	}

	/**
	 * Getter for the system date.
	 *
	 * @return Value of the system date.
	 */
	public static Date getSysdate(String sysdate) {
		int value = 0;
		char operator;
		GregorianCalendar result = new GregorianCalendar();

		if (sysdate.contains("now()")) {
			if ("now()".equals(sysdate)) {
				return result.getTime();
			}
			// handle date_add/ date_sub
			if (sysdate.startsWith("date_add")
					|| sysdate.startsWith("date_sub")) {
				value = extractDayFromSysdate(sysdate);
				if (sysdate.startsWith("date_add")) {
					result.add(GregorianCalendar.DAY_OF_MONTH, value);
				}
				if (sysdate.startsWith("date_sub")) {
					result.add(GregorianCalendar.DAY_OF_MONTH, value * (-1));
				}
			}

			return result.getTime();
		}
		if (!sysdate.equals("sysdate")) { // +/- <days>
			operator = sysdate.charAt(7);

			try {
				value = Integer.parseInt(sysdate.substring(8));
			} catch (Exception e) {
				logger.warn("Error parsing date offset of sysdate (" + sysdate
						+ ")", e);
				value = 0;
			}

			switch (operator) {
			case '+':
				result.add(GregorianCalendar.DAY_OF_MONTH, value);
				break;
			case '-':
				result.add(GregorianCalendar.DAY_OF_MONTH, value * (-1));
				break;
			}
		}

		return result.getTime();
	}

	/**
	 * compares Strings modes: 0 == test for equal 1 == test for not equal 2 ==
	 * test for a greater b 3 == test for a smaller b
	 */
	public static boolean compareString(String a, String b, int mode) {
		boolean result = false;

		// if both strings are null, we have a match.
		if (a == null && b == null) {
			return true;
		}

		// if one string is null, no match
		if (a == null || b == null) {
			return false;
		}

		int stringres = a.compareTo(b);
		switch (mode) {
		case 0:
			if (stringres == 0) {
				result = true;
			}
			break;

		case 1:
			if (stringres != 0) {
				result = true;
			}
			break;
		case 2:
			if (stringres > 0) {
				result = true;
			}
			break;

		case 3:
			if (stringres < 0) {
				result = true;
			}
			break;
		}
		return result;
	}

	public static String toLowerCase(String source) {
		if (source == null) {
			return null;
		}
		return source.toLowerCase();
	}

	/**
	 * Getter for property reqParameters.
	 *
	 * @return Value of property reqParameters.
	 */
	public static HashMap<String, String> getReqParameters(
			HttpServletRequest req) {
		HashMap<String, String> params = new HashMap<String, String>();
		String parName = null;

		Enumeration<String> aEnum1 = req.getParameterNames();
		while (aEnum1.hasMoreElements()) {
			parName = aEnum1.nextElement();
			if (parName.startsWith("__AGN_DEFAULT_") && parName.length() > 14) {
				parName = parName.substring(14);
				params.put(parName,
						req.getParameter("__AGN_DEFAULT_" + parName));
			}
		}

		Enumeration<String> aEnum2 = req.getParameterNames();
		while (aEnum2.hasMoreElements()) {
			parName = aEnum2.nextElement();
			params.put(parName, req.getParameter(parName));
		}

		if (req.getQueryString() != null) {
			params.put("agnQueryString", req.getQueryString());
		}

		return params;
	}

	/**
	 * Checkes the permissions.
	 */
	public static boolean allowed(String id, HttpServletRequest req) {
		return allowed(id, AgnUtils.getAdmin(req));
	}

	/**
	 * Checkes the permissions.
	 */
	public static boolean allowed(String id, Admin admin) {
		if (admin == null) {
			return false; // Nothing allowed if there is no Session
		}

		Set<String> permission = admin.getAdminPermissions();

		if (permission != null && permission.contains(id)) {
			return true; // Allowed for user.
		}

		permission = admin.getGroup().getGroupPermissions();

		if (permission != null && permission.contains(id)) {
			return true; // Allowed for group.
		}

		return false;
	}

    /**
     * Check the permissions.
     */
    public static boolean allowedForGroup(String id, Admin admin) {
        if (admin == null) {
            return false; // Nothing allowed if there is no Session
        }

        Set<String> permission = admin.getGroup().getGroupPermissions();

        if (permission != null && permission.contains(id)) {
            return true; // Allowed for group.
        }
        return false;
    }

	/**
	 * Gets the used language.
	 */
	public static Locale buildLocale(String language) {
		Locale aLoc = null;

		if (language != null) {
			int aPos = language.indexOf('_');
			String lang = language.substring(0, aPos);
			String country = language.substring(aPos + 1);
			aLoc = new Locale(lang, country);
		}
		return aLoc;
	}

	/**
	 * Getter for property firstResult.
	 *
	 * @return Value of property firstResult.
	 */
	public static <T> T getFirstResult(List<T> aList) {
		if (aList != null && aList.size() > 0) {
			return aList.get(0);
		} else {
			return null;
		}
	}

	/**
	 * Prepares a string ready for saving.
	 */
	public static String propertySaveString(String input) {
		if (input == null) {
			input = "";
		}

		input = StringUtils.replace(input, "=", "\\=");
		input = StringUtils.replace(input, "\"", "\\\"");
		input = StringUtils.replace(input, ",", "\\,");

		return input;
	}

	/**
	 * Search for parameters.
	 * Watch out: This is the same as "findParameter" but DOES contain a ','-is-needed-at-end Bug
	 *
	 * Sometimes we have invalid params in mediatypes param, so the "','-is-needed-at-end Bug" must be kept this way
	 * Example:
	 *   from="\"abc@abc.de\" <abc@abc.de>", reply=""abc@abc.de" <abc@abc.de>",
	 */
	public static String findParam(String paramName, String paramList) {
		String result = null;

		try {
			if (paramName != null) {
				int posA = paramList.indexOf(paramName + "=\"");
				if (posA != -1) {
					int posB = paramList.indexOf("\",", posA);
					if (posB != -1) {
						result = paramList.substring(posA + paramName.length()
								+ 2, posB);
						result = StringUtils.replace(result, "\\=", "=");
						result = StringUtils.replace(result, "\\\"", "\"");
						result = StringUtils.replace(result, "\\,", ",");
					}
				}
			}
		} catch (Exception e) {
			logger.error("Error in findParam()", e);
		}
		return result;
	}

	/**
	 * Search for parameters.
	 * Watch out: This is the same as "findParam" but DOES NOT contain the ','-is-needed-at-end Bug
	 */
	public static String findParameter(String paramName, String paramList) {
		String paramStartText = paramName + "=\"";
		String paramEndText = "\"";

		try {
			if (StringUtils.isNotBlank(paramName)) {
				int paramStartIndex = paramList.indexOf(paramStartText);
				if (paramStartIndex != -1) {
					int paramEndIndex = paramList.indexOf(paramEndText, paramStartIndex + paramStartText.length());
					if (paramEndIndex != -1) {
						String paramValue = paramList.substring(paramStartIndex + paramStartText.length(), paramEndIndex);
						paramValue = paramValue
							.replaceAll("\\=", "=")
							.replaceAll("\\\"", "\"")
							.replaceAll("\\,", ",");
						return paramValue;
					} else {
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.error("Error in findParameter()", e);
			return null;
		}
	}

	/**
	 * Getter for property companyID.
	 *
	 * @return Value of property companyID.
	 */
	public static int getCompanyID(HttpServletRequest req) {
		try {
			Company company = AgnUtils.getCompany(req);
			if (company == null) {
				logger.error("AgnUtils: getCompanyID - no companyID found (company is null)");
				return 0;
			} else {
				return company.getId();
			}
		} catch (Exception e) {
			logger.error("AgnUtils: getCompanyID - no companyID found for request", e);
			return 0;
		}
	}

	public static Admin getAdmin(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			if (session == null) {
				logger.debug("no request session found for getAdmin", new Exception());
				return null;
			} else {
				Admin admin = (Admin) session.getAttribute("emm.admin");
				if (admin == null) {
					logger.debug("no admin found in request session data", new Exception());
					return null;
				} else {
					return admin;
				}
			}
		} catch (Exception e) {
			logger.error("Error while reading admin from request", e);
			return null;
		}
	}

	public static void setAdmin(HttpServletRequest request, Admin admin) {
		try {
			HttpSession session = request.getSession();
			if (session != null) {
				session.setAttribute("emm.admin", admin);
			} else {
				logger.error("no session found for setting admin data");
			}
		} catch (Exception e) {
			logger.error("error while setting admin data in session");
		}
	}

    public static void setAdminPreferences(HttpServletRequest request, AdminPreferences adminPreferences) {
		try {
			HttpSession session = request.getSession();
			if (session != null) {
				session.setAttribute("emm.adminPreferences", adminPreferences);
			} else {
				logger.error("no session found for setting admin preferences data");
			}
		} catch (Exception e) {
			logger.error("error while setting admin preferences data in session");
		}
	}

	public static Admin getAdmin(PageContext pageContext) {
		try {
			HttpSession session = pageContext.getSession();
			if (session == null) {
				logger.error("no pageContext data found for getAdmin");
				return null;
			} else {
				Admin admin = (Admin) session.getAttribute("emm.admin");
				if (admin == null) {
					logger.error("no admin found in pageContext data");
					return null;
				} else {
					return admin;
				}
			}
		} catch (Exception e) {
			logger.error("no admin found for pageContext", e);
			return null;
		}
	}

    public static AdminPreferences getAdminPreferences(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            if (session == null) {
                logger.error("no request session found for getAdminPreferences", new Exception());
                return null;
            } else {
                AdminPreferences adminPreferences = (AdminPreferences) session.getAttribute("emm.adminPreferences");
                if (adminPreferences == null) {
                    logger.error("no admin preferences found in request session data", new Exception());
                    return null;
                } else {
                    return adminPreferences;
                }
            }
        } catch (Exception e) {
            logger.error("Error while reading admin preferences from request", e);
            return null;
        }
    }

	public static boolean isUserLoggedIn(HttpServletRequest request) {
		return getAdmin(request) != null;
	}

	/**
	 * Getter for property timeZone.
	 *
	 * @return Value of property timeZone.
	 */
	public static TimeZone getTimeZone(HttpServletRequest req) {

		TimeZone tz = null;

		try {
			tz = TimeZone.getTimeZone(AgnUtils.getAdmin(req).getAdminTimezone());
		} catch (Exception e) {
			logger.error("Error reading timezone information for current admin", e);
			tz = null;
		}
		return tz;
	}

	/**
	 * Getter for property company.
	 *
	 * @return Value of property company.
	 */
	public static Company getCompany(HttpServletRequest req) {
		try {
			Admin admin = AgnUtils.getAdmin(req);
			if (admin == null) {
				logger.error("AgnUtils: getCompany: no admin found in request");
				return null;
			} else {
				Company company = admin.getCompany();
				if (company == null) {
					logger.error("AgnUtils: getCompany: no company found for admin "
							+ admin.getAdminID()
							+ "("
							+ admin.getCompanyID()
							+ ")");
					return null;
				} else {
					return company;
				}
			}
		} catch (Exception e) {
			logger.error("Error reading company for current user", e);
			return null;
		}
	}

	/*
	 * Checks if date is in future. It is allowed to specify a date that is up
	 * to 5 minutes in the past.
	 *
	 * @param date Checked date.
	 */
	/*
	 * public static boolean isDateInFuture(Date date) { // Create the calendar
	 * object for comparison GregorianCalendar now = new GregorianCalendar();
	 * GregorianCalendar calendarToTest = new GregorianCalendar();
	 *
	 * // Set the time of the test-calendar calendarToTest.setTime(date);
	 *
	 * // Move it 5 minutes into future, so we get a 5 minute fairness period
	 * calendarToTest.add(GregorianCalendar.MINUTE, 5);
	 *
	 * // Do the hard work! return now.before(calendarToTest); }
	 */
	/**
	 * Checks if date is in future.
	 *
	 * @param aDate
	 *            Checked date.
	 */
	public static boolean isDateInFuture(Date aDate) {
		boolean result = false;
		GregorianCalendar aktCal = new GregorianCalendar();
		GregorianCalendar tmpCal = new GregorianCalendar();

		tmpCal.setTime(aDate);
		aktCal.add(GregorianCalendar.MINUTE, 5); // look five minutes in future
													// ;-)
		if (aktCal.before(tmpCal)) {
			result = true;
		}
		return result;
	}

	/**
	 * Getter for property bshInterpreter.
	 *
	 * @return Value of property bshInterpreter.
	 */
	@SuppressWarnings("resource")
	public static Interpreter getBshInterpreter(int cID, int customerID,
			ApplicationContext con) {
		DataSource ds = (DataSource) con.getBean("dataSource");
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Interpreter aBsh = new Interpreter();
		NameSpace aNameSpace = aBsh.getNameSpace();
		aNameSpace.importClass("org.agnitas.util.AgnUtils");

		String sqlStatement = "SELECT * FROM customer_" + cID
				+ "_tbl cust WHERE cust.customer_id = ?";

		try {
			connection = DataSourceUtils.getConnection(ds);
			preparedStatement = connection.prepareStatement(sqlStatement);
			preparedStatement.setInt(1, customerID);
			resultSet = preparedStatement.executeQuery();
			ResultSetMetaData aMeta = resultSet.getMetaData();

			if (resultSet.next()) {
				for (int i = 1; i <= aMeta.getColumnCount(); i++) {
					switch (aMeta.getColumnType(i)) {
					case java.sql.Types.BIGINT:
					case java.sql.Types.INTEGER:
					case java.sql.Types.NUMERIC:
					case java.sql.Types.SMALLINT:
					case java.sql.Types.TINYINT:
						if (resultSet.getObject(i) != null) {
							aNameSpace.setTypedVariable(aMeta.getColumnName(i),
									java.lang.Integer.class, new Integer(resultSet.getInt(i)), null);
						} else {
							aNameSpace.setTypedVariable(aMeta.getColumnName(i), java.lang.Integer.class, null, null);
						}
						break;

					case java.sql.Types.DECIMAL:
					case java.sql.Types.DOUBLE:
					case java.sql.Types.FLOAT:
						if (resultSet.getObject(i) != null) {
							aNameSpace.setTypedVariable(aMeta.getColumnName(i),
									java.lang.Double.class, new Double(resultSet.getDouble(i)), null);
						} else {
							aNameSpace.setTypedVariable(aMeta.getColumnName(i), java.lang.Double.class, null, null);
						}
						break;

					case java.sql.Types.CHAR:
					case java.sql.Types.LONGVARCHAR:
					case java.sql.Types.VARCHAR:
						aNameSpace.setTypedVariable(aMeta.getColumnName(i),
								java.lang.String.class, resultSet.getString(i), null);
						break;

					case java.sql.Types.DATE:
					case java.sql.Types.TIME:
					case java.sql.Types.TIMESTAMP:
						aNameSpace.setTypedVariable(aMeta.getColumnName(i),
								java.util.Date.class, resultSet.getTimestamp(i), null);
						break;
					default:
						logger.error("Ignoring: " + aMeta.getColumnName(i));
					}
				}
			}
			resultSet.close();
			preparedStatement.close();
			// add virtual column "sysdate"
			aNameSpace.setTypedVariable(AgnUtils.getHibernateDialect().getCurrentTimestampSQLFunctionName(), Date.class, new Date(), null);

			return aBsh;
		} catch (Exception e) {
			logger.error("Error in getBshInterpreter()", e);
			sendExceptionMail("Sql: " + sqlStatement, e);
			return null;
		} finally {
			DbUtilities.closeQuietly(resultSet);
			DbUtilities.closeQuietly(preparedStatement);
			DbUtilities.closeQuietly(connection);
		}
	}

	public static byte[] BlobToByte(Blob fromBlob) {
		if (fromBlob == null) {
			return null;
		} else {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();

			if (logger.isInfoEnabled()) {
				logger.info("Writing Blob");
			}
			try {
				return toByteArrayImpl(fromBlob, baos);
			} catch (SQLException e) {
				if (logger.isInfoEnabled()) {
					logger.info("Error in BlobToByte()", e);
				}
				throw new RuntimeException(e);
			} catch (IOException e) {
				if (logger.isInfoEnabled()) {
					logger.info("Error in BlobToByte()", e);
				}
				throw new RuntimeException(e);
			} finally {
				if (baos != null) {
					try {
						baos.close();
					} catch (IOException ex) {
						logger.error("Error in BlobToByte", ex);
					}
				}
			}
		}
	}

	private static byte[] toByteArrayImpl(Blob fromBlob,
			ByteArrayOutputStream baos) throws SQLException, IOException {
		byte[] buf = new byte[4000];
		InputStream is = fromBlob.getBinaryStream();

		try {
			for (;;) {
				int dataSize = is.read(buf);

				if (dataSize == -1) {
					break;
				}
				baos.write(buf, 0, dataSize);
			}
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException ex) {
					logger.error("toByteArrayImpl", ex);
				}
			}
		}
		return baos.toByteArray();
	}

	public static String getHelpURL(HttpServletRequest req) {
		String base = "help_" + getAdmin(req).getAdminLang().toLowerCase();
		String name = req.getServletPath();
		String path = null;
		File rel = null;
		File file = null;

		name = name.substring(0, name.length() - 4);
		rel = new File(name);
		while (rel.getParent() != null) {
			path = req.getSession().getServletContext()
					.getRealPath(base + rel.getAbsoluteFile() + ".htm");
			file = new File(path);
			if (file.exists()) {
				try {
					return base + rel.getCanonicalFile() + ".htm";
				} catch (Exception e) {
					logger.error("getHelpURL", e);
				}
			}
			rel = new File(rel.getParent());
		}
		return base + "/index.jsp";
	}

	public static Company getCompanyCache(@VelocityCheck int companyID,
			ApplicationContext con) {
		@SuppressWarnings("unchecked")
		TimeoutLRUMap<Integer, Company> companyCache = (TimeoutLRUMap<Integer, Company>) con.getBean("companyCache");
		CompanyDao cDao = (CompanyDao) con.getBean("CompanyDao");
		Company aCompany = null;

		aCompany = companyCache.get(companyID);
		if (aCompany == null) {
			aCompany = cDao.getCompany(companyID);
			if (aCompany != null) {
				companyCache.put(companyID, aCompany);
			}
		}
		return aCompany;
	}

	public static boolean match(String mask, String target) {
		// if anything is null, no match
		if (mask == null || target == null) {
			return false;
		}
		mask = mask.toLowerCase();
		target = target.toLowerCase();

		if (mask.compareTo(target) == 0) {
			return true; // match!
		}

		boolean matched = true;
		if (mask.indexOf('%') >= 0 || mask.indexOf('_') >= 0) {
			matched = rmatch(mask, target); // find match incl wildcards
		} else {
			matched = false; // no wildcard - no match
		}
		return matched;
	}

	public static boolean rmatch(String mask, String target) {
		int moreCharacters = mask.indexOf('%');
		int oneCharacter = mask.indexOf('_');
		int pattern = -1;

		if (moreCharacters >= 0) {
			pattern = moreCharacters;
		}
		if (oneCharacter >= 0 && (oneCharacter < pattern || pattern < 0)) {
			pattern = oneCharacter;
		}

		if (pattern == -1) {
			if (mask.compareTo(target) == 0) {
				return true; // match!
			}
			return false;
		}

		if (!mask.regionMatches(0, target, 0, pattern)) {
			return false;
		}

		if (pattern == oneCharacter) {
			// '_' found
			return rmatch(mask.substring(pattern + 1), target.substring(pattern + 1));
		}
		String after = mask.substring(moreCharacters + 1, mask.length());

		for (int c = pattern; c < target.length(); c++) {
			if (rmatch(after, target.substring(c, target.length()))) {
				return true;
			}
		}
		return false;
	}

	public static String getEMMProperty(String propertyName) {
		config = getPropertiesConfiguration();
		return config.getString(propertyName);
	}

	private static Configuration getPropertiesConfiguration() {
		if (config == null) {
			try {
				config = new PropertiesConfiguration("emm.properties");
			} catch (ConfigurationException e) {
				logger.error("error getting 'emm.properties': ", e);
			}
		}
		return config;
	}

	// if have something like date_add(now(), interval 7 day ), you should get 7
	public static int extractDayFromSysdate(String sysdate) {

		Pattern pattern = Pattern.compile("[0-9]{1,}");
		Matcher matcher = pattern.matcher(sysdate);
		if (matcher.find()) {
			return Integer.parseInt(matcher.group());
		}
		return 0;
	}

	public static String extractUnitFromSysdate(String sysdate) {
		return "DAY";
	}

	/**
	 * Escapes any HTML sequence in all values in the given map. The map is
	 * altered and returned.
	 *
	 * @param htmlMap
	 *            map to use for escaping HTML sequences
	 * @return the altered htmlMap
	 */
	public static Map<String, Object> escapeHtmlInValues(Map<String, Object> htmlMap) {
		Map<String, Object> result = new CaseInsensitiveMap<Object>();

		if (htmlMap != null) {
			for (String key : htmlMap.keySet()) {
				Object value = htmlMap.get(key);

				if (value != null) {
					result.put(key, StringEscapeUtils.escapeHtml(value.toString()));
				} else {
					result.put(key, null);

					if (logger.isDebugEnabled()) {
						logger.debug("value for key '" + key + "' is null");
					}
				}
			}
		}
		return result;
	}

	/**
	 *
	 * @param startYear
	 * @return a list of years from the current year back to the start year
	 */
	public static List<Integer> getYearList(int startYear) {

		List<Integer> yearList = new ArrayList<Integer>();
		GregorianCalendar calendar = new GregorianCalendar();
		int currentYear = calendar.get(Calendar.YEAR);
		for (int year = currentYear; year >= startYear; year--) {
			yearList.add(year);
		}

		return yearList;
	}

	public static List<Integer> getCalendarYearList(int startYear) {
		List<Integer> yearList = new ArrayList<Integer>();
		GregorianCalendar calendar = new GregorianCalendar();
		int currentYear = calendar.get(Calendar.YEAR);
		for (int year = currentYear + 1; year >= startYear; year--) {
			yearList.add(year);
		}
		return yearList;
	}

	public static List<String[]> getMonthList() {
		List<String[]> monthList = new ArrayList<String[]>();
		monthList.add(new String[] { "0", "month.january" });
		monthList.add(new String[] { "1", "month.february" });
		monthList.add(new String[] { "2", "month.march" });
		monthList.add(new String[] { "3", "month.april" });
		monthList.add(new String[] { "4", "month.may" });
		monthList.add(new String[] { "5", "month.june" });
		monthList.add(new String[] { "6", "month.juli" });
		monthList.add(new String[] { "7", "month.august" });
		monthList.add(new String[] { "8", "month.september" });
		monthList.add(new String[] { "9", "month.october" });
		monthList.add(new String[] { "10", "month.november" });
		monthList.add(new String[] { "11", "month.december" });
		return monthList;
	}

	public static boolean parameterNotEmpty(HttpServletRequest request,
			String paramName) {
		return request.getParameter(paramName) != null
				&& !request.getParameter(paramName).isEmpty();
	}

	public static String bytesToKbStr(int bytes) {
		long kbSize100x = Math.round(bytes / 10.24);
		return (kbSize100x / 100) + "." + (kbSize100x % 100);
	}

	public static int decryptLayoutID(String layout) {
		int layoutID = 0;
		int index = layout.indexOf('.');
		layout = layout.substring(0, index);
		layoutID = Integer.parseInt(layout, 36);
		return layoutID;
	}

	public static int decryptCompanyID(String company) {
		int companyID = 0;
		int index = company.indexOf('.');
		company = company.substring(index + 1);
		companyID = Integer.parseInt(company, 36);
		return companyID;
	}

	public static File createDirectory(String path) {
		File directory = new File(path);
		boolean dirCreated;
		if (!directory.exists()) {
			dirCreated = directory.mkdirs();
		} else {
			dirCreated = true;
		}
		return dirCreated ? directory : null;
	}

	public static <T> T nullValue(T value, T valueOnNull) {
		return value != null ? value : valueOnNull;
	}

	public static String getUserErrorMessage(Exception e) {
		String result = "";
		boolean ff = false;
		if (e instanceof ParseErrorException) {
			result += "Line " + ((ParseErrorException) e).getLineNumber();
			result += ", column " + ((ParseErrorException) e).getColumnNumber()
					+ ": ";
			String error = e.getMessage();
			result += StringEscapeUtils.escapeHtml(error.split("\n")[0]);
			ff = true;
		}
		if (e instanceof MethodInvocationException) {
			result += "Line " + ((MethodInvocationException) e).getLineNumber();
			result += ", column "
					+ ((MethodInvocationException) e).getColumnNumber() + ": ";
			String error = e.getMessage();
			result += StringEscapeUtils.escapeHtml(error.split("\n")[0]);
			ff = true;
		}
		if (e instanceof ResourceNotFoundException) {
			result += "Template not found. \n";
			result += StringEscapeUtils
					.escapeHtml(e.getMessage().split("\n")[0]);
			ff = true;
		}
		if (e instanceof IOException) {
			result += e.getMessage().split("\n")[0];
			ff = true;
		}
		if (!ff) {
			result += e.getMessage().split("\n")[0];
		}

		return result;
	}

	public static boolean sendVelocityExceptionMail(String formUrl, Exception e) {
		String targetMail = AgnUtils.getDefaultValue("mailaddress.support");
		String senderAddress = AgnUtils.getDefaultValue("mailaddress.sender");
		if (StringUtils.isBlank(senderAddress)) {
			senderAddress = AgnUtils.getHostName() + "@agnitas.de";
		}
		String message = "";

		message += "Velocity error: \n";
		message += e.getMessage().split("\n")[0];
		if (formUrl != null) {
			message += "\n Form URL: \n";
			message += formUrl;
		}
		message += "\n Error details: \n";
		message += throwableToString(e, -1);

		if (targetMail != null) {
			try {
				return sendEmail(senderAddress, targetMail, null, "EMM Fehler", message, "", 0, "utf-8");
			} catch (Exception me) {
				logger.error("sendVelocityExceptionMail", e);
				return false;
			}
		}
		return true;
	}

	public static String getAttributeFromParameterString(String params, String attributeName) {
		String attribute = "";

		// split the parameters
		String paramArray[] = params.split(",");

		// loop over every entry
		for (String item : paramArray) {
			if (item.trim().startsWith(attributeName)) {
				attribute = item.trim();
			}
		}

		// we dont have that attribute in param-staring
		if (attribute == null) {
			return null;
		}

		// now extract the parameter.
		attribute = attribute.replace(attributeName + "=", "");
		attribute = attribute.replace("\"", "").trim();

		return attribute;
	}

	/**
	 * Build a string of x repetitions of another string. An optional separator
	 * is placed between each repetition. 0 repetitions return an empty string.
	 *
	 * @param itemString
	 * @param repeatTimes
	 * @return
	 */
	public static String repeatString(String itemString, int repeatTimes) {
		return repeatString(itemString, repeatTimes, null);
	}

	/**
	 * Build a string of x repetitions of another string. An optional separator
	 * is placed between each repetition. 0 repetitions return an empty string.
	 *
	 * @param itemString
	 * @param separatorString
	 * @param repeatTimes
	 * @return
	 */
	public static String repeatString(String itemString, int repeatTimes, String separatorString) {
		StringBuilder returnStringBuilder = new StringBuilder();
		for (int i = 0; i < repeatTimes; i++) {
			if (returnStringBuilder.length() > 0 && StringUtils.isNotEmpty(separatorString)) {
				returnStringBuilder.append(separatorString);
			}
			returnStringBuilder.append(itemString);
		}
		return returnStringBuilder.toString();
	}

	/**
	 * Sort a map by a Comparator for the keytype
	 *
	 * @param mapToSort
	 * @param comparator
	 * @return
	 */
	public static <KeyType, ValueType> Map<KeyType, ValueType> sortMap(
			Map<KeyType, ValueType> mapToSort, Comparator<KeyType> comparator) {
		List<KeyType> keys = new ArrayList<KeyType>(mapToSort.keySet());
		Collections.sort(keys, comparator);
		LinkedHashMap<KeyType, ValueType> sortedContent = new LinkedHashMap<KeyType, ValueType>();
		for (KeyType key : keys) {
			sortedContent.put(key, mapToSort.get(key));
		}
		return sortedContent;
	}

	/**
	 * Splits String into a list of strings separating text values from number
	 * values Example: "abcd 23.56 ueyr76" will be split to "abcd ", "23", ".",
	 * "56", " ueyr", "76"
	 *
	 * @param mixedString
	 *            string to split
	 * @return split-list of strings
	 */
	public static List<String> splitIntoNumbersAndText(String mixedString) {
		List<String> tokens = new ArrayList<String>();
		if (StringUtils.isNotEmpty(mixedString)) {
			StringBuilder numberToken = null;
			StringBuilder textToken = null;
			for (char charValue : mixedString.toCharArray()) {
				if (Character.isDigit(charValue)) {
					if (numberToken == null) {
						numberToken = new StringBuilder();
					}
					numberToken.append(charValue);
					if (textToken != null) {
						tokens.add(textToken.toString());
						textToken = null;
					}
				} else {
					if (textToken == null) {
						textToken = new StringBuilder();
					}
					textToken.append(charValue);
					if (numberToken != null) {
						tokens.add(numberToken.toString());
						numberToken = null;
					}
				}
			}
		}
		return tokens;
	}

	/**
	 * Check if a string only consists of digits. No signing (+-) or punctuation
	 * is allowed.
	 *
	 * @param value
	 * @return
	 */
	public static boolean isDigit(String value) {
		for (char charValue : value.toCharArray()) {
			if (!Character.isDigit(charValue))
				return false;
		}
		return true;
	}

	public static boolean interpretAsBoolean(String value) {
		return value != null
				&& ("true".equalsIgnoreCase(value)
						|| "yes".equalsIgnoreCase(value)
						|| "on".equalsIgnoreCase(value)
						|| "allowed".equalsIgnoreCase(value)
						|| "1".equals(value) || "+".equals(value) || "enabled"
							.equalsIgnoreCase(value));
	}

	/**
	 * Remove specific framing tag elements from a string.
	 *
	 * e.g: "startingtext <prev>wanted text</prev> trailingtext" =>
	 * "wanted text"
	 *
	 * @param tagContainingString
	 * @param tagName
	 * @return
	 */
	public static String getStringWithoutTagFrame(String tagContainingString, String tagName) {
		// find first occurence of start
		int tagStart = tagContainingString.indexOf("<" + tagName + ">");
		int tagEnd = -1;

		// find following occurence of end
		if (tagStart > -1) {
			tagEnd = tagContainingString.indexOf("</" + tagName + ">", tagStart);
		} else {
			tagEnd = tagContainingString.indexOf("</" + tagName + ">");
		}

		// find shortest enclosed part
		if (tagEnd > -1 && tagStart > -1) {
			tagStart = tagContainingString.lastIndexOf("<" + tagName + ">", tagEnd);
		}

		// return enclosed part or original string
		if (tagStart > -1 && tagEnd > tagStart) {
			return tagContainingString.substring(tagStart + 5, tagEnd);
		} else if (tagStart > -1) {
			return tagContainingString.substring(tagStart + 5);
		} else if (tagEnd > -1) {
			return tagContainingString.substring(0, tagEnd);
		} else {
			return tagContainingString;
		}
	}

	public static URL addUrlParameter(URL url, String parameterName,
			String parameterValue) throws UnsupportedEncodingException,
			MalformedURLException {
		return addUrlParameter(url, parameterName, parameterValue, null);
	}

	public static URL addUrlParameter(URL url, String parameterName,
			String parameterValue, String encodingCharSet)
			throws UnsupportedEncodingException, MalformedURLException {
		return new URL(addUrlParameter(url.toString(), parameterName,
				parameterValue, encodingCharSet));
	}

	public static String addUrlParameter(String url, String parameterName,
			String parameterValue) throws UnsupportedEncodingException {
		return addUrlParameter(url, parameterName, parameterValue, null);
	}

	public static String addUrlParameter(String url, String parameterName,
			String parameterValue, String encodingCharSet)
			throws UnsupportedEncodingException {
		StringBuilder escapedParameterNameAndValue = new StringBuilder();

		if (StringUtils.isEmpty(encodingCharSet)) {
			escapedParameterNameAndValue.append(parameterName);
		} else {
			escapedParameterNameAndValue.append(URLEncoder.encode(
					parameterName, encodingCharSet));
		}

		escapedParameterNameAndValue.append('=');

		if (StringUtils.isEmpty(encodingCharSet)) {
			escapedParameterNameAndValue.append(parameterValue);
		} else {
			escapedParameterNameAndValue.append(URLEncoder.encode(
					parameterValue, encodingCharSet));
		}
		return addUrlParameter(url, escapedParameterNameAndValue.toString());
	}

	public static String addUrlParameter(String url,
			String escapedParameterNameAndValue)
			throws UnsupportedEncodingException {
		StringBuilder newUrl = new StringBuilder();

		int hpos = url.indexOf('#');
		if (hpos > -1) {
			newUrl.append(url.substring(0, hpos));
		} else {
			newUrl.append(url);
		}

		newUrl.append(url.indexOf('?') <= -1 ? '?' : '&');

		newUrl.append(escapedParameterNameAndValue);

		if (hpos > -1) {
			newUrl.append(url.substring(hpos));
		}
		return newUrl.toString();
	}

	public static int getLineCountOfFile(File file) throws IOException {
		LineNumberReader lineNumberReader = null;
		try {
			lineNumberReader = new LineNumberReader(new InputStreamReader(new FileInputStream(file)));
			while (lineNumberReader.readLine() != null) {
				// do nothing
			}

			return lineNumberReader.getLineNumber();
		} finally {
			IOUtils.closeQuietly(lineNumberReader);
		}
	}

	public static int getLineCountOfStream(InputStream inputStream) throws IOException {
		LineNumberReader lineNumberReader = null;
		try {
			lineNumberReader = new LineNumberReader(new InputStreamReader(inputStream));
			while (lineNumberReader.readLine() != null) {
				// do nothing
			}

			return lineNumberReader.getLineNumber();
		} finally {
			IOUtils.closeQuietly(lineNumberReader);
		}
	}

	public static int getLineCountOfString(String data) throws IOException {
		LineNumberReader lineNumberReader = null;
		try {
			lineNumberReader = new LineNumberReader(new InputStreamReader(new ByteArrayInputStream(data.getBytes())));
			while (lineNumberReader.readLine() != null) {
				// do nothing
			}

			return lineNumberReader.getLineNumber();
		} finally {
			IOUtils.closeQuietly(lineNumberReader);
		}
	}

	public static InternetAddress[] getEmailAddressesFromList(String listString) {
		if (StringUtils.isNotBlank(listString)) {
			List<InternetAddress> emailAddresses = new ArrayList<InternetAddress>();
			for (String singleAdr : listString.split(";|,| ")) {
				singleAdr = singleAdr.trim();
				if (StringUtils.isNotBlank(singleAdr)) {
					try {
						InternetAddress nextAddress = new InternetAddress(
								singleAdr.trim());
						nextAddress.validate();
						emailAddresses.add(nextAddress);
					} catch (AddressException e) {
						logger.error("Invalid Emailaddress found: " + singleAdr);
					}
				}
			}

			return emailAddresses.toArray(new InternetAddress[emailAddresses.size()]);
		} else {
			return new InternetAddress[0];
		}
	}

	public static String getHostName() {
		try {
			return InetAddress.getLocalHost().getHostName();
		} catch (java.net.UnknownHostException uhe) {
			if (logger.isInfoEnabled()) {
				logger.info("Unknown host", uhe);
			}

			try {
				return getHostNameFallback();
			} catch (Exception e) {
				return "unknown hostname";
			}
		}
	}

	public static String getIpAddress() {
		try {
			return InetAddress.getLocalHost().getHostAddress();
		} catch (java.net.UnknownHostException uhe) {
			if (logger.isInfoEnabled()) {
				logger.info("Unknown ip-address", uhe);
			}

			try {
				return getHostNameFallback();
			} catch (Exception e) {
				return "unknown ip-address";
			}
		}
	}

	private static String getHostNameFallback() throws Exception {
		BufferedInputStream input = null;
		try {
			Runtime run = Runtime.getRuntime();
			Process proc = run.exec("hostname");
			input = new BufferedInputStream(proc.getInputStream());
			String value = new String(IOUtils.toByteArray(input));
			if (StringUtils.isNotBlank(value)) {
				return value.trim();
			} else {
				throw new Exception("cannot find hostname");
			}
		} finally {
			IOUtils.closeQuietly(input);
			;
		}
	}

	/**
	 * Chop a string in pieces with maximum length of chunkSize
	 */
	public static List<String> chopToChunks(String text, int chunkSize) {
		List<String> returnList = new ArrayList<String>((text.length() + chunkSize - 1) / chunkSize);

		for (int start = 0; start < text.length(); start += chunkSize) {
			returnList.add(text.substring(start, Math.min(text.length(), start + chunkSize)));
		}
		return returnList;
	}

	/**
	 * Chop a list of items in pieces of lists with a maximum number of items
	 * within each
	 */
	public static <T> List<List<T>> chopToChunks(List<T> originalList,
			int subListMaxSize) throws IllegalArgumentException {
		if (originalList == null) {
			throw new IllegalArgumentException(
					"Null list not allowed to chopToChunks");
		} else if (subListMaxSize <= 0) {
			throw new IllegalArgumentException(
					"SubListMaxSize <= 0 not allowed to chopToChunks");
		} else if (originalList.size() == 0) {
			return new ArrayList<List<T>>();
		} else {
			List<List<T>> returnList = new ArrayList<List<T>>(
					(originalList.size() + subListMaxSize - 1) / subListMaxSize);
			List<T> currentListToAdd = new ArrayList<T>(subListMaxSize);
			returnList.add(currentListToAdd);

			for (T item : originalList) {
				if (currentListToAdd.size() >= subListMaxSize) {
					currentListToAdd = new ArrayList<T>(subListMaxSize);
					returnList.add(currentListToAdd);
				}
				currentListToAdd.add(item);
			}
			return returnList;
		}
	}

	public static UUID generateNewUUID() {
		return UUID.randomUUID();
	}

	public static String convertToHexString(UUID uuid) {
		return convertToHexString(uuid, false);
	}

	public static String convertToHexString(UUID uuid, boolean removeHyphens) {
		return uuid.toString().toUpperCase().replace("-", "");
	}

	public static String convertToBase64String(UUID uuid) {
		byte[] data = convertToByteArray(uuid);
		return encodeBase64(data);
	}

	public static String encodeBase64(byte[] data) {
		return Base64.encode(data);
	}

	public static byte[] decodeBase64(String data) {
		return Base64.decode(data);
	}

	public static String decodeURL(String encodedData) throws Exception {
		try {
			return URLDecoder.decode(encodedData, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new Exception("Invalid url-encoded data");
		}
	}

	public static byte[] convertToByteArray(UUID uuid) {
		long msb = uuid.getMostSignificantBits();
		long lsb = uuid.getLeastSignificantBits();
		byte[] buffer = new byte[16];

		for (int i = 0; i < 8; i++) {
			buffer[i] = (byte) (msb >>> 8 * (7 - i));
		}
		for (int i = 8; i < 16; i++) {
			buffer[i] = (byte) (lsb >>> 8 * (7 - i));
		}
		return buffer;
	}

	public static UUID convertToUUID(byte[] byteArray) {
		if (byteArray.length != 16) {
			throw new IllegalArgumentException(
					"Length of bytearray doesn't fit for UUID");
		}

		long msb = 0;
		long lsb = 0;
		for (int i = 0; i < 8; i++) {
			msb = (msb << 8) | (byteArray[i] & 0xFF);
		}
		for (int i = 8; i < 16; i++) {
			lsb = (lsb << 8) | (byteArray[i] & 0xFF);
		}
		return new UUID(msb, lsb);
	}

	private static SecureRandom random = new SecureRandom();
	private static final char[] allCharacters = "0123456789abcdefghijklmnopqrstuvwxyz"
			.toCharArray();

	public static String getRandomString(int length) {
		char[] buffer = new char[length];
		for (int i = 0; i < buffer.length; ++i) {
			buffer[i] = allCharacters[random.nextInt(allCharacters.length)];
		}
		return new String(buffer);
	}

	public static boolean dayListIncludes(List<GregorianCalendar> listOfDays,
			GregorianCalendar day) {
		for (GregorianCalendar listDay : listOfDays) {
			if (listDay.get(Calendar.DAY_OF_YEAR) == day
					.get(Calendar.DAY_OF_YEAR))
				return true;
		}
		return false;
	}

	public static boolean anyCharsAreEqual(char... values) {
		for (int i = 0; i < values.length; i++) {
			for (int j = i + 1; j < values.length; j++) {
				if (values[i] == values[j]) {
					return true;
				}
			}
		}
		return false;
	}

	public static boolean isNumber(String value) {
		try {
			Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static boolean isDouble(String value) {
		try {
			Double.parseDouble(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	/**
	 * Call lowercase and trim on email address. Watch out: apostrophe and other
	 * special characters !#$%&'*+-/=?^_`{|}~ are allowed in local parts of
	 * emailaddresses
	 *
	 * @param email
	 * @return
	 */
	public static String normalizeEmail(String email) {
		if (StringUtils.isBlank(email)) {
			return null;
		} else {
			return email.toLowerCase().trim();
		}
	}

	public static String checkAndNormalizeEmail(String email) throws Exception {
		if (StringUtils.isBlank(email)) {
			throw new Exception("Empty email address");
		} else {
			if (!EmailValidator.getInstance().isValid(
					StringOps.punycoded(email))) {
				throw new Exception("Invalid email address");
			} else {
				return normalizeEmail(email);
			}
		}
	}

	public static boolean compareByteArrays(byte[] array1, byte[] array2) {
		if (array1 == array2) {
			return true;
		} else if (array1 == null || array2 == null
				|| array1.length != array2.length) {
			return false;
		} else {
			for (int i = 0; i < array1.length; i++) {
				if (array1[i] != array2[i]) {
					return false;
				}
			}
			return true;
		}
	}

    /**
     * Compare two lists.
     * Equity is checked by ".equals" of all list elements.
     *
     * @param list
     * @return
     */
	public static boolean compareLists(List<?> listExpected, List<?> listActually) {
		if (listExpected == null && listActually == null) {
			return true;
		} else if (listExpected == null || listActually == null
				|| listExpected.size() != listActually.size()) {
			return false;
		} else {
			for (int i = 0; i < listExpected.size(); i++) {
				if (listExpected.get(i) == null && listActually.get(i) == null) {
					// ok
				} else if (listExpected.get(i) == null
						|| listActually.get(i) == null
						|| !listExpected.get(i).equals(listActually.get(i))) {
					return false;
				}
			}
			return true;
		}
	}


    /**
     * Compare two lists.
     * Equity is checked by ".equals" of all list elements.
     *
     * @param list
     * @param checkedIndexes
     * @return
     */
	public static boolean compareLists(List<?> listExpected, List<?> listActually, int... checkedIndexes) {
		if (listExpected == null && listActually == null) {
			return true;
		} else if (listExpected == null || listActually == null
				|| listExpected.size() != listActually.size()) {
			return false;
		} else {
			for (int checkedIndex : checkedIndexes) {
				if (checkedIndex >= listExpected.size()) {
					throw new IllegalArgumentException("Itemindex to check is out of bounds");
				}

				if (listExpected.get(checkedIndex) == null && listActually.get(checkedIndex) == null) {
					// ok
				} else if (listExpected.get(checkedIndex) == null
						|| listActually.get(checkedIndex) == null
						|| !listExpected.get(checkedIndex).equals(listActually.get(checkedIndex))) {
					return false;
				}
			}
			return true;
		}
	}

	public static String getSmtpMailRelayHostname() {
		String returnValue = "localhost";
		try {
			String configValue = AgnUtils.getDefaultValue("system.mail.host");
			if (StringUtils.isNotBlank(configValue)) {
				returnValue = configValue;
			}
		} catch (Exception e) {
			logger.warn("Error gettings STMP mail relay hostname", e);
		}
		return returnValue;
	}

	public static int getValidPageNumber(int fullListSize, int page, int rownums) {
		int pageNumber = page;
		double doubleFullListSize = fullListSize;
		double doublePageSize = rownums;
		int lastPagenumber = (int) Math.ceil(doubleFullListSize / doublePageSize);
		if (lastPagenumber < pageNumber) {
			pageNumber = 1;
		}
		return pageNumber;
	}

	public static String getStringFromNull(String source) {
		if (source.equals("null")) {
			return "";
		} else {
			return source;
		}
	}

	public static String replaceHashTags(
			String hashTagString,
			@SuppressWarnings("unchecked") Map<String, Object>... replacementMaps) {
		if (StringUtils.isBlank(hashTagString)) {
			return hashTagString;
		} else {
			String returnString = hashTagString;
			Pattern pattern = Pattern.compile("##([^#]+)##");
			Matcher matcher = pattern.matcher(hashTagString);
			int currentPosition = 0;

			while (matcher.find(currentPosition)) {
				int matcherStart = matcher.start();
				String tagNameString = matcher.group(1);
				String[] referenceKeys = tagNameString.split("/");
				String replacementValue = null;

				if (replacementMaps != null) {
					for (String referenceKey : referenceKeys) {
						for (Map<String, Object> replacementMap : replacementMaps) {
							if (replacementMap != null) {
								Object replacementData = replacementMap.get(referenceKey);
								if (replacementData != null) {
									String replacementDataString = replacementData.toString();
									if (StringUtils.isNotEmpty(replacementDataString)) {
										replacementValue = replacementData.toString();
										break;
									}
								}
							}
						}
						if (replacementValue != null) {
							break;
						}
					}
				}

				if (replacementValue == null) {
					replacementValue = "";
				}
				returnString = matcher.replaceAll(replacementValue);
				matcher = pattern.matcher(returnString);
				currentPosition += matcherStart + replacementValue.length();
			}
			return returnString;
		}
	}

	/**
	 * Replaces all &amp;quot; with " inside agn-tags
	 *
	 * @param content
	 *            source string
	 * @return fixed string
	 */
	public static String fixQuotesInAgnTags(String content) {
		String contentTag = "\\[agn(.*?)=&quot;(.*?)&quot;/?\\]";
		Pattern pattern = Pattern.compile(contentTag);
		int startMatch = 0;
		int endMatch = 0;
		while (content.length() > endMatch) {
			Matcher matcher = pattern.matcher(content);
			endMatch = content.length();
			if (matcher.find(startMatch)) {
				startMatch = matcher.start();
				endMatch = matcher.end();
				String partBefore = content.substring(0, startMatch);
				String neededPart = content.substring(startMatch, endMatch);
				String partAfter = "";
				if (content.length() > endMatch) {
					partAfter = content.substring(endMatch);
				}
				neededPart = neededPart.replaceAll("&quot;", "\"");
				content = partBefore + neededPart + partAfter;
				startMatch++;
			}
		}
		return content;
	}

	public static boolean isEmailValid(String email) {
		return EmailValidator.getInstance().isValid(email);
	}

	public static class TimeIgnoringComparator implements Comparator<Calendar> {
		@Override
		public int compare(Calendar c1, Calendar c2) {
			if (c1.get(Calendar.YEAR) != c2.get(Calendar.YEAR))
				return c1.get(Calendar.YEAR) - c2.get(Calendar.YEAR);
			if (c1.get(Calendar.MONTH) != c2.get(Calendar.MONTH))
				return c1.get(Calendar.MONTH) - c2.get(Calendar.MONTH);
			return c1.get(Calendar.DAY_OF_MONTH) - c2.get(Calendar.DAY_OF_MONTH);
		}
	}

	/**
	 * This method splits a String list at the characters ',' ';' and '|' and
	 * trims the resulting items
	 *
	 * @param stringList
	 * @return
	 */
	public static List<String> splitAndTrimStringlist(String stringList) {
		if (stringList == null) {
			return null;
		} else {
			List<String> returnList = new ArrayList<String>();
			String[] parts = stringList.split(",|;|\\|");
			for (String part : parts) {
				returnList.add(part.trim());
			}
			return returnList;
		}
	}

	/**
	 * This method acts like splitAndTrimStringlist, but also splits at blanks
	 *
	 * @param stringList
	 * @return
	 */
	public static List<String> splitAndTrimList(String stringList) {
		if (stringList == null) {
			return null;
		} else {
			List<String> returnList = new ArrayList<String>();
			String[] parts = stringList.split(",|;|\\|| ");
			for (String part : parts) {
				returnList.add(part.trim());
			}
			return returnList;
		}
	}

	public static boolean isDateValid(String date, String datePattern) {

		if (date == null || datePattern == null || datePattern.length() <= 0) {
			return false;
		}
		SimpleDateFormat formatter = new SimpleDateFormat(datePattern);
		formatter.setLenient(false);
		try {
			formatter.parse(date);
		} catch (ParseException e) {
			return false;
		}
		return true;
	}

	public static boolean isDatePeriodValid(String startDate, String endDate,
			String datePattern) {
		try {
			Calendar start = Calendar.getInstance();
			Calendar end = Calendar.getInstance();
			start.setTime(new SimpleDateFormat(datePattern).parse(startDate));
			end.setTime(new SimpleDateFormat(datePattern).parse(endDate));
			if (start.before(end)) {
				return true;
			}
		} catch (ParseException e) {
			return false;
		}
		return false;
	}

	public static String shortenStringToMaxLength(String value, int maxLength) {
		if (value != null && value.length() > maxLength) {
			return value.substring(0, maxLength - 4) + " ...";
		} else {
			return value;
		}
	}

	public static String getTempDir() {
		return System.getProperty("java.io.tmpdir");
	}

	public static Object getValueFromMapByCamelcaseKey(Map<String, Object> map,
			String key) {
		for (String mapKey : map.keySet()) {
			if (mapKey.equalsIgnoreCase(key)) {
				return map.get(mapKey);
			}
		}
		return null;
	}

	public static String getActiveIndexesFromBooleanArray(boolean[] data) {
		StringBuilder dataString = new StringBuilder();
		for (int i = 0; i < data.length; i++) {
			if (data[i]) {
				if (dataString.length() > 0) {
					dataString.append(", ");
				}
				dataString.append(i);
			}
		}
		return dataString.toString();
	}

	public static boolean[] getBooleanArrayForActiveIndexes(String data,
			int arrayLength) {
		String[] parts = data.split(", ");
		boolean[] returnData = new boolean[arrayLength]; // all values are set
															// to false by
															// default
		for (String part : parts) {
			returnData[Integer.parseInt(part)] = true;
		}
		return returnData;
	}

	public static WebApplicationContext getSpringContextFromRequest(
			HttpServletRequest request) {
		return WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession()
						.getServletContext());
	}

	public static void logJspError(String jspFileName, String message,
			Exception e) {
		logger.error("Error in JSP '" + jspFileName + "': " + message, e);
	}

	public static void logJspInfo(String jspFileName, String message) {
		logger.info("Info from JSP '" + jspFileName + "': " + message);
	}

	public static boolean checkNumberIsWithinInterval(
			String numberIntervalString, int number) throws Exception {
		try {
			if (StringUtils.isNotBlank(numberIntervalString)) {
				List<String> intervals = splitAndTrimList(numberIntervalString);
				for (String interval : intervals) {
					if (StringUtils.isNotBlank(interval)) {
						if (interval.startsWith("-")) {
							int intervalEnd = Integer.parseInt(interval
									.substring(1));
							if (number <= intervalEnd) {
								return true;
							}
						} else if (interval.endsWith("+")) {
							int intervalStart = Integer.parseInt(interval
									.substring(0, interval.length() - 1));
							if (intervalStart <= number) {
								return true;
							}
						} else if (interval.contains("-")) {
							int intervalStart = Integer.parseInt(interval
									.substring(0, interval.indexOf('-')));
							int intervalEnd = Integer.parseInt(interval
									.substring(interval.indexOf('-') + 1));
							if (intervalStart <= number
									&& number <= intervalEnd) {
								return true;
							}
						} else {
							int item = Integer.parseInt(interval);
							if (item == number) {
								return true;
							}
						}
					}
				}
			}
			return false;
		} catch (Exception e) {
			throw new Exception("Invalid numberIntervalString: " + numberIntervalString);
		}
	}

	public static Map<String, String> getParamsMap(String paramsString,
			String pairsSplitter, String keyValueSplitter) {
		Map<String, String> params = new HashMap<String, String>();
		if (paramsString != null && !"".equals(paramsString)
				&& pairsSplitter != null && !"".equals(pairsSplitter)
				&& keyValueSplitter != null && !"".equals(keyValueSplitter)) {
			String[] paramPairs = paramsString.split(pairsSplitter);
			for (int i = 0; i < paramPairs.length; i++) {
				String[] paramPair = paramPairs[i].split(keyValueSplitter);
				if (paramPair.length == 2) {
					params.put(paramPair[0], paramPair[1]);
				}
			}
		}
		return params;
	}

	public static <T> List<T> getEnumerationAsList(Enumeration<T> enumeration) {
		List<T> returnList = new ArrayList<T>();
    	while (enumeration.hasMoreElements()) {
    		T item = enumeration.nextElement();
    		returnList.add(item);
    	}
    	return returnList;
	}

	public static boolean check24HourTime(String timeString) {
		return Pattern.compile("^([01]?[0-9]|2[0-3]):[0-5][0-9]$").matcher(timeString).matches();
	}

    /**
     * This method create Map<permissionGroupName, ArrayList<permissionName>> from
     * List of permissions like "UserRights.GroupName.permissionName"
     *
     * @param userRights list of rights from resourceBundle
     * @return map
     */
    public static Map<String, List<String>> createUserRightsMap(LinkedList<String> userRights) {

        Map<String, List<String>> result = new HashMap<String, List<String>>();

        //put rights into map
        for (String right : userRights){
            String[] array = right.split("\\.");
            String group  = array[1]; //get group name
            array = Arrays.copyOfRange(array, 2, array.length);
            String rightKey = StringUtils.join(array, ".");

            if(result.get(group) == null) {
            	result.put(group, new ArrayList<String>());
            }

            result.get(group).add(rightKey);
        }
        return result;
    }

    /**
     * Removes duplicate lists from a list of lists.
     * Equity is checked by ".equals" of all list elements.
     *
     * @param list
     * @return
     */
	public static <T> List<List<T>> filterDuplicateLists(List<List<T>> list) {
		List<List<T>> returnList = new ArrayList<List<T>>();
		for (List<T> listItem : list) {
			boolean contained = false;
			for (List<T> returnListItem : returnList) {
				if (compareLists(returnListItem, listItem)) {
					contained = true;
					break;
				}
			}
			if (!contained) {
				returnList.add(listItem);
			}
		}
		return returnList;
	}

    /**
     * Removes duplicate lists from a list of lists.
     * Equity is checked by ".equals" of all list elements.
     *
     * @param list
	 * @param checkedIndexes
     * @return
     */
	public static <T> List<List<T>> filterDuplicateLists(List<List<T>> list, int... checkedIndexes) {
		List<List<T>> returnList = new ArrayList<List<T>>();
		for (List<T> listItem : list) {
			boolean contained = false;
			for (List<T> returnListItem : returnList) {
				if (compareLists(returnListItem, listItem, checkedIndexes)) {
					contained = true;
					break;
				}
			}
			if (!contained) {
				returnList.add(listItem);
			}
		}
		return returnList;
	}

	/**
	 * Returns domain of email address
	 *
	 * Examples:
	 *   "abc@xyz" <abc@def.de> => def.de
	 *   abc@def.de => def.de
	 *
	 * @param emailAddress
	 * @return
	 */
	public static String getDomainFromEmail(String emailAddress) {
		int domainTextDelimiterIndex = emailAddress.lastIndexOf("@");
		if (domainTextDelimiterIndex >= 0) {
			String domain = emailAddress.substring(domainTextDelimiterIndex + 1);
			if (domain.endsWith(">")) {
				domain = domain.substring(0, domain.length() - 1);
			}
			return domain;
		} else {
			return null;
		}
	}

	public static List<String> makeListTrimAndLowerCase(List<String> data) {
		List<String> returnList = new ArrayList<String>();
		for (String item : data) {
			if (item == null) {
				returnList.add(null);
			} else {
				returnList.add(item.trim().toLowerCase());
			}
		}
		return returnList;
	}

	/**
	 * Search for the next index of any of the given search Strings after the startIndex in a data String
	 *
	 * @param dataString
	 * @param startIndex
	 * @param searchStrings
	 * @return
	 */
	public static int searchNext(String dataString, int startIndex, String... searchStrings) {
		int foundIndex = -1;

		for (String searchString : searchStrings) {
			int nextFoundIndex = dataString.indexOf(searchString, startIndex);
			if (nextFoundIndex >= 0 && (foundIndex == -1 || nextFoundIndex < foundIndex)) {
				foundIndex = nextFoundIndex;
			}
		}

		return foundIndex;
	}

	/**
	 * Mac/Apple linebreak character
	 */
	public static String LinebreakMac = "\r";

	/**
	 * Unix/Linux linebreak character
	 */
	public static String LinebreakUnix = "\n";

	/**
	 * Windows linebreak characters
	 */
	public static String LinebreakWindows = "\r\n";

	/**
	 * Get line number at a given text position
	 *
	 * @param dataString
	 * @param textPosition
	 * @return
	 */
	public static int getLineNumberOfTextposition(String dataString, int textPosition) {
		if (dataString == null) {
			return -1;
		} else {
			try {
				String textPart = dataString;
				if (dataString.length() > textPosition) {
					textPart = dataString.substring(0, textPosition);
				}
				int lineNumber = getLineCount(textPart);
				if (textPart.endsWith(LinebreakUnix) || textPart.endsWith(LinebreakMac)) {
					lineNumber++;
				}
				return lineNumber;
			} catch (IOException e) {
				e.printStackTrace();
				return -1;
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
	}

	/**
	 * Get the number of lines in a text
	 *
	 * @param dataString
	 * @return
	 * @throws IOException
	 */
	public static int getLineCount(String dataString) throws IOException {
		if (dataString == null) {
			return 0;
		} else if ("".equals(dataString)) {
			return 1;
		} else {
			LineNumberReader lineNumberReader = null;
			try {
				lineNumberReader = new LineNumberReader(new StringReader(dataString));
				while (lineNumberReader.readLine() != null) {
					// do nothing
				}

				return lineNumberReader.getLineNumber();
			} finally {
				IOUtils.closeQuietly(lineNumberReader);
			}
		}
	}

	/**
	 * Get the startindex of the line at a given position within the text
	 *
	 * @param dataString
	 * @param index
	 * @return
	 */
	public static int getStartIndexOfLineAtIndex(String dataString, int index) {
		if (dataString == null || index < 0) {
			return -1;
		} else if (index == 0) {
			return 0;
		} else {
			int nextLineBreakMac = dataString.lastIndexOf(LinebreakMac, index);
			int nextLineBreakUnix = dataString.lastIndexOf(LinebreakUnix, index);
			int nextLineBreakWindows = dataString.lastIndexOf(LinebreakWindows, index);

			if (nextLineBreakMac >= 0 && (nextLineBreakUnix < 0 || nextLineBreakMac < nextLineBreakUnix) && (nextLineBreakWindows < 0 || nextLineBreakMac < nextLineBreakWindows)) {
				return nextLineBreakMac + LinebreakMac.length();
			} else if (nextLineBreakUnix >= 0 && (nextLineBreakWindows < 0 || nextLineBreakUnix < nextLineBreakWindows)) {
				return nextLineBreakUnix + LinebreakUnix.length();
			} else if (nextLineBreakWindows >= 0) {
				return nextLineBreakWindows + LinebreakWindows.length();
			} else {
				return 0;
			}
		}
	}

	/**
	 * Check if a string starts with a stringpart caseinsensitive
	 *
	 * @param str
	 * @param prefix
	 * @return
	 */
	public static boolean startsWithIgnoreCase(String str, String prefix) {
		if (str == null || prefix == null) {
			return (str == null && prefix == null);
		} else if (prefix.length() > str.length()) {
			return false;
		} else {
			return str.regionMatches(true, 0, prefix, 0, prefix.length());
		}
	}

	public static Locale getLocale(HttpServletRequest request) {
        Admin admin = getAdmin(request);
        return (admin == null)
        		? Locale.getDefault() //(Locale)request.getSession().getAttribute(org.apache.struts.Globals.LOCALE_KEY)
        		: admin.getLocale();
	}
	
	public static Object[] extendObjectArray(Object[] array, Object... objects) {
		Object[] extendedParameters = new Object[array.length + objects.length];
		for (int i = 0; i < array.length; i++) {
			extendedParameters[i] = array[i];
		}
		for (int i = 0; i < objects.length; i++) {
			extendedParameters[array.length + i] = objects[i];
		}
		return extendedParameters;
	}
	
	public static void checkHostConnection(String hostname, int port) throws Exception {
		int timeout = 2000;

		InetSocketAddress endPoint = new InetSocketAddress(hostname, port);

		if (endPoint.isUnresolved()) {
			throw new Exception("Cannot resolve hostname");
		} else {
			Socket socket = new Socket();
			try {
				socket.connect(endPoint, timeout);
			} catch (IOException ioe) {
				throw new Exception("Connection Error: " + ioe.getMessage(), ioe);
			} finally {
				if (socket != null) {
					try {
						socket.close();
					} catch (IOException ioe) {
					}
				}
			}
		}
	}
}