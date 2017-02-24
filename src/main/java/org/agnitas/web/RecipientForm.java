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

import org.agnitas.beans.BindingEntry;
import org.agnitas.beans.ImageButton;
import org.agnitas.target.TargetOperator;
import org.agnitas.util.AgnUtils;
import org.agnitas.util.CaseInsensitiveMap;
import org.agnitas.web.forms.StrutsFormBase;
import org.agnitas.web.forms.helper.EmptyStringFactory;
import org.agnitas.web.forms.helper.ImageButtonFactory;
import org.agnitas.web.forms.helper.ZeroIntegerFactory;
import org.apache.commons.collections.Factory;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.GrowthList;
import org.apache.commons.collections.list.LazyList;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RecipientForm extends StrutsFormBase  {
	private static final long serialVersionUID = -1626162472029428066L;
	
	private static transient final Factory imageButtonFactory = new ImageButtonFactory();
	private static transient final Factory emptyStringFactory = new EmptyStringFactory();
	private static transient final Factory zeroIntegerFactory = new ZeroIntegerFactory();
	private static transient final Factory nullFactory = FactoryUtils.nullFactory();
	
	public static transient final int COLUMN_TYPE_STRING = 0;
	public static transient final int COLUMN_TYPE_NUMERIC = 1;
	public static transient final int COLUMN_TYPE_DATE = 2;
	
	public static final String[] DEFAULT_FIELDS = {RecipientAction.COLUMN_GENDER, RecipientAction.COLUMN_FIRSTNAME, RecipientAction.COLUMN_LASTNAME};
  
    protected int action;
	protected int recipientID = 0;
    protected int gender;
    protected int mailtype = 1;
    protected int user_status;
    protected int listID;
    protected int all;
    
    protected String title = "";
    protected String firstname = "";
    protected String lastname = "";
    protected String email = "";
    protected String user_type = "E";
    
	private String searchFirstName = "";
	private String searchLastName = "";
	private String searchEmail = "";
    
    private ImageButton updateButton;
    private ImageButton deleteButton;
    
    private List<ImageButton> targetRemoveList;
    private List<String> columnAndTypeList;
    private List<Integer> chainOperatorList;
    private List<Integer> parenthesisOpenedList;
    private List<Integer> primaryOperatorList;
    private List<String> primaryValueList;
    private List<Integer> parenthesisClosedList;
    private List<String> dateFormatList;
    private List<Integer> secondaryOperatorList;
    private List<String> secondaryValueList;
    private List<TargetOperator[]> validTargetOperatorsList;
    private List<String> columnNameList;
    private List<Integer> columnTypeList;
    private String[] selectedFields;
    private String[] selectedFieldsOld;

    private ImageButton targetAddButton;
    private String columnAndTypeNew;
    private int chainOperatorNew;
    private int parenthesisOpenedNew;
    private int primaryOperatorNew;
    private String primaryValueNew;
    private int parenthesisClosedNew;
    private String dateFormatNew;
    private int secondaryOperatorNew;
    private String secondaryValueNew;
    private boolean recipientFieldsVisible;
	protected boolean advancedSearchVisible;
    
    protected Map<String, Object> column = new CaseInsensitiveMap<Object>();
    protected Map<Integer, Map<Integer, BindingEntry>> mailing = new HashMap<Integer, Map<Integer, BindingEntry>>();
    
    protected int targetID;
    
    protected boolean overview = true;	// recipient overview or recipient search?

    protected ActionMessages messages;
    protected ActionMessages errors;

    protected boolean deactivatePagination;

    protected boolean fromListPage;

    protected int adminId;

    public RecipientForm() {
    	updateButton = new ImageButton();
    	deleteButton = new ImageButton();
    	targetAddButton = new ImageButton();
    	
    	targetRemoveList = (List<ImageButton>) GrowthList.decorate(LazyList.decorate(new ArrayList<ImageButton>(), imageButtonFactory));
        columnAndTypeList = (List<String>) GrowthList.decorate(LazyList.decorate(new ArrayList<String>(), emptyStringFactory));
        chainOperatorList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
        parenthesisOpenedList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
        primaryOperatorList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
        primaryValueList = (List<String>) GrowthList.decorate(LazyList.decorate(new ArrayList<String>(), emptyStringFactory));
        parenthesisClosedList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
        dateFormatList = (List<String>) GrowthList.decorate(LazyList.decorate(new ArrayList<String>(), emptyStringFactory));
        secondaryOperatorList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
        secondaryValueList = (List<String>) GrowthList.decorate(LazyList.decorate(new ArrayList<String>(), emptyStringFactory));
        validTargetOperatorsList = (List<TargetOperator[]>) GrowthList.decorate(LazyList.decorate(new ArrayList<TargetOperator[]>(), nullFactory));
        columnNameList = (List<String>) GrowthList.decorate(LazyList.decorate(new ArrayList<String>(), emptyStringFactory));
        columnTypeList = (List<Integer>) GrowthList.decorate(LazyList.decorate(new ArrayList<Integer>(), zeroIntegerFactory));
		advancedSearchVisible = false;
		selectedFields = DEFAULT_FIELDS;
		selectedFieldsOld = DEFAULT_FIELDS;
    }
    
    public void reset(ActionMapping mapping, HttpServletRequest request) {
    	super.reset(mapping, request);
    	
        // Reset all image buttons
        for(ImageButton button : targetRemoveList)
        	button.clearButton();
        targetAddButton.clearButton();
        updateButton.clearButton();
        deleteButton.clearButton();
        
        // Reset form fields for new rule
        columnAndTypeNew = null;
        chainOperatorNew = 0;
        parenthesisOpenedNew = 0;
        primaryOperatorNew = 0;
        primaryValueNew = null;
        parenthesisClosedNew = 0;
        dateFormatNew = null;
        secondaryOperatorNew = 0;
        secondaryValueNew = null;
    }
    
    public void clearRules() {
        targetRemoveList.clear();
        columnAndTypeList.clear();
        chainOperatorList.clear();
        parenthesisOpenedList.clear();
        primaryOperatorList.clear();
        primaryValueList.clear();
        parenthesisClosedList.clear();
        dateFormatList.clear();
        secondaryOperatorList.clear();
        secondaryValueList.clear();
        columnNameList.clear();
        columnTypeList.clear();
    }
    
	/**
     * Validate the properties that have been set from this HTTP request,
     * and return an <code>ActionErrors</code> object that encapsulates any
     * validation errors that have been found.  If no errors are found, return
     * <code>null</code> or an <code>ActionErrors</code> object with no
     * recorded error messages.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     * @return errors
     */
    public ActionErrors formSpecificValidate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        if(request.getParameter("trgt_clear") != null) {
            setRecipientID(0);
            clearRules();
                      
            if( action != RecipientAction.ACTION_LIST ){ // reset filter fields only if there is no future running
            	setUser_status(0);
            	setUser_type("E");
            	setTargetID(0);
               	setListID(0);
            }
        }
        
		if (AgnUtils.parameterNotEmpty(request, "Update")) {
        	if(!this.checkParenthesisBalance()) 
        		errors.add("brackets", new ActionMessage("error.target.bracketbalance"));

        	/*
        	if(this.getNumTargetNodes() == 0) { // We need "1" here, because the count includes the row containing the data to be added
                errors.add("norule", new ActionMessage("error.target.norule"));
            }
            */
        }

        if(action != RecipientAction.ACTION_VIEW_WITHOUT_LOAD && AgnUtils.parameterNotEmpty(request, "save")) {
            if(!AgnUtils.isEmailValid(email)) {
                errors.add("email",new ActionMessage("error.invalid.email"));
            }
            if (this.title.length() > 100)
                errors.add("title", new ActionMessage("error.recipient.title.tooLong"));
            if (this.firstname.length() > 100)
                errors.add("firstname", new ActionMessage("error.recipient.firstname.tooLong"));
            if (this.lastname.length() > 100)
                errors.add("lastname", new ActionMessage("error.recipient.lastname.tooLong"));
        }

        return errors;
    }
    
    protected boolean checkParenthesisBalance() {
    	int opened = 0;
    	int closed = 0;
    	
    	int lastIndex = this.getNumTargetNodes();
    	
    	for(int index = 0; index < lastIndex; index++) {
    		opened += this.getParenthesisOpened(index);
    		closed += this.getParenthesisClosed(index);
    	}
    	
    	return opened == closed;
    }

	/**
	 * Getter for property advancedSearchVisible
	 *
	 * @return value of property advancedSearchVisible
	 */
	public boolean isAdvancedSearchVisible() {
		return advancedSearchVisible;
	}

	/**
	 * Setter for property advancedSearchVisible
	 *
	 * @param advancedSearchVisible new value of property advancedSearchVisible
	 */
	public void setAdvancedSearchVisible(boolean advancedSearchVisible) {
		this.advancedSearchVisible = advancedSearchVisible;
	}

	/**
     * Getter for property action.
     *
     * @return Value of property action.
     */
    public int getAction() {
        return this.action;
    }

    /**
     * Setter for property action.
     *
     * @param action New value of property action.
     */
    public void setAction(int action) {
        this.action = action;
    }

	/**
     * Getter for property recipientID.
     *
     * @return Value of property recipientID.
     */
    public int getRecipientID() {
        return this.recipientID;
    }

    /**
     * Setter for property recipientID.
     *
     * @param recipientID New value of property recipientID.
     */
    public void setRecipientID(int recipientID) {
        this.recipientID=recipientID;
    }

    /**
     * Getter for property gender.
     *
     * @return Value of property gender.
     */
    public int getGender() {
        return this.gender;
    }

    /**
     * Setter for property gender.
     *
     * @param gender New value of property gender.
     */
    public void setGender(int gender) {
        this.gender=gender;
    }

    /**
     * Getter for property mailtype.
     *
     * @return Value of property mailtype.
     */
    public int getMailtype() {
        return this.mailtype;
    }

    /**
     * Setter for property mailtype.
     *
     * @param mailtype New value of property mailtype.
     */
    public void setMailtype(int mailtype) {
        this.mailtype=mailtype;
    }

    /**
     * Getter for property user_status.
     *
     * @return Value of property user_status.
     */
    public int getUser_status() {
        return this.user_status;
    }

   /**
     * Setter for property user_status.
     *
     * @param user_status New value of property user_status.
     */
    public void setUser_status(int user_status) {
        this.user_status=user_status;
    }

    /**
     * Getter for property listID.
     *
     * @return Value of property listID.
     */
    public int getListID() {
        return this.listID;
    }

    /**
     * Setter for property listID.
     *
     * @param listID New value of property listID.
     */
    public void setListID(int listID) {
        this.listID=listID;
    }

    /**
     * Getter for property title.
     *
     * @return Value of property title.
     */
    public String getTitle() {
        return this.title;
    }

    /**
     * Setter for property title.
     *
     * @param title New value of property title.
     */
    public void setTitle(String title) {
        this.title=title;
    }

    /**
     * Getter for property firstname.
     *
     * @return Value of property firstname.
     */
    public String getFirstname() {
        return this.firstname;
    }

    /**
     * Setter for property firstname.
     *
     * @param firstname New value of property firstname.
     */
    public void setFirstname(String firstname) {
        this.firstname=firstname;
    }

    /**
     * Getter for property lastname.
     *
     * @return Value of property lastname.
     */
    public String getLastname() {
        return this.lastname;
    }

    /**
     * Setter for property lastname.
     *
     * @param lastname New value of property lastname.
     */
    public void setLastname(String lastname) {
        this.lastname=lastname;
    }

    /**
     * Getter for property email.
     *
     * @return Value of property email.
     */
    public String getEmail() {
        return this.email.toLowerCase();
    }

    /**
     * Setter for property email.
     *
     * @param email New value of property email.
     */
    public void setEmail(String email) {
        this.email=email;
    }

	/**
	 * Getter for property searchFirstName
	 *
	 * @return value of property searchFirstName
	 */
	public String getSearchFirstName() {
		return searchFirstName;
	}

	/**
	 * Setter for property searchFirstName
	 *
	 * @param searchFirstName new value for property searchFirstName
	 */
	public void setSearchFirstName(String searchFirstName) {
		this.searchFirstName = searchFirstName;
	}

	/**
	 * Getter for property searchLastName
	 *
	 * @return value of property searchLastName
	 */
	public String getSearchLastName() {
		return searchLastName;
	}

	/**
	 * Setter for property searchLastName
	 *
	 * @param searchLastName new value for property searchLastName
	 */
	public void setSearchLastName(String searchLastName) {
		this.searchLastName = searchLastName;
	}

	/**
	 * Getter for property searchEmail
	 *
	 * @return value of property searchEmail
	 */
	public String getSearchEmail() {
		return searchEmail;
	}

	/**
	 * Setter for property searchEmail
	 *
	 * @param searchEmail new value for property searchEmail
	 */
	public void setSearchEmail(String searchEmail) {
		this.searchEmail = searchEmail;
	}

	/**
     * Getter for property user_type.
     *
     * @return Value of property user_type.
     */
    public String getUser_type() {
        return this.user_type;
    }

    /**
     * Setter for property user_type.
     *
     * @param user_type New value of property user_type.
     */
    public void setUser_type(String user_type) {
        this.user_type=user_type;
    }

    /**
     * Getter for property columnMap.
     *
     * @return Value of property columnsMap.
     */
    public Map<String, Object> getColumnMap() {
        return column;
    }

    public void clearColumns() {
        setFirstname( "");
        setLastname( "");
        setTitle( "");
        setEmail( "");
        setGender( 0);

        this.column.clear();
    }

    /**
     * Getter for property columns.
     *
     * @return Value of property column.
     */
    public Object getColumn(String key) {
        return column.get(key);
    }

    /**
     * Setter for property column.
     *
     * @param key The name of the column to set.
     * @param value New value for the column.
     */
    public void setColumn(String key, Object value) {
        column.put(key, value);
    }

    /**
     * Getter for property bindingEntry.
     *
     * @return Value of property bindingEntry.
     */
    public BindingEntry getBindingEntry(int id) {
        Map<Integer, BindingEntry> sub=null;

        sub = mailing.get(new Integer(id));
        if(sub == null) {
            sub = new HashMap<Integer, BindingEntry>();
            mailing.put(new Integer(id), sub);
        }

        if(sub.get(new Integer(0)) == null) {
            BindingEntry entry=(BindingEntry) getWebApplicationContext().getBean("BindingEntry");

            entry.setMailinglistID(id);
            entry.setMediaType(0);
            sub.put(new Integer(0), entry);
        }
        return sub.get(new Integer(0));
    }

    /**
     * Setter for property bindingEntry.
     *
     * @param id New value of property bindingEntry.
     */
    public void setBindingEntry(int id, BindingEntry info) {
        Map<Integer, BindingEntry> sub=null;
        Integer mt=new Integer(info.getMediaType());

        sub = mailing.get(new Integer(id));
        if(sub == null) {
            sub=new HashMap<Integer, BindingEntry>();
        }
        if(info == null) {
        	//TODO: Dead Code: But I don't get the clue what is intended to happen
            sub.remove(mt);
        } else {
            sub.put(mt, info);
        }
        mailing.put(new Integer(id), sub);
    }

    /**
     * Getter for property allBindings.
     *
     * @return Value of property allBindings.
     */
    public Map<Integer, Map<Integer, BindingEntry>> getAllBindings() {
        return mailing;
    }

	public int getTargetID() {
		return targetID;
	}

	public void setTargetID(int targetID) {
		this.targetID = targetID;
	}

	public int getAll() {
		return all;
	}

	public void setAll(int all) {
		this.all = all;
	}
	
	/**
	 * if overview = true, we have the recipient overview.
	 * if overview = false, we have the recipient search.
	 * @return
	 */
	public boolean isOverview() {
		return overview;
	}
	
	public void setOverview(boolean overview) {
		this.overview = overview;
	}
	
	public void setMessages(ActionMessages messages) {
		this.messages = messages;
	}
	
	public ActionMessages getMessages() {
		return this.messages;
	}

    public ActionMessages getErrors() {
        return errors;
    }

    public void addErrors(ActionMessages errors) {
        if (this.errors == null) {
            this.errors = new ActionMessages();
        }
        this.errors.add(errors);
    }

    public void resetErrors() {
        this.errors = new ActionMessages();
    }

    public ImageButton getUpdate() {
		return this.updateButton;
	}
	
	public void setUpdate(String value) {
		this.updateButton.setLabel(value);
	}
	
	public ImageButton getDelete() {
		return this.deleteButton;
	}
	
	public void setDelete(String value) {
		this.deleteButton.setLabel(value);
	}
	
	public ImageButton getTargetAdd() {
		return this.targetAddButton;
	}
	
	public void setTargetAdd(String value) {
		this.targetAddButton.setLabel(value);
	}
	
	public void removeRule(int index) {
        safeRemove(targetRemoveList, index);
        safeRemove(columnAndTypeList, index);
        safeRemove(chainOperatorList, index);
        safeRemove(parenthesisOpenedList, index);
        safeRemove(primaryOperatorList, index);
        safeRemove(primaryValueList, index);
        safeRemove(parenthesisClosedList, index);
        safeRemove(dateFormatList, index);
        safeRemove(secondaryOperatorList, index);
        safeRemove(secondaryValueList, index);
        safeRemove(columnNameList, index);
        safeRemove(columnTypeList, index);
	}
	
	/**
	 * Removes and index safely from list. If index does not exists, nothing happens.
	 * 
	 * @param list list to remove index from
	 * @param index index to be removed
	 */
	private void safeRemove(List<?> list, int index) {
		if( list.size() > index && index >= 0)
			list.remove(index);
	}
	
	public int getNumTargetNodes() {
		return this.columnAndTypeList.size();
	}
	
	public String getColumnAndType(int index) {
		return this.columnAndTypeList.get(index);
	}
	
	public void setColumnAndType(int index, String value) {
		this.columnAndTypeList.set(index, value);
	}
	
	public ImageButton getTargetRemove(int index) {
		return this.targetRemoveList.get(index);
	}
	
	public void setTargetRemove(int index, String value) {
		this.targetRemoveList.get(index).setLabel(value); // Needed to delegate it to correct setter method, otherwise we get an invalid type exception
	}
	
	public int getChainOperator(int index) {
		return this.chainOperatorList.get(index);
	}
	
	public void setChainOperator(int index, int value) {
		this.chainOperatorList.set(index, value);
	}
	
	public int getParenthesisOpened(int index) {
		return this.parenthesisOpenedList.get(index);
	}
	
	public void setParenthesisOpened(int index, int value) {
		this.parenthesisOpenedList.set(index, value);
	}
	
	public int getPrimaryOperator(int index) {
		return this.primaryOperatorList.get(index);
	}
	
	public void setPrimaryOperator(int index, int value) {
		this.primaryOperatorList.set(index, value);
	}
	
	public String getPrimaryValue(int index) {
		return this.primaryValueList.get(index);
	}
	
	public void setPrimaryValue(int index, String value) {
		this.primaryValueList.set(index, value);
	}
	
	public int getParenthesisClosed(int index) {
		return this.parenthesisClosedList.get(index);
	}
	
	public void setParenthesisClosed(int index, int value) {
		this.parenthesisClosedList.set(index, value);
	}
	
	public String getDateFormat(int index) {
		return this.dateFormatList.get(index);
	}
	
	public void setDateFormat(int index, String value) {
		this.dateFormatList.set(index, value);
	}
	
	public int getSecondaryOperator(int index) {
		return this.secondaryOperatorList.get(index);
	}
	
	public void setSecondaryOperator(int index, int value) {
		this.secondaryOperatorList.set(index, value);
	}
	
	public String getSecondaryValue(int index) {
		return this.secondaryValueList.get(index);
	}
	
	public void setSecondaryValue(int index, String value) {
		this.secondaryValueList.set(index, value);
	}
	
	public List<String> getAllColumnsAndTypes() {
		return this.columnAndTypeList;
	}
	
	public void setValidTargetOperators(int index, TargetOperator[] operators) {
		this.validTargetOperatorsList.set(index, operators);
	}
	
	public TargetOperator[] getValidTargetOperators(int index) {
		return this.validTargetOperatorsList.get(index);
	}
	
	public void setColumnName(int index, String value) {
		this.columnNameList.set(index, value);
	}
	
	public String getColumnName(int index) {
		return this.columnNameList.get(index);
	}
	
	public void setColumnType(int index, int type) {
		this.columnTypeList.set(index, type);
	}
	
	public int getColumnType(int index) {
		return this.columnTypeList.get(index);
	}

	public String getColumnAndTypeNew() {
		return columnAndTypeNew;
	}

	public void setColumnAndTypeNew(String columnAndTypeNew) {
		this.columnAndTypeNew = columnAndTypeNew;
	}

	public int getChainOperatorNew() {
		return chainOperatorNew;
	}

	public void setChainOperatorNew(int chainOperatorNew) {
		this.chainOperatorNew = chainOperatorNew;
	}

	public int getParenthesisOpenedNew() {
		return parenthesisOpenedNew;
	}

	public void setParenthesisOpenedNew(int parenthesisOpenedNew) {
		this.parenthesisOpenedNew = parenthesisOpenedNew;
	}

	public int getPrimaryOperatorNew() {
		return primaryOperatorNew;
	}

	public void setPrimaryOperatorNew(int primaryOperatorNew) {
		this.primaryOperatorNew = primaryOperatorNew;
	}

	public String getPrimaryValueNew() {
		return primaryValueNew;
	}

	public void setPrimaryValueNew(String primaryValueNew) {
		this.primaryValueNew = primaryValueNew;
	}

	public int getParenthesisClosedNew() {
		return parenthesisClosedNew;
	}

	public void setParenthesisClosedNew(int parenthesisClosedNew) {
		this.parenthesisClosedNew = parenthesisClosedNew;
	}

	public String getDateFormatNew() {
		return dateFormatNew;
	}

	public void setDateFormatNew(String dateFormatNew) {
		this.dateFormatNew = dateFormatNew;
	}

	public int getSecondaryOperatorNew() {
		return secondaryOperatorNew;
	}

	public void setSecondaryOperatorNew(int secondaryOperatorNew) {
		this.secondaryOperatorNew = secondaryOperatorNew;
	}

	public String getSecondaryValueNew() {
		return secondaryValueNew;
	}

	public void setSecondaryValueNew(String secondaryValueNew) {
		this.secondaryValueNew = secondaryValueNew;
	}

    public boolean isDeactivatePagination() {
        return deactivatePagination;
    }

    public void setDeactivatePagination(boolean deactivatePagination) {
        this.deactivatePagination = deactivatePagination;
    }

    public boolean getFromListPage() {
        return fromListPage;
    }

    public void setFromListPage(boolean fromListPage) {
        this.fromListPage = fromListPage;
    }
    
    public void setSelectedFields(String[] selectedFields) {
		this.selectedFields = selectedFields;
	}
    
    public String[] getSelectedFields() {
		return selectedFields;
	}
    
    public void setSelectedFieldsOld(String[] selectedFieldsOld) {
		this.selectedFieldsOld = selectedFieldsOld;
	}
    
    public String[] getSelectedFieldsOld() {
		return selectedFieldsOld;
	}
    
    public void setRecipientFieldsVisible(boolean recipientFieldsVisible) {
		this.recipientFieldsVisible = recipientFieldsVisible;
	}
    
    public boolean isRecipientFieldsVisible() {
		return recipientFieldsVisible;
	}

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }
    
    public void clearRecipientData() {
    	recipientID = 0;
        gender = 2;
        mailtype = 1;
    	title = "";
        firstname = "";
        lastname = "";
        email = "";
        user_type = "E";
        column = new CaseInsensitiveMap<Object>();
        mailing = new HashMap<Integer, Map<Integer, BindingEntry>>();
    }
}
