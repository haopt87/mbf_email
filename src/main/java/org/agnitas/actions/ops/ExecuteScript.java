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

package org.agnitas.actions.ops;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.Serializable;
import java.io.StringWriter;
import java.util.Map;

import org.agnitas.actions.ActionOperation;
import org.agnitas.beans.BindingEntry;
import org.agnitas.beans.Mailing;
import org.agnitas.beans.Recipient;
import org.agnitas.dao.MailingDao;
import org.agnitas.emm.core.velocity.VelocityResult;
import org.agnitas.emm.core.velocity.VelocitySpringUtils;
import org.agnitas.emm.core.velocity.VelocityWrapper;
import org.agnitas.emm.core.velocity.VelocityWrapperFactory;
import org.agnitas.util.AgnUtils;
import org.agnitas.util.ScriptHelper;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;

/**
 *
 * @author  Martin Helff, Andreas Rehak
 * @version
 */
@Deprecated
public class ExecuteScript extends ActionOperation implements Serializable {

	/** The logger. */
	private static final transient Logger logger = Logger.getLogger( ExecuteScript.class);
	
	/** Serial version UID. */
	static final long serialVersionUID = -2943748993810034889L;
    
	/**
	 * Holds the script code.
	 */
	private String script="";
	
	public ExecuteScript() {
	}

	/**
	 * Initialize object from input stream.
	 * @param in The input stream to read from.
	 */
	private void readObject(java.io.ObjectInputStream in)
			throws IOException, ClassNotFoundException {
		ObjectInputStream.GetField allFields=null;

		allFields=in.readFields();
		script=(String) allFields.get("script", "");
	}

	/**
	 * Executes the script for this action with the give form values.
	 * @param con the applicartion context.
	 * @param companyID
	 * @param params parameters given to the request
	 * @return true on success
	 */
	public boolean executeOperation(ApplicationContext con, int companyID, Map params) {
		boolean result=false;
		Recipient cust=(Recipient) con.getBean("Recipient");
		cust.setCompanyID(companyID);
		params.put("Customer", cust);

		// neu von ma
		BindingEntry binding=(BindingEntry) con.getBean("BindingEntry");
		params.put("BindingEntry", binding);

		Mailing mail=(Mailing) con.getBean("Mailing");
		mail.setCompanyID(companyID);
		params.put("Mailing", mail);

		MailingDao mailingdao=(MailingDao) con.getBean("MailingDao");
		params.put("MailingDao", mailingdao);

		if(!params.containsKey("ScriptHelper")) {
			params.put("ScriptHelper", new ScriptHelper(con));
		}

		try {
			VelocityWrapperFactory factory = VelocitySpringUtils.getVelocityWrapperFactory(con);
			VelocityWrapper velocity = factory.getWrapper( companyID);
			
            StringWriter aWriter=new StringWriter();
            VelocityResult velocityResult = velocity.evaluate( params, this.script, aWriter);
            if( velocityResult.hasErrors()) 
            	params.put("errors", velocityResult.getErrors());
        } catch(Exception e) {
        	logger.error( "Velocity error", e);

            params.put("velocity_error", AgnUtils.getUserErrorMessage(e));
            AgnUtils.sendVelocityExceptionMail((String) params.get("formURL"),e);
        }

        if(params.containsKey("scriptResult")) {
            if(params.get("scriptResult").equals("1") && params.get("errors") == null) {
                result=true;
            }
        }
		return result;
	}

	/**
	 * Get the script for this action.
	 * @return The script for this action.
	 */
	public String getScript() {
		return this.script;
	}

	/**
	 * Setter for property Script.
	 * 
	 */
	public void setScript(String script) {
		this.script = script;
	}
}
