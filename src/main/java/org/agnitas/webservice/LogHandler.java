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
package org.agnitas.webservice;

import javax.servlet.http.HttpServletRequest;

import org.apache.axis.AxisFault;
import org.apache.axis.Message;
import org.apache.axis.MessageContext;
import org.apache.axis.components.logger.LogFactory;
import org.apache.axis.handlers.BasicHandler;
import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;

public class LogHandler extends BasicHandler {
	private static final transient Logger logger = Logger.getLogger(LogHandler.class);
    
    static Log log=LogFactory.getLog(LogHandler.class.getName());
    static int logID=1;
    
    public void invoke(MessageContext msgContext) throws AxisFault {
        try {
            int id=logID++;
            
            Message inMsg = msgContext.getRequestMessage();
            Message outMsg = msgContext.getResponseMessage();
            
            HttpServletRequest req=(HttpServletRequest)msgContext.getProperty("transport.http.servletRequest");
            
            log.info(req.getRemoteAddr()+" -"+id+"-i: "+inMsg.getSOAPPartAsString());
            if(outMsg!=null) {
                log.info(req.getRemoteAddr()+" -"+id+"-o: "+outMsg.getSOAPPartAsString());
            }
            
        } catch (Exception e) {
            throw AxisFault.makeFault(e);
        }
    }
}
