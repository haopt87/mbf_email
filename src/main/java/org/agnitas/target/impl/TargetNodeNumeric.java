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

package org.agnitas.target.impl;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

import org.agnitas.target.TargetNode;
import org.agnitas.target.TargetOperator;
import org.agnitas.util.AgnUtils;
import org.agnitas.util.SafeString;
import org.apache.log4j.Logger;

/**
 *
 * @author  mhe
 */
public class TargetNodeNumeric extends TargetNode implements Serializable {
	
	/** The logger. */
	private static final transient Logger logger = Logger.getLogger(TargetNodeNumeric.class);

    /** Holds value of property openBracketBefore. */
    protected boolean openBracketBefore;

    /** Holds value of property closeBracketAfter. */
    protected boolean closeBracketAfter;

    /** Holds value of property chainOperator. */
    protected int chainOperator;

    /** Holds value of property primaryOperator. */
    protected int primaryOperator;

    /** Holds value of property primaryField. */
    protected String primaryField;

    /** Holds value of property primaryFieldType. */
    protected String primaryFieldType;

    /** Holds value of property primaryValue. */
    protected String primaryValue;

    /** Holds value of property secondaryValue. */
    protected int secondaryValue;

    /** Holds value of property secondaryOperator. */
    protected int secondaryOperator;

    /** Serial version UID. */
    private static final long serialVersionUID = 6666390160147561038L;

    /** Creates a new instance of TargetNodeString */
    public TargetNodeNumeric() {
    	initializeOperatorLists();
    }
    
    public static TargetOperator[] getValidOperators() {
    	return new TargetOperator[] {
            	OPERATOR_EQ, 
            	OPERATOR_NEQ, 
            	OPERATOR_GT, 
            	OPERATOR_LT, 
            	null, 
            	null, 
            	OPERATOR_MOD, 
            	OPERATOR_IS, 
            	OPERATOR_LT_EQ, 
            	OPERATOR_GT_EQ,
            	null,
            	null
            	};
    }
    
    @Override
	protected void initializeOperatorLists() {
        typeOperators = TargetNodeNumeric.getValidOperators();
	}
    
	public String generateSQL() {
        StringBuffer tmpSQL=new StringBuffer("");

        switch(this.chainOperator) {
            case TargetNode.CHAIN_OPERATOR_AND:
                tmpSQL.append(" AND ");
                break;
            case TargetNode.CHAIN_OPERATOR_OR:
                tmpSQL.append(" OR ");
                break;
            default:
                tmpSQL.append(" ");
        }

        if(this.openBracketBefore) {
            tmpSQL.append("(");
        }

        if(this.primaryOperator!=TargetNode.OPERATOR_MOD.getOperatorCode()) {
            tmpSQL.append("cust.");
            tmpSQL.append(this.primaryField);
            tmpSQL.append(" ");
            tmpSQL.append(this.typeOperators[this.primaryOperator-1].getOperatorSymbol());
            tmpSQL.append(" ");
            tmpSQL.append(SafeString.getSQLSafeString(this.primaryValue));
        } else {
            tmpSQL.append("mod(cust.");
            tmpSQL.append(this.primaryField);
            tmpSQL.append(", ");
            tmpSQL.append(SafeString.getSQLSafeString(this.primaryValue));
            tmpSQL.append(") ");
            
            if( this.secondaryOperator - 1 >= 0 && this.secondaryOperator - 1 < this.typeOperators.length)
            	tmpSQL.append(this.typeOperators[this.secondaryOperator-1].getOperatorSymbol());
            else
            	tmpSQL.append(this.typeOperators[0].getOperatorSymbol());
            
            tmpSQL.append(" ");
            tmpSQL.append(this.secondaryValue);
        }

        if(this.closeBracketAfter) {
            tmpSQL.append(")");
        }

        return tmpSQL.toString();
    }

    public String generateBsh() {
        StringBuffer tmpBsh=new StringBuffer("");

        switch(this.chainOperator) {
            case TargetNode.CHAIN_OPERATOR_AND:
                tmpBsh.append(" && ");
                break;
            case TargetNode.CHAIN_OPERATOR_OR:
                tmpBsh.append(" || ");
                break;
            default:
                tmpBsh.append(" ");
        }

        if(this.openBracketBefore) {
            tmpBsh.append("(");
        }

        
        if (this.primaryOperator == TargetNode.OPERATOR_MOD.getOperatorCode()) {
            tmpBsh.append("(");
            // von ma: fix fuer MOD-bug?
            if( AgnUtils.isOracleDB() ) {
            	tmpBsh.append(this.primaryField.toUpperCase());
            } else {                
            	tmpBsh.append(this.primaryField);
            }
            tmpBsh.append(" % ");
            tmpBsh.append(SafeString.getSQLSafeString(this.primaryValue));
            tmpBsh.append(") ");
            
            if( this.secondaryOperator - 1 >= 0 && this.secondaryOperator - 1 < this.typeOperators.length)
            	tmpBsh.append(this.typeOperators[this.secondaryOperator-1].getBshOperatorSymbol());
            else
            	tmpBsh.append(this.typeOperators[0].getBshOperatorSymbol());
            	
            tmpBsh.append(" ");
            tmpBsh.append(this.secondaryValue);
        } else if (this.primaryOperator == TargetNode.OPERATOR_IS.getOperatorCode()) {
        	if( AgnUtils.isOracleDB() ) {
            	tmpBsh.append(this.primaryField.toUpperCase());
            } else {                
            	tmpBsh.append(this.primaryField);
            }
            if(this.primaryValue.startsWith("null")) {
                tmpBsh.append("==");
            } else {
                tmpBsh.append("!=");
            }
            tmpBsh.append("null ");
        } else {
        	tmpBsh.append("");
            if( AgnUtils.isOracleDB() ) {
            	tmpBsh.append(this.primaryField.toUpperCase());
            } else {                
            	tmpBsh.append(this.primaryField);
            }
            tmpBsh.append(" ");
            tmpBsh.append(this.typeOperators[this.primaryOperator-1].getBshOperatorSymbol());
            tmpBsh.append(" ");
            tmpBsh.append(SafeString.getSQLSafeString(this.primaryValue));
        }

        if(this.closeBracketAfter) {
            tmpBsh.append(")");
        }

        return tmpBsh.toString();
    }

    public void setPrimaryValue(String tmpVal) {
        double tmpNum=0;
        if(this.primaryOperator==TargetNode.OPERATOR_IS.getOperatorCode()) {
            if(!tmpVal.equals("null") && !tmpVal.equals("not null")) {
                this.primaryValue = "null";
            } else {
                this.primaryValue=tmpVal;
            }
        } else {
            try {
                tmpNum=Double.parseDouble(tmpVal);
            } catch (Exception e) {
                logger.error("setPrimaryValue: "+e.getMessage());
            }
            DecimalFormat aFormat=new DecimalFormat("0.###########", new DecimalFormatSymbols(Locale.US));
            this.primaryValue=aFormat.format(tmpNum);
        }
    }

    /** Getter for property secondaryValue.
     * @return Value of property secondaryValue.
     */
    public int getSecondaryValue() {
        return this.secondaryValue;
    }

    /** Setter for property secondaryValue.
     * @param secondaryValue New value of property secondaryValue.
     */
    public void setSecondaryValue(int secondaryValue) {
        this.secondaryValue = secondaryValue;
    }

    /** Getter for property secondaryOperator.
     * @return Value of property secondaryOperator.
     */
    public int getSecondaryOperator() {
        return this.secondaryOperator;
    }

    /** Setter for property secondaryOperator.
     * @param secondaryOperator New value of property secondaryOperator.
     */
    public void setSecondaryOperator(int secondaryOperator) {
        this.secondaryOperator = secondaryOperator;
    }

    public void setPrimaryOperator(int primOp) {
        if(primOp==TargetNode.OPERATOR_LIKE.getOperatorCode())
            primOp=TargetNode.OPERATOR_EQ.getOperatorCode();

        if(primOp==TargetNode.OPERATOR_NLIKE.getOperatorCode())
            primOp=TargetNode.OPERATOR_NEQ.getOperatorCode();

        this.primaryOperator=primOp;
    }

    private void readObject(java.io.ObjectInputStream in)
    throws IOException, ClassNotFoundException {
        ObjectInputStream.GetField allFields=null;
        try {
            allFields=in.readFields();
            this.chainOperator=allFields.get("chainOperator", TargetNode.CHAIN_OPERATOR_NONE);
            this.primaryField=(String)allFields.get("primaryField", "default");
            this.primaryFieldType=(String)allFields.get("primaryFieldType", "DOUBLE");
            this.primaryOperator=allFields.get("primaryOperator", TargetNode.OPERATOR_EQ.getOperatorCode());
            this.primaryValue=(String)allFields.get("primaryValue", "0");
            this.secondaryOperator=allFields.get("secondaryOperator", TargetNode.OPERATOR_EQ.getOperatorCode());
            this.secondaryValue=allFields.get("secondaryValue", 0);
            this.closeBracketAfter=allFields.get("closeBracketAfter", false);
            this.openBracketBefore=allFields.get("openBracketBefore", false);
        } catch (Exception e) {
            logger.error("readObject: "+e.getMessage());
        }
    	this.initializeOperatorLists();
    }

    /** Getter for property openBracketBefore.
     * @return Value of property openBracketBefore.
     */
    public boolean isOpenBracketBefore() {
        return this.openBracketBefore;
    }

    /** Setter for property openBracketBefore.
     * @param openBracketBefore New value of property openBracketBefore.
     */
    public void setOpenBracketBefore(boolean openBracketBefore) {
        this.openBracketBefore=openBracketBefore;
    }

    /** Getter for property closeBracketAfter.
     * @return Value of property closeBracketAfter.
     */
    public boolean isCloseBracketAfter() {
        return this.closeBracketAfter;
    }

    /** Setter for property closeBracketAfter.
     * @param closeBracketAfter New value of property closeBracketAfter.
     */
    public void setCloseBracketAfter(boolean closeBracketAfter) {
        this.closeBracketAfter=closeBracketAfter;
    }

    /** Getter for property chainOperator.
     * @return Value of property chainOperator.
     */
    public int getChainOperator() {
        return this.chainOperator;
    }

    /** Setter for property chainOperator.
     * @param chainOperator New value of property chainOperator.
     */
    public void setChainOperator(int chainOperator) {
        this.chainOperator=chainOperator;
    }

    /** Getter for property primaryOperator.
     * @return Value of property primaryOperator.
     */
    public int getPrimaryOperator() {
        return this.primaryOperator;
    }

    /** Getter for property primaryField.
     * @return Value of property primaryField.
     */
    public String getPrimaryField() {
        return this.primaryField;
    }

    /** Setter for property primaryField.
     * @param primaryField New value of property primaryField.
     */
    public void setPrimaryField(String primaryField) {
        this.primaryField=primaryField;
    }

    /** Getter for property primaryFieldType.
     * @return Value of property primaryFieldType.
     */
    public String getPrimaryFieldType() {
        return this.primaryFieldType;
    }

    /** Setter for property primaryFieldType.
     * @param primaryFieldType New value of property primaryFieldType.
     */
    public void setPrimaryFieldType(String primaryFieldType) {
        this.primaryFieldType=primaryFieldType;
    }

    /** Getter for property primaryValue.
     * @return Value of property primaryValue.
     */
    public String getPrimaryValue() {
        return this.primaryValue;
    }
}
