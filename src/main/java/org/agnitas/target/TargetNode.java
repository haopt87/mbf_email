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

package org.agnitas.target;

import org.agnitas.target.impl.TargetOperatorImpl;

/**
 *
 * @author  mhe
 */
public abstract class TargetNode {
    public static final int CHAIN_OPERATOR_NONE = 0;
    public static final int CHAIN_OPERATOR_AND = 1;
    public static final int CHAIN_OPERATOR_OR = 2;

    public static final TargetOperator OPERATOR_EQ = new TargetOperatorImpl( "eq", "=", "==", 1);
    public static final TargetOperator OPERATOR_NEQ = new TargetOperatorImpl( "neq", "!=", "!=", 2);
    public static final TargetOperator OPERATOR_GT = new TargetOperatorImpl( "gt", ">", ">", 3);
    public static final TargetOperator OPERATOR_LT = new TargetOperatorImpl( "lt", "<", "<", 4);
    public static final TargetOperator OPERATOR_LIKE = new TargetOperatorImpl( "like", "LIKE", null, 5);
    public static final TargetOperator OPERATOR_NLIKE = new TargetOperatorImpl( "not_like", "NOT LIKE", null, 6);
    public static final TargetOperator OPERATOR_MOD = new TargetOperatorImpl( "mod", "mod", "%", 7);
    public static final TargetOperator OPERATOR_IS = new TargetOperatorImpl( "is", "IS", "IS", 8);
    public static final TargetOperator OPERATOR_LT_EQ = new TargetOperatorImpl( "leq", "<=", "<=", 9);
    public static final TargetOperator OPERATOR_GT_EQ = new TargetOperatorImpl( "geq", ">=", ">=", 10);
    public static final TargetOperator OPERATOR_YES = new TargetOperatorImpl( "yes", "--special handling--", "--special handling--", 11);
    public static final TargetOperator OPERATOR_NO = new TargetOperatorImpl(  "no", "--special handling--", "--special handling--", 12);
  
    public static final TargetOperator[] ALL_OPERATORS = {
    	OPERATOR_EQ,
    	OPERATOR_NEQ,
    	OPERATOR_GT,
    	OPERATOR_LT,
    	OPERATOR_LIKE,
    	OPERATOR_NLIKE,
    	OPERATOR_MOD,
    	OPERATOR_IS,
    	OPERATOR_LT_EQ,
    	OPERATOR_GT_EQ,
    	OPERATOR_YES,
    	OPERATOR_NO
    };

    public TargetOperator[] typeOperators = {
    	OPERATOR_EQ,
    	OPERATOR_NEQ,
    	OPERATOR_GT,
    	OPERATOR_LT,
    	OPERATOR_LIKE,
    	OPERATOR_NLIKE,
    	null,
    	OPERATOR_IS,
    	OPERATOR_LT_EQ,
    	OPERATOR_GT_EQ,
    	null,
    	null
    };
    
    public static final TargetOperator[] OPERATORS_ALLOWED_AFTER_MOD_OPERATOR = {
    	OPERATOR_EQ,
    	OPERATOR_NEQ,
    	OPERATOR_GT,
    	OPERATOR_LT,
    	OPERATOR_LT_EQ,
    	OPERATOR_GT_EQ
    };
    
    public static TargetOperator[] getAllowedSecondaryOperatorsForPrimaryOperator(TargetOperator primaryOperator) {
    	if (primaryOperator == OPERATOR_MOD) {
    		return OPERATORS_ALLOWED_AFTER_MOD_OPERATOR;
    	} else {
    		return new TargetOperator[0];
    	}
    }
    
    /**
     * Initializes the arrays OPERATORS and BSH_OPERATORS 
     */
    protected abstract void initializeOperatorLists();
    
      /** 
       * Getter for property openBracketBefore.
       *
     * @return Value of property openBracketBefore.
     */
    public abstract boolean isOpenBracketBefore();
    
    /** 
     * Setter for property openBracketBefore.
     *
     * @param openBracketBefore New value of property openBracketBefore.
     */
    public abstract void setOpenBracketBefore(boolean openBracketBefore);
    
    /**
     * Getter for property closeBracketAfter.
     *
     * @return Value of property closeBracketAfter.
     */
    public abstract boolean isCloseBracketAfter();
    
    /**
     * Setter for property closeBracketAfter.
     *
     * @param closeBracketAfter New value of property closeBracketAfter.
     */
    public abstract void setCloseBracketAfter(boolean closeBracketAfter);
    
    /**
     * Getter for property chainOperator.
     *
     * @return Value of property chainOperator.
     */
    public abstract int getChainOperator();
    
    /**
     * Setter for property chainOperator.
     *
     * @param chainOperator New value of property chainOperator.
     */
    public abstract void setChainOperator(int chainOperator);
    
    /**
     * Generates SQL.
     * This method respects settings for chain operator and parenthesis.
     * To implement node specific SQL code, use method {@link #generateEmbeddedSQL()}.  
     * 
     * @return SQL string
     */
    public String generateSQL() {
        StringBuffer tmpSQL=new StringBuffer();

        switch(getChainOperator()) {
            case TargetNode.CHAIN_OPERATOR_AND:
                tmpSQL.append(" AND ");
                break;
            case TargetNode.CHAIN_OPERATOR_OR:
                tmpSQL.append(" OR ");
                break;
            default:
                tmpSQL.append(" ");
        }

        if(isOpenBracketBefore()) {
            tmpSQL.append("(");
        }
        
        tmpSQL.append(this.generateEmbeddedSQL());
        
        if(isCloseBracketAfter()) {
            tmpSQL.append(")");
        }
        
        return tmpSQL.toString();
    }
    
    /**
     * Generates SQL.
     * This method creates the SQL string without respect of chain operator and parenthesis.
     * Use this method to implement node specific SQL code.
     * 
     * @return
     */
    public String generateEmbeddedSQL() {
    	
    	/*
    	 * For compatibility with already some nodes, this method is implemented to return an empty string.
    	 * Some nodes directly overrides method generateSQL(). 
    	 */
    	return "";
    }
    
    /**
     * Generates bsh
     */
    public abstract String generateBsh();
    
    /** 
     * Getter for property primaryOperator.
     *
     * @return Value of property primaryOperator.
     */
    public abstract int getPrimaryOperator();
    
    /**
     * Setter for property primaryOperator.
     *
     * @param primaryOperator New value of property primaryOperator.
     */
    public abstract void setPrimaryOperator(int primaryOperator);
    
    /**
     * Getter for property primaryField.
     *
     * @return Value of property primaryField.
     */
    public abstract String getPrimaryField();
    
    /**
     * Setter for property primaryField.
     *
     * @param primaryField New value of property primaryField.
     */
    public abstract void setPrimaryField(String primaryField);
    
    /**
     * Getter for property primaryFieldType.
     *
     * @return Value of property primaryFieldType.
     */
    public abstract String getPrimaryFieldType();
    
    /**
     * Setter for property primaryFieldType.
     *
     * @param primaryFieldType New value of property primaryFieldType.
     */
    public abstract void setPrimaryFieldType(String primaryFieldType);
    
    /**
     * Getter for property primaryValue.
     *
     * @return Value of property primaryValue.
     */
    public abstract String getPrimaryValue();
    
    /**
     * Setter for property primaryValue.
     *
     * @param primaryValue New value of property primaryValue.
     */
    public abstract void setPrimaryValue(String primaryValue);   
}
