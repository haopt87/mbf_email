<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:ShowColumnInfo id="colsel"/>

<script type="text/javascript">
	function submitAction(actionId) {
		document.getElementsByName("action")[0].value = actionId;
		document.mbfComplainEmailForm.submit();
	}
</script>

<c:set var="ACTION_VIEW" value="2" />

<html:form action="/complainemail_mng" focus="shortname">
	<html:hidden property="id"/>
    <html:hidden property="action"/>
    <html:hidden property="previousAction" value="${ACTION_VIEW}"/>
    
	<div class="contentbox_left_column">
		<div class="recipient_detail_form_item">
	        <label for="empfaenger_detail_title"><bean:message key="complainemail_mng.customerName"/>:</label>
	        <html:text styleId="empfaenger_detail_title" styleClass="empfaenger_detail_input_text" property="customerName"/>
	    </div>
	    <div class="recipient_detail_form_item">
	        <label for="empfaenger_detail_firstname"><bean:message key="complainemail_mng.customer_mobile"/>:</label>
	        <html:text styleId="empfaenger_detail_firstname" styleClass="empfaenger_detail_input_text" property="customerMobile"/>
    	</div>
    	<div class="recipient_detail_form_item">
	        <label for="empfaenger_detail_firstname"><bean:message key="complainemail_mng.email_address"/>:</label>
	        <html:text styleId="empfaenger_detail_firstname" styleClass="empfaenger_detail_input_text" property="emailAddress"/>
    	</div>
    	<div class="recipient_detail_form_item">
	        <label for="empfaenger_detail_firstname"><bean:message key="complainemail_mng.other_info"/>:</label>
	        <html:textarea styleId="empfaenger_detail_firstname" property="otherInformation" cols="40" rows="8"/>
    	</div>
	    <div class="grey_box_left_column">
	    	<label for="mailing_name">Trạng thái xử lý:</label>
	        <html:select styleId="status" property="status" size="1">
		    	<c:forEach var="item" items="${statusList}">
		        <html:option value="${item.id}">
		        	${item.name}
		        </html:option>
		        </c:forEach>
			</html:select>
	    </div>	            
	
	</div>
	
        
        <script type="text/javascript">
 			function submitAction(actionId) { 
 				document.getElementsByName("action")[0].value = actionId; 
				document.mbfComplainEmailForm.submit(); 
			} 
	</script> 
	
    <div class="button_container">
        <input type="hidden" id="save" name="save" value=""/>
		<agn:ShowByPermission token="targets.change">
        	<div class="action_button">
            	<a href="#"
               		onclick="submitAction(${ACTION_SAVE}); return false;"><span><bean:message
                    key="button.Save"/></span></a>
        	</div>
        </agn:ShowByPermission>
        <c:if test="${not empty targetForm.targetID and targetForm.targetID != 0}">
            <input type="hidden" id="delete" name="delete" value=""/>
			<agn:ShowByPermission token="targets.delete">
            	<div class="action_button">
                	<a href="#"
                   		onclick="submitAction(${ACTION_CONFIRM_DELETE}); return false;"><span><bean:message
                        key="button.Delete"/></span></a>
	            </div>
			</agn:ShowByPermission>
            <input type="hidden" id="copy" name="copy" value=""/>
			<agn:ShowByPermission token="targets.change">
            	<div class="action_button">
                	<a href="#"
                   		onclick="submitAction(${ACTION_CLONE}); return false;"><span><bean:message
                        key="button.Copy"/></span></a>
	            </div>
	        </agn:ShowByPermission>
        </c:if>

        <div class="action_button"><bean:message key="target.Target"/>:</div>
    </div>

    <c:if test="${not empty targetForm.targetID and targetForm.targetID != 0}">
        <div class="button_container">
            <div align=right><html:link styleClass="target_view_link"
                                        page="/recipient_stats.do?action=2&mailinglistID=0&targetID=${targetForm.targetID}"><bean:message
                    key="Statistics"/>...</html:link></div>
            <agn:ShowByPermission token="targets.createml">
                <br>

                <div align=right><html:link styleClass="target_view_link"
                                            page="/target.do?action=${ACTION_CREATE_ML}&targetID=${targetForm.targetID}"><bean:message
                        key="target.createMList"/></html:link></div>
            </agn:ShowByPermission>

            <agn:ShowByPermission token="recipient.delete">
                <br>

                <div align=right><html:link styleClass="target_view_link"
                                            page="/target.do?action=${ACTION_DELETE_RECIPIENTS_CONFIRM}&targetID=${targetForm.targetID}"><bean:message
                        key="target.delete.recipients"/></html:link></div>
            </agn:ShowByPermission>
        </div>
    </c:if>
</html:form>
