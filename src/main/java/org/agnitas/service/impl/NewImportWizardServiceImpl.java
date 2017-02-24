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
package org.agnitas.service.impl;

import java.beans.PropertyDescriptor;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.Stack;

import org.agnitas.backend.StringOps;
import org.agnitas.beans.ColumnMapping;
import org.agnitas.beans.CustomerImportStatus;
import org.agnitas.beans.ImportProfile;
import org.agnitas.beans.Mailinglist;
import org.agnitas.beans.ProfileRecipientFields;
import org.agnitas.beans.impl.ProfileRecipientFieldsImpl;
import org.agnitas.dao.ImportLoggerDao;
import org.agnitas.dao.ImportProfileDao;
import org.agnitas.dao.ImportRecipientsDao;
import org.agnitas.dao.RecipientDao;
import org.agnitas.emm.core.velocity.VelocityCheck;
import org.agnitas.service.NewImportWizardService;
import org.agnitas.service.csv.CollectionNode;
import org.agnitas.service.csv.FieldNode;
import org.agnitas.service.csv.JavaBeanNode;
import org.agnitas.service.csv.Node;
import org.agnitas.service.csv.Toolkit;
import org.agnitas.util.AgnUtils;
import org.agnitas.util.Blacklist;
import org.agnitas.util.CsvColInfo;
import org.agnitas.util.CsvTokenizer;
import org.agnitas.util.EmailAttachment;
import org.agnitas.util.ImportCsvGenerator;
import org.agnitas.util.ImportReportEntry;
import org.agnitas.util.ImportUtils;
import org.agnitas.util.importvalues.Charset;
import org.agnitas.util.importvalues.CheckForDuplicates;
import org.agnitas.util.importvalues.DateFormat;
import org.agnitas.util.importvalues.ImportMode;
import org.agnitas.util.importvalues.Separator;
import org.agnitas.util.importvalues.TextRecognitionChar;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.Form;
import org.apache.commons.validator.FormSet;
import org.apache.commons.validator.GenericValidator;
import org.apache.commons.validator.Validator;
import org.apache.commons.validator.ValidatorResources;
import org.apache.commons.validator.ValidatorResults;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.xml.sax.SAXException;

/**
 * @author Viktor Gema
 */
public class NewImportWizardServiceImpl implements NewImportWizardService {
	private static final long serialVersionUID = -3574630950599738549L;

	private static final transient Logger logger = Logger.getLogger(NewImportWizardServiceImpl.class);

	private String validatorRulesXml;
	private File inputFile;
	private Integer profileId;
	private Map<String, Class<?>> classMap;
	private Node rootNode;
	private Stack<Node> nodeStack = new Stack<Node>();
	private ValidatorResources resources = null;
	private Map<ProfileRecipientFields, ValidatorResults> validRecipients;
	private Map<ProfileRecipientFields, ValidatorResults> invalidRecipients;
	private CustomerImportStatus status;
	private ImportRecipientsDao importRecipientsDao;
	private ImportProfileDao importProfileDao;
	private ImportLoggerDao importLoggerDao;
	private RecipientDao recipientDao;
	private Integer adminId;
	private Validator validator;
	private CSVColumnState[] columns;
	private ImportProfile importProfile;
	private int completedPercent;
	private List<ProfileRecipientFields> beansAfterEditOnErrorEditPage;
	private FieldsFactory filedsFactory;
	private static final String FORM_NAME = "RecipientFields";
	private int blockSize = NewImportWizardService.BLOCK_SIZE;
	private boolean recipientLimitReached;
	private boolean importLimitReached;
	private boolean nearLimit;
	private Integer companyId;
	private int maxGenderValue = MAX_GENDER_VALUE_BASIC;

	public NewImportWizardServiceImpl() {
		filedsFactory = new FieldsFactory();
	}

	public void setValidatorRulesXml(String validatorRulesXml) {
		this.validatorRulesXml = validatorRulesXml;
	}

	/**
	 * Initialize validation rules. See spring configuration file.
	 * This method is called by spring setup and may not be removed!
	 */
	public void initRules() {
		InputStream rulesInputStream = null;
		try {
			// Create a new instance of a ValidatorResource, then get a stream
			// handle on the XML file with the actions in it, and initialize the
			// resources from it.
			rulesInputStream = NewImportWizardServiceImpl.class.getResourceAsStream(validatorRulesXml);
			resources = new ValidatorResources(rulesInputStream);
		} catch (IOException e) {
			logger.error("Error while opening validation rule file", e);
		} catch (SAXException e) {
			logger.error("Error while parsing validation rule file", e);
		} finally {
			IOUtils.closeQuietly(rulesInputStream);
		}
		final Map<String, Class<?>> tempMap = new HashMap<String, Class<?>>();
		tempMap.put("fields", ProfileRecipientFieldsImpl.class);
		tempMap.put("list", ArrayList.class);
		tempMap.put("string", String.class);
		classMap = Collections.unmodifiableMap(tempMap);

		/*
		 * RecipientFields is form name defined in validation-rules.xml Form is
		 * defines default columns for mapping like email
		 */
		validator = new Validator(resources, FORM_NAME);
		validator.setOnlyReturnErrors(true);
		validRecipients = new HashMap<ProfileRecipientFields, ValidatorResults>();
		invalidRecipients = new HashMap<ProfileRecipientFields, ValidatorResults>();
	}

	@Override
	public boolean isProfileKeyColumnValid() {
		List<ColumnMapping> mappedColumns = importProfile.getColumnMapping();
		List<String> keyColumns = importProfile.getKeyColumns();
		List<String> dbColumns = new ArrayList<String>();
		for (ColumnMapping column : mappedColumns) {
			dbColumns.add(column.getDatabaseColumn());
		}
		if (keyColumns.isEmpty()) {
			if (dbColumns.contains(importProfile.getKeyColumn())) {
				return true;
			}
		} else {
			if (dbColumns.containsAll(keyColumns)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public Collection<ImportReportEntry> generateReportData(CustomerImportStatus customerImportStatus, ImportProfile profile) {
		Collection<ImportReportEntry> reportValues = new ArrayList<ImportReportEntry>();
		reportValues.add(new ImportReportEntry("import.csv_errors_email",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.EMAIL_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_blacklist",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.BLACKLIST_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_double",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.EMAILDOUBLE_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_numeric",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.NUMERIC_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_mailtype",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.MAILTYPE_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_gender",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.GENDER_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_date",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.DATE_ERROR))));
		reportValues.add(new ImportReportEntry("import.csv_errors_linestructure",
				String.valueOf(customerImportStatus.getError(NewImportWizardService.STRUCTURE_ERROR))));
		reportValues.add(new ImportReportEntry("import.RecipientsAllreadyinDB",
				String.valueOf(customerImportStatus.getAlreadyInDb())));
		reportValues.add(new ImportReportEntry("import.result.imported",
				String.valueOf(customerImportStatus.getInserted())));
		reportValues.add(new ImportReportEntry("import.result.updated",
				String.valueOf(customerImportStatus.getUpdated())));
		if (profile.getImportMode() == ImportMode.ADD.getIntValue() ||
				profile.getImportMode() == ImportMode.ADD_AND_UPDATE.getIntValue()) {
			reportValues.add(new ImportReportEntry("import.result.datasource_id",
					String.valueOf(customerImportStatus.getDatasourceID())));
		}
		return reportValues;
	}

	@Override
	public void generateResultStatistics() {
		int datasourceId = status.getDatasourceID();
		Integer[] types = {NewImportWizardService.RECIPIENT_TYPE_FIELD_INVALID};
		int page = 0;
		int rowNum = NewImportWizardService.BLOCK_SIZE;
		HashMap<ProfileRecipientFields, ValidatorResults> recipients = null;
		while (recipients == null || recipients.size() == rowNum) {
			recipients = importRecipientsDao.getRecipientsByTypePaginated(types, page, rowNum, adminId, datasourceId);
			for (ValidatorResults validatorResults : recipients.values()) {
				for (CSVColumnState column : columns) {
					if (column.getImportedColumn()) {
						if (!ImportUtils.checkIsCurrentFieldValid(validatorResults, column.getColName())) {
							if (column.getColName().equals("email")) {
								status.addError(NewImportWizardServiceImpl.EMAIL_ERROR);
							} else if (column.getColName().equals("mailtype")) {
								status.addError(NewImportWizardServiceImpl.MAILTYPE_ERROR);
							} else if (column.getColName().equals("gender")) {
								status.addError(NewImportWizardServiceImpl.GENDER_ERROR);
							} else if (column.getType() == CSVColumnState.TYPE_DATE) {
								status.addError(NewImportWizardServiceImpl.DATE_ERROR);
							} else if (column.getType() == CSVColumnState.TYPE_NUMERIC) {
								status.addError(NewImportWizardServiceImpl.NUMERIC_ERROR);
							}
						}
					}
				}
			}
			page++;
		}
	}

	/**
	 * Method generates recipients csv-file for the given types of recipients.
	 * If there are no recipients of such type(s) in temporary table the
	 * returned file will be null.
	 *
	 * @param types    types of recipients to include in csv-file
	 * @param fileName file name start part (random number will be appended)
	 * @return generated csv-file
	 */
	@Override
	public File createRecipientsCsv(Integer[] types, String fileName) {
		int datasourceId = status.getDatasourceID();
		int recipientCount = importRecipientsDao.getRecipientsCountByType(types, adminId, datasourceId);
		if (recipientCount == 0) {
			return null;
		}
		ImportProfile profile = importProfileDao.getImportProfileById(importProfile.getId());
		ImportCsvGenerator generator = new ImportCsvGenerator();
		generator.createCsv(profile, columns, fileName);
		int page = 0;
		int rowNum = NewImportWizardService.BLOCK_SIZE;
		HashMap<ProfileRecipientFields, ValidatorResults> recipients = null;
		while (recipients == null || recipients.size() == rowNum) {
			recipients = importRecipientsDao.getRecipientsByTypePaginated(types, page, rowNum, adminId, datasourceId);
			generator.writeDataToFile(recipients.keySet(), columns, profile);
			page++;
		}
		return generator.finishFileGeneration();
	}

	/**
	 * Method generates recipients csv-file for the duplicate type of recipients.
	 * If there are no recipients of such type(s) in temporary table the
	 * returned file will be null.
	 *
	 * @param types    types of recipients to include in csv-file
	 * @param fileName file name start part (random number will be appended)
	 * @return generated csv-file
	 */
	@Override
	public File createDuplicateRecipientsCsv(Integer[] types, String fileName) {
		int datasourceId = status.getDatasourceID();

		int recipientCount = importRecipientsDao.getRecipientsCountByType(types, adminId, datasourceId);
		if (recipientCount == 0) {
			return null;
		}

		ImportProfile profile = importProfileDao.getImportProfileById(importProfile.getId());
		ImportCsvGenerator generator = new ImportCsvGenerator();

		//add custom filed source of the duplicate
		final List<CSVColumnState> csvColumnStates = Arrays.asList(columns);
		List<CSVColumnState> columnsList = new ArrayList<CSVColumnState>();
		columnsList.addAll(csvColumnStates);
		final CSVColumnState sourceOfDuplicate = new CSVColumnState("SourceOfDuplicate", false, CSVColumnState.TYPE_CHAR);
		columnsList.add(sourceOfDuplicate);

		generator.createCsv(profile, columnsList.toArray(columns), fileName);
		int page = 0;
		int rowNum = NewImportWizardService.BLOCK_SIZE;
		HashMap<ProfileRecipientFields, ValidatorResults> recipients = null;
		for (Integer type : types) {
			recipients = null;
			page = 0;
			while (recipients == null || recipients.size() == rowNum) {
				recipients = importRecipientsDao.getRecipientsByTypePaginated(new Integer[]{type}, page, rowNum, adminId, datasourceId);
				generator.writeDataToFileForDuplication(recipients.keySet(), columnsList.toArray(columns), profile, type);
				page++;
			}
		}
		File file = generator.finishFileGeneration();
		return file;
	}

	/**
	 * Sends import report if profile has emailForReport
	 *
	 */
	@Override
	public void sendReportEmail(File invalidRecipientsFile, File fixedRecipientsFile, Locale locale, Collection<ImportReportEntry> reportEntries,
								List<Mailinglist> assignedMailinglists, Map<Integer, Integer> mailinglistAssignStats, String mailStartMessage) {
		String address = importProfile.getMailForReport();
		if (!GenericValidator.isBlankOrNull(address) && GenericValidator.isEmail(address)) {
			ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
			Collection<EmailAttachment> attachments = new ArrayList<EmailAttachment>();
			EmailAttachment emailAttachment = createZipAttachment(invalidRecipientsFile,
					"invalid_recipients.zip", bundle.getString("import.recipients.invalid"));
			if (emailAttachment != null) {
				attachments.add(emailAttachment);
			}
			EmailAttachment fixedRecipients = createZipAttachment(fixedRecipientsFile,
					"fixed_recipients.zip", bundle.getString("import.recipients.fixed"));
			if (fixedRecipients != null) {
				attachments.add(fixedRecipients);
			}
			EmailAttachment[] attArray = attachments.toArray(new EmailAttachment[]{});
			String subject = bundle.getString("import.recipients.report");
			String message = subject + ":\n";
			if (mailStartMessage != null) {
				message = mailStartMessage + "\n";
			}
			message = message + generateReportEmailBody(bundle, reportEntries, assignedMailinglists, mailinglistAssignStats);
			ImportUtils.sendEmailWithAttachments( AgnUtils.getDefaultValue( "import.report.from.address"), AgnUtils.getDefaultValue( "import.report.from.name"), address, subject, message, attArray);
		}
	}

	/**
	 * Generates body of report email
	 *
	 * @param bundle message resource bundle
	 * @return body of email containing import statistics
	 */
	private String generateReportEmailBody(ResourceBundle bundle, Collection<ImportReportEntry> reportEntries,
										   List<Mailinglist> assignedMailinglists, Map<Integer, Integer> mailinglistAssignStats) {
		String body = "";
		for (ImportReportEntry entry : reportEntries) {
			body = body + bundle.getString(entry.getKey()) + ": " + entry.getValue() + "\n";
		}
		String mailinglistAddMessage = createMailinglistAddMessage();
		if (assignedMailinglists != null) {
			for (Mailinglist mlist : assignedMailinglists) {
				String mlistStr = mlist.getShortname() + ": " + mailinglistAssignStats.get(mlist.getId()) +
						" " + bundle.getString(mailinglistAddMessage) + "\n";
				body = body + mlistStr;
			}
		}
		return body;
	}

	/**
	 * Creates attachment from zip-file
	 *
	 * @param recipientsFile file
	 * @param name           name of attachment
	 * @param description    attachment description
	 * @return created attachment
	 */
	private EmailAttachment createZipAttachment(File recipientsFile, String name, String description) {
		EmailAttachment attachment;
		if (recipientsFile != null) {
			try {
				byte[] data = FileUtils.readFileToByteArray(recipientsFile);
				attachment = new EmailAttachment(name, data, "application/zip", description);
				return attachment;
			} catch (IOException e) {
				logger.error("Error creating attachment", e);
			}
		}
		return null;
	}

	/**
	 * Method creates message about assigning recipients to mailing lists
	 * according to import mode for displaying in result page and in report
	 * email
	 *
	 * @return mailing list add message
	 */
	@Override
	public String createMailinglistAddMessage() {
		int importMode = importProfile.getImportMode();
		String mlistAddedMessage = "";
		if (importMode == ImportMode.ADD.getIntValue() ||
				importMode == ImportMode.ADD_AND_UPDATE.getIntValue() ||
				importMode == ImportMode.UPDATE.getIntValue()) {
			mlistAddedMessage = "import.result.subscribersAdded";
		} else if (importMode == ImportMode.MARK_OPT_OUT.getIntValue() ||
				importMode == ImportMode.TO_BLACKLIST.getIntValue()) {
			mlistAddedMessage = "import.result.subscribersUnsubscribed";
		} else if (importMode == ImportMode.MARK_BOUNCED.getIntValue()) {
			mlistAddedMessage = "import.result.subscribersBounced";
		}
		return mlistAddedMessage;
	}

	@Override
	public void doParse() throws Exception {
		nearLimit = false;
		recipientLimitReached = false;
		importLimitReached = false;
		int linesInFile = AgnUtils.getLineCountOfFile(inputFile);

		if (logger.isInfoEnabled())
			logger.info("Import ID: " + importProfile.getImportId() + " Number of recipients in file: " + (linesInFile - 1));

		columns = null;
		// check the count of recipients to import
		int importMaxRows = Integer.parseInt(AgnUtils.getDefaultValue("import.maxRows"));
		if (linesInFile > importMaxRows) {
			importLimitReached = true;
			return;
		}
		
		setCompletedPercent(0);
		
		int linesRead = 0;
		BufferedReader in = null;
		try {
			in = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), Charset.getValue(importProfile.getCharset())));
			while (in.ready()) {
				invalidRecipients.clear();
				validRecipients.clear();
				rootNode = new RootNode();
				nodeStack.clear();
				nodeStack.push(rootNode);
				push("list");
				int currentRow = 0;

				// Execute the file read in blocks of "blockSize" rows
				String line;
				while (currentRow < blockSize && (line = in.readLine()) != null) {
					String[] row = null;
					if (!"".equals(line)) {
						try {
							row = new CsvTokenizer(line, Separator.getValue(importProfile.getSeparator()), TextRecognitionChar.getValue(importProfile.getTextRecognitionChar())).toArray();
						} catch (Exception e) {
							status.addError(NewImportWizardServiceImpl.STRUCTURE_ERROR);
						}
					}

					// Null indicates that the row should be ignored
					if (row != null) {
						handleRow(row);
						currentRow++;
					}
				}

				linesRead += currentRow;
				setCompletedPercent(linesRead * 100 / linesInFile);
				
				// Show the new progress status after each block
				pop("list");

				doValidate(false);
				rootNode = null;
			}
		} finally {
			IOUtils.closeQuietly(in);
		}
	}

	@Override
	public void doValidate(Boolean isNeedUpdate) throws Exception {
		invalidRecipients.clear();
		validRecipients.clear();
		doBeansValidate();

		createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_FIELD_INVALID, invalidRecipients);

		invalidRecipients.clear();

        //check for duplication in CSV file
        if (importProfile.getImportMode() == ImportMode.TO_BLACKLIST.getIntValue()) {
            List<String> emailList = new ArrayList<String>();
            for (ProfileRecipientFields profileRecipientFields : validRecipients.keySet()) {
                if(emailList.contains(profileRecipientFields.getEmail())){
                    invalidRecipients.put(profileRecipientFields, null);
                    status.addError(NewImportWizardServiceImpl.EMAILDOUBLE_ERROR);
                    continue;
                }
                emailList.add(profileRecipientFields.getEmail());
            }
            for (ProfileRecipientFields profileRecipientFields : invalidRecipients.keySet()) {
                validRecipients.remove(profileRecipientFields);
            }
            invalidRecipients.clear();
        }

        // check for blacklist
		final Set<String> blackList = importRecipientsDao.loadBlackList(importProfile.getCompanyId());
		Blacklist blacklist = new Blacklist();
		for (String blackListEntry : blackList) {
			blacklist.add(blackListEntry, false);
		}
		for (ProfileRecipientFields profileRecipientFields : validRecipients.keySet()) {
			if (profileRecipientFields.getEmail() != null && blacklist.isBlackListed(profileRecipientFields.getEmail()) != null) {
				invalidRecipients.put(profileRecipientFields, null);
				status.addError(NewImportWizardServiceImpl.BLACKLIST_ERROR);
			}
		}

		createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_INVALID, invalidRecipients);
		for (ProfileRecipientFields profileRecipientFields : invalidRecipients.keySet()) {
			validRecipients.remove(profileRecipientFields);
		}
		invalidRecipients.clear();

		// check for duplication
		if (importProfile.getImportMode() != ImportMode.TO_BLACKLIST.getIntValue()) {
			final int checkDuplicateType = importProfile.getCheckForDuplicates();
			if (checkDuplicateType == CheckForDuplicates.NEW_DATA.getIntValue()) {
				invalidRecipients = importRecipientsDao.getDuplicateRecipientsFromNewDataOnly(validRecipients, importProfile, columns, adminId, status.getDatasourceID());
				for (ProfileRecipientFields profileRecipientFields : invalidRecipients.keySet()) {
					validRecipients.remove(profileRecipientFields);
				}
				createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_DUPLICATE_IN_NEW_DATA_RECIPIENT, invalidRecipients);
				for (int i = 0; i < invalidRecipients.keySet().size(); i++) {
					status.addError(NewImportWizardServiceImpl.EMAILDOUBLE_ERROR);
				}
				invalidRecipients.clear();
			} else if (checkDuplicateType == CheckForDuplicates.COMPLETE.getIntValue()) {
				invalidRecipients = importRecipientsDao.getDuplicateRecipientsFromNewDataOnly(validRecipients, importProfile, columns, adminId, status.getDatasourceID());
				for (ProfileRecipientFields profileRecipientFields : invalidRecipients.keySet()) {
					validRecipients.remove(profileRecipientFields);
				}
				createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_DUPLICATE_IN_NEW_DATA_RECIPIENT, invalidRecipients);
				for (int i = 0; i < invalidRecipients.keySet().size(); i++) {
					status.addError(NewImportWizardServiceImpl.EMAILDOUBLE_ERROR);
				}
				invalidRecipients = importRecipientsDao.getDuplicateRecipientsFromExistData(validRecipients, importProfile, columns);

				for (ProfileRecipientFields profileRecipientFields : invalidRecipients.keySet()) {
					validRecipients.remove(profileRecipientFields);
				}

				createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_DUPLICATE_RECIPIENT, invalidRecipients);
			}
		}
		if (isNeedUpdate) {
			createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_FIXED_BY_HAND, validRecipients);
		} else {
			createOrUpdateRecepients(isNeedUpdate, NewImportWizardService.RECIPIENT_TYPE_VALID, validRecipients);
		}

		final int importModeType = importProfile.getImportMode();

		// check the recipient limit
		if (importModeType == ImportMode.ADD.getIntValue() || importModeType == ImportMode.ADD_AND_UPDATE.getIntValue()) {
			if (!recipientDao.mayAdd(importProfile.getCompanyId(), validRecipients.size())) {
				recipientLimitReached = true;
			}
			if (recipientDao.isNearLimit(importProfile.getCompanyId(), validRecipients.size())) {
				nearLimit = true;
			}
		}

		if (importLimitReached || recipientLimitReached) {
			return;
		}

		if (importModeType == ImportMode.ADD.getIntValue()) {
			importRecipientsDao.addNewRecipients(validRecipients, adminId, importProfile, columns, status.getDatasourceID());
			status.setInserted(status.getInserted() + validRecipients.size());
			status.setAlreadyInDb(status.getAlreadyInDb() + invalidRecipients.size());
		} else if (importModeType == ImportMode.ADD_AND_UPDATE.getIntValue()) {
			importRecipientsDao.addNewRecipients(validRecipients, adminId, importProfile, columns, status.getDatasourceID());
			status.setInserted(status.getInserted() + validRecipients.size());
			int touchedRecipients = importRecipientsDao.updateExistRecipients(invalidRecipients.keySet(), importProfile, columns);
			status.setUpdated(status.getUpdated() + touchedRecipients);
			status.setAlreadyInDb(status.getAlreadyInDb() + touchedRecipients);
		} else if (importModeType == ImportMode.TO_BLACKLIST.getIntValue()) {
			importRecipientsDao.importInToBlackList(validRecipients.keySet(), importProfile.getCompanyId());
			status.setInserted(status.getInserted() + validRecipients.size());
		} else if (importModeType == ImportMode.UPDATE.getIntValue()) {
			int touchedRecipients = importRecipientsDao.updateExistRecipients(invalidRecipients.keySet(), importProfile, columns);
			status.setUpdated(status.getUpdated() + touchedRecipients);
			status.setAlreadyInDb(status.getAlreadyInDb() + touchedRecipients);
		}
	}

	private void createOrUpdateRecepients(Boolean isNeedUpdate, int type, Map<ProfileRecipientFields, ValidatorResults> recipients) throws Exception {
		if (!isNeedUpdate) {
			importRecipientsDao.createRecipients(recipients, adminId, importProfile, type, status.getDatasourceID(), columns);
		} else {
			importRecipientsDao.updateRecipients(recipients, adminId, type, importProfile, status.getDatasourceID(), columns);
		}
	}

	@Override
	public void validateImportProfileMatchGivenCVSFile() throws ImportWizardContentParseException, IOException {
		importProfile = getImportProfileDao().getImportProfileById(getProfileId());
		initValidator();
		BufferedReader in = null;
		try {
			in = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), Charset.getValue(importProfile.getCharset())));
			final String line = in.readLine();
			final String[] row = new CsvTokenizer(line, Separator.getValue(importProfile.getSeparator()), TextRecognitionChar.getValue(importProfile.getTextRecognitionChar()))
					.toArray();
			final List<ColumnMapping> mappingList = importProfile.getColumnMapping();
			if (mappingList.isEmpty()) {
				throw new ImportWizardContentParseException("error.import.no_columns_maped");
			}
			for (ColumnMapping columnMapping : mappingList) {
				if (!columnMapping.getDatabaseColumn().equals(ColumnMapping.DO_NOT_IMPORT) && !Arrays.asList(row).contains(columnMapping.getFileColumn())) {
					final ImportWizardContentParseException contentParseException = new ImportWizardContentParseException("error.import.no_keycolumn_mapping_found_in_file");
					contentParseException.setParameterValue(columnMapping.getFileColumn());
					throw contentParseException;
					// if current column doesn't present in csv file;

				}
			}
		} catch (UnsupportedEncodingException e) {
			throw new ImportWizardContentParseException("error.import.charset", e);

		} catch (IOException e) {
			throw e;
		} catch (Exception e) {
			if (e instanceof ImportWizardContentParseException) {
				throw (ImportWizardContentParseException) e;
			} else {
				throw new ImportWizardContentParseException("error.import.separator_or_textrecognition_is_wrong", e);
			}
		} finally {
			IOUtils.closeQuietly(in);
		}
	}

	public void doBeansValidate() throws Exception {
		List<ProfileRecipientFields> lTempProfileRecipientFields = new LinkedList<ProfileRecipientFields>();
		for (ProfileRecipientFields prRecipientFields : getBeans()) {
			ProfileRecipientFields newProfileRecipientFields = new ProfileRecipientFieldsImpl();
			newProfileRecipientFields.setChange_date(prRecipientFields.getChange_date());
			newProfileRecipientFields.setCreation_date(prRecipientFields.getCreation_date());
			Map<String, String> newCustomFields = new LinkedHashMap<String, String>();
			for (String key : prRecipientFields.getCustomFields().keySet()) {
				newCustomFields.put(key, prRecipientFields.getCustomFields().get(key));
			}
			newProfileRecipientFields.setCustomFields(newCustomFields);

			newProfileRecipientFields.setEmail(prRecipientFields.getEmail());
			newProfileRecipientFields.setFirstname(prRecipientFields.getFirstname());
			newProfileRecipientFields.setGender(prRecipientFields.getGender());
			newProfileRecipientFields.setLastname(prRecipientFields.getLastname());
			newProfileRecipientFields.setMailtype(prRecipientFields.getMailtype());
			newProfileRecipientFields.setTemporaryId(prRecipientFields.getTemporaryId());
			newProfileRecipientFields.setTitle(prRecipientFields.getTitle());
			newProfileRecipientFields.setMailtypeDefined(prRecipientFields.getMailtypeDefined());
			lTempProfileRecipientFields.add(newProfileRecipientFields);
		}
		List<ProfileRecipientFields> lProfileRecipientFields = getBeans();
		Map<String, Boolean> mColumnMapping = new LinkedHashMap<String, Boolean>();
		for (ColumnMapping columnMapping : this.importProfile.getColumnMapping()) {
			mColumnMapping.put(columnMapping.getDatabaseColumn(), columnMapping.getMandatory());
		}
		for (ProfileRecipientFields tprofileRecipientFields : lTempProfileRecipientFields) {
			if ((mColumnMapping.get("gender") == null) || (!mColumnMapping.get("gender") && StringUtils.isEmpty(tprofileRecipientFields.getGender()))) {
				tprofileRecipientFields.setGender("2");
			}
			for (String key : tprofileRecipientFields.getCustomFields().keySet()) {
				if (mColumnMapping.containsKey(key) && !mColumnMapping.get(key) && FieldsFactory.mTypeColums.containsKey(key)) {
					if (FieldsFactory.mTypeColums.get(key).equals(DataType.DOUBLE)) {
						if (tprofileRecipientFields.getCustomFields().get(key).isEmpty()) {
							tprofileRecipientFields.getCustomFields().put(key, "0.0");
						}
					} else if (FieldsFactory.mTypeColums.get(key).equals(DataType.INTEGER)) {
						if (tprofileRecipientFields.getCustomFields().get(key).isEmpty()) {
							tprofileRecipientFields.getCustomFields().put(key, "0");
						}
					} else if (FieldsFactory.mTypeColums.get(key).equals(DataType.DATE)) {
						if (tprofileRecipientFields.getCustomFields().get(key).isEmpty()) {
							final SimpleDateFormat dateFormat = new SimpleDateFormat(DateFormat.getValue(this.getImportProfile().getDateFormat()));
							tprofileRecipientFields.getCustomFields().put(key, dateFormat.format(new Date(System.currentTimeMillis())));
						}
					}
				}
			}
		}
		// Tell the validator which bean to validate against.
		int iterator = 0;
		for (ProfileRecipientFields profileRecipientFields : lTempProfileRecipientFields) {
			/* 
			 * AGNEMM-1696:
			 * For umlauts in domains, validate punycoded domain name.
			 * 1. Make backup of original email address
			 * 2. Punycode email address
			 * 3. Validate
			 * 4. Restore email address
			 */
			// Umlaut-domains (1): make backup of email address
			String originalEmail = profileRecipientFields.getEmail();
			// Umlaut-domains (2): punycode address
			profileRecipientFields.setEmail( StringOps.punycoded( originalEmail));
			
			validator.setParameter(Validator.BEAN_PARAM, profileRecipientFields);

			if (logger.isInfoEnabled())
				logger.info("Import ID: " + importProfile.getImportId() + " Preparing to validate recipient: "
						+ Toolkit.getValueFromBean(profileRecipientFields, importProfile.getKeyColumn()));

			ValidatorResults results = validator.validate();
			if (results.isEmpty()) {
				validRecipients.put(lProfileRecipientFields.get(iterator), null);
			} else {
				invalidRecipients.put(lProfileRecipientFields.get(iterator), results);
			}
			
			// Umlaut-domains (4): restore email address
			profileRecipientFields.setEmail( originalEmail);

			if (logger.isInfoEnabled())
				logger.info("Import ID: " + importProfile.getImportId() + " Validated recipient: " + Toolkit.getValueFromBean(profileRecipientFields, importProfile.getKeyColumn()));

			iterator++;
		}
	}

	void initValidator() {
		validator.setParameter("org.agnitas.beans.ImportProfile", importProfile);
		validator.setParameter("java.lang.Integer", new Integer(maxGenderValue));
	}

	/**
	 * Pushes a series of names onto the current parsing context.
	 * 
	 * @param path
	 *            The path to push - this comprises a series of element/property
	 *            names
	 * @throws Exception
	 */
	public void push(String... path) throws Exception {
		for (String aPath : path) {
			Node node = createNode(nodeStack.peek().getContext(), aPath);
			nodeStack.push(node);
		}
	}

	/**
	 * Applies a textual value to the current node.
	 * <p>
	 * Note that this value is not applied until the current node is popped.
	 * </p>
	 * 
	 * @param value
	 *            The value to apply to the current node
	 * @return Returns this BeanBuilder to permit simple chaining
	 * @throws Exception
	 *             Thrown if the value could not be applied to the current node,
	 *             typically because it couldn't be converted to the desired
	 *             type.
	 */
	public void apply(String value) throws Exception {
		nodeStack.peek().setText(value);

	}

	/**
	 * Pops a series of names from the current parsing context.
	 * <p>
	 * The path is popped <i>in reverse order</i>.
	 * </p>
	 * 
	 * @param path
	 *            The part to pop - this comprises a series of element/property
	 *            names
	 * @return Returns this BeanBuilder to permit simple chaining
	 * @throws Exception
	 */
	public void pop(String... path) throws Exception {
		for (int idx = path.length - 1; idx >= 0; idx--) {
			Node node = nodeStack.pop();
			nodeStack.peek().apply(node.getName(), node.getValue());
		}
	}

	protected Node createNode(Object context, String name) throws Exception {
		Class<?> type = null;

		// If the name represents a JavaBean property of the current context
		// then we derive the type from that...
		PropertyDescriptor propertyDescriptor = Toolkit.getPropertyDescriptor(context, name);
		if (propertyDescriptor != null) {
			type = propertyDescriptor.getPropertyType();
		} else if (context != null && !classMap.containsKey(name)) {
			return new FieldNode(context, name);
		} else {
			// ... otherwise we look for a named type alias
			type = classMap.get(name);
		}

		if (type == null) {
			throw new IllegalArgumentException(String.format("No type mapping could be found or derived: name=%s", name));
		}

		// If there's a format for the node's type then we go with that...
		if (type.isAssignableFrom(String.class) || type.isAssignableFrom(Map.class)) {
			return new FieldNode(context, name);
		}

		// ...otherwise we've got some sort of mutable node value.
		Object instance;
		// If the node corresponds to a JavaBean property which already has a
		// value then we mutate that...
		if (propertyDescriptor != null) {
			instance = propertyDescriptor.getReadMethod().invoke(context);
			if (instance == null) {
				instance = type.newInstance();
				propertyDescriptor.getWriteMethod().invoke(context, instance);
			}
		} else {
			// ...otherwise we're just dealing with some non-property instance
			instance = type.newInstance();
		}

		// Collections are handled in a special way - all properties are
		// basically their values
		if (instance instanceof Collection) {
			return new CollectionNode(name, (Collection) instance);
		}
		// Everything else is assumed to be a JavaBean
		return new JavaBeanNode(instance, name);
	}

	public void handleRow(String[] row) throws Exception {
		// If we haven't been sent the header data yet then we store them (but don't process them)
		if (columns == null) {
			columns = filedsFactory.createColumnHeader(row, importProfile);
			// final Form form = resources.getForm(Locale.getDefault(), FORM_NAME);
			final Form customForm = new Form();
			customForm.setName(FORM_NAME);
			final FormSet formSet = new FormSet();
			formSet.addForm(customForm);
			resources.addFormSet(formSet);
			filedsFactory.createRulesForCustomFields(columns, customForm, importRecipientsDao, importProfile);
			initColumnsNullableCheck(columns);
		} else {
			push("fields");
			setDefaultMailType();
			for (int idx = 0; (idx < columns.length) && (idx < row.length); idx++) {
				/*
				 * if(!columns[idx].getImportedColumn()) { continue; }
				 */
				String value = row[idx];
				if (StringUtils.isEmpty(value)) {
					value = getDefaultValueFromImportProfile(idx);
				}
				
				if (columns[idx].getColName().toLowerCase().equals(ImportUtils.MAIL_TYPE_DB_COLUMN)) {
					value = adjustMailtype(value);
					if (value != null) {
						push("mailtypeDefined");
						apply(ImportUtils.MAIL_TYPE_DEFINED);
						pop("mailtypeDefined");
					}
				}
	
				push(columns[idx].getColName());
				apply(value);
				pop(columns[idx].getColName());
			}
			pop("fields");
		}
	}

	/**
	 * If the mailtype value is a string ("txt", "text", "html") - return the
	 * appropriate int value
	 * 
	 * @param value
	 *            mailtype value
	 * @return adjusted mailtype value
	 */
	private String adjustMailtype(String value) {
		if (value != null) {
			if (value.toLowerCase().equals(ImportUtils.MAIL_TYPE_HTML)) {
				return "1";
			} else if (value.toLowerCase().equals(ImportUtils.MAIL_TYPE_TEXT) || value.toLowerCase().equals(ImportUtils.MAIL_TYPE_TEXT_ALT)) {
				return "0";
			}
		}
		return value;
	}

	private void setDefaultMailType() throws Exception {

		push("mailtype");
		apply(String.valueOf(importProfile.getDefaultMailType()));
		pop("mailtype");
	}

	private String getDefaultValueFromImportProfile(int idx) {
		final List<ColumnMapping> mappingList = importProfile.getColumnMapping();
		for (ColumnMapping columnMapping : mappingList) {
			if (columnMapping.getDatabaseColumn().equals(columns[idx].getColName())) {
				return columnMapping.getDefaultValue();
			}
		}
		return null;
	}

	@Override
	public void setInputFile(File inputFile) {
		this.inputFile = inputFile;
	}

	@Override
	public Integer getProfileId() {
		return profileId;
	}

	@Override
	public void setProfileId(Integer profileId) {
		this.profileId = profileId;
	}

	void setImportProfile(ImportProfile importProfile) {
		this.importProfile = importProfile;
	}

	@Override
	public ImportProfile getImportProfile() {
		return importProfile;
	}

	/**
	 * Returns the list of Beans after parsing or after fixed by hand .
	 * 
	 * @return
	 */
	List<ProfileRecipientFields> getBeans() {
		if (rootNode != null) {
			return (List<ProfileRecipientFields>) rootNode.getValue();
		} else {
			return beansAfterEditOnErrorEditPage;
		}
	}

	@Override
	public CustomerImportStatus getStatus() {
		return status;
	}

	@Override
	public void setStatus(CustomerImportStatus newStatus) {
		status = newStatus;
	}

	@Override
	public void setImportLoggerDao(ImportLoggerDao importLoggerDao) {
		this.importLoggerDao = importLoggerDao;
	}

	@Override
	public ImportRecipientsDao getImportRecipientsDao() {
		return importRecipientsDao;
	}

	@Override
	public void setImportRecipientsDao(ImportRecipientsDao importRecipientsDao) {
		this.importRecipientsDao = importRecipientsDao;
	}

	@Override
	public ImportProfileDao getImportProfileDao() {
		return importProfileDao;
	}

	@Override
	public void setImportProfileDao(ImportProfileDao importProfileDao) {
		this.importProfileDao = importProfileDao;
	}

	@Override
	public LinkedList<LinkedList<String>> getPreviewParsedContent(ActionMessages errors) throws Exception {
		BufferedReader in = null;
		int lineNumber = 0;
		LinkedList<LinkedList<String>> previewParsedContent = new LinkedList<LinkedList<String>>();
		try {
			in = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), Charset.getValue(importProfile.getCharset())));
			while (lineNumber <= 20) {
				final String line = in.readLine();

				if (line == null) {
					break;
				}
				String[] row = null;
				try {
					row = new CsvTokenizer(line, Separator.getValue(importProfile.getSeparator()), TextRecognitionChar.getValue(importProfile.getTextRecognitionChar())).toArray();
				} catch (Exception e) {
					errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("import.csv_errors_linestructure", lineNumber));
				}
				// Null indicates that the row should be ignored
				if (row == null) {
					continue;
				}
				final LinkedList<String> linelinkedList = new LinkedList<String>();
				lineNumber++;
				// If we haven't been sent the header data yet then we store
				// them (but don't process them)
				if (columns == null) {
					columns = new CSVColumnState[row.length];
					for (int i = 0; i < row.length; i++) {
						String headerName = row[i];
						final String columnNameByCvsFileName = filedsFactory.getDBColumnNameByCvsFileName(headerName, importProfile);
						if (columnNameByCvsFileName != null) {
							columns[i] = new CSVColumnState();
							columns[i].setColName(columnNameByCvsFileName);
							columns[i].setImportedColumn(true);
						} else {
							columns[i] = new CSVColumnState();
							columns[i].setColName(headerName);
							columns[i].setImportedColumn(false);
						}
					}
					initColumnsNullableCheck(columns);
				}

				for (int idx = 0; (idx < columns.length) && (idx < row.length); idx++) {
					if (!columns[idx].getImportedColumn()) {
						continue;
					}
					String value = row[idx];

					linelinkedList.add(value);
				}
				previewParsedContent.add(linelinkedList);
			}

		} finally {
			columns = null;
			IOUtils.closeQuietly(in);
		}
		return previewParsedContent;
	}

	private void initColumnsNullableCheck(CSVColumnState[] cols) {
		Map<String, CsvColInfo> columnsInfo = recipientDao.readDBColumns(importProfile.getCompanyId());
		for (CSVColumnState columnState : cols) {
			CsvColInfo columnInfo = columnsInfo.get(columnState.getColName());
			if (columnInfo != null) {
				columnState.setNullable(columnInfo.isNullable());
			}
		}
	}

	@Override
	public Integer getAdminId() {
		return adminId;
	}

	@Override
	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	@Override
	public CSVColumnState[] getColumns() {
		return columns;
	}

	@Override
	public void setColumns(CSVColumnState[] columns) {
		this.columns = columns;
	}

	@Override
	public boolean isPresentErrorForErrorEditPage() {
		return importRecipientsDao.getRecipientsCountByType(new Integer[] { NewImportWizardService.RECIPIENT_TYPE_FIELD_INVALID }, adminId, status.getDatasourceID()) > 0;
	}

	@Override
	public List<ProfileRecipientFields> getBeansAfterEditOnErrorEditPage() {
		return beansAfterEditOnErrorEditPage;
	}

	@Override
	public void setBeansAfterEditOnErrorEditPage(List<ProfileRecipientFields> beansAfterEditOnErrorEditPage) {
		this.beansAfterEditOnErrorEditPage = beansAfterEditOnErrorEditPage;
	}

	/**
	 * Log import action to database
	 * 
	 * @param datasourceId
	 * @param lines
	 *            the number of imported lines
	 * @param statistics
	 *            - statistic as string
	 */
	@Override
	public void log(int datasourceId, int lines, String statistics) {
		importLoggerDao.log(importProfile.getCompanyId(), adminId, datasourceId, lines, statistics, ImportUtils.describe(importProfile));
	}

	@Override
	public void setRecipientDao(RecipientDao recipientDao) {
		this.recipientDao = recipientDao;
	}

	@Override
	public RecipientDao getRecipientDao() {
		return recipientDao;
	}

	@Override
	public boolean isRecipientLimitReached() {
		return recipientLimitReached;
	}

	@Override
	public boolean isImportLimitReached() {
		return importLimitReached;
	}

	@Override
	public boolean isNearLimit() {
		return nearLimit;
	}

	@Override
	public int getCompletedPercent() {
		return completedPercent;
	}

	@Override
	public void setCompletedPercent(int completedPercent) {
		if (completedPercent > 100) {
			this.completedPercent = 100;
		} else {
			this.completedPercent = completedPercent;
		}
	}

	@Override
	public Integer getCompanyId() {
		return companyId;
	}

	@Override
	public void setCompanyId(@VelocityCheck Integer companyId) {
		this.companyId = companyId;
	}

	public int getMaxGenderValue() {
		return maxGenderValue;
	}

	@Override
	public void setMaxGenderValue(int maxGenderValue) {
		this.maxGenderValue = maxGenderValue;
	}

	private static class RootNode extends Node {

		public RootNode() {
			super(null, "[root]");
		}

		private Object value;

		@Override
		public void apply(String name, Object value) throws Exception {
			this.value = value;
		}

		@Override
		public Object getValue() {
			return value;
		}

		@Override
		public void setText(String text) throws Exception {
		}

	}

	/**
	 * Size of the batch for importing lines from csv file
	 * 
	 * @param blockSize
	 */
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
}
