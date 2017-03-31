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
		document.exportreportForm.submit();
	}
</script>

<c:set var="ACTION_VIEW" value="2" />

<html:form action="/exportreport" focus="sendEmail">
	<html:hidden property="id"/>
    <html:hidden property="action"/>
    <html:hidden property="previousAction" value="${ACTION_VIEW}"/>


    <div class="contentbox_left_column">
         <div class="recipient_detail_form_item">
             <label for="empfaenger_detail_title1">Email gửi:</label> 
             <html:text styleId="empfaenger_detail_title1" styleClass="empfaenger_detail_input_text" property="sendEmail"/> <br/>
         </div>
         <br/>
         <div class="recipient_detail_form_item">
             <label for="empfaenger_detail_title2">Email nhận reply:</label> 
             <html:text styleId="empfaenger_detail_title2" styleClass="empfaenger_detail_input_text" property="replyEmail"/> <br/>
         </div>
         <br/>
         <div class="recipient_detail_form_item">
             <label for="empfaenger_detail_title3">Thiết lập sao lưu tự đông hoặc thủ công:</label> 
             <html:text styleId="empfaenger_detail_title3" styleClass="empfaenger_detail_input_text" property="backupType"/> <br/>
         </div>
         <br/>
         <div class="recipient_detail_form_item">
             <label for="empfaenger_detail_title4">Thiết lập lịch sao lưu dữ liệu:</label> 
             <html:text styleId="empfaenger_detail_title4" styleClass="empfaenger_detail_input_text" property="backupTime"/> <br/>
         </div>
         
         <div class="grey_box_right_column"></div>
     </div>
     <script type="text/javascript">
		function submitAction(actionId) {
			document.getElementsByName("action")[0].value = actionId;
			document.exportreportForm.submit();
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

<%--         <c:if test="${not empty targetForm.targetID and targetForm.targetID != 0}"> --%>
<!--             <input type="hidden" id="delete" name="delete" value=""/> -->
<%-- 			<agn:ShowByPermission token="targets.delete"> --%>
<!--             	<div class="action_button"> -->
<!--                 	<a href="#" -->
<%--                    		onclick="submitAction(${ACTION_CONFIRM_DELETE}); return false;"><span><bean:message --%>
<%--                         key="button.Delete"/></span></a> --%>
<!-- 	            </div> -->
<%-- 			</agn:ShowByPermission> --%>
<!--             <input type="hidden" id="copy" name="copy" value=""/> -->
<%-- 			<agn:ShowByPermission token="targets.change"> --%>
<!--             	<div class="action_button"> -->
<!--                 	<a href="#" -->
<%--                    		onclick="submitAction(${ACTION_CLONE}); return false;"><span><bean:message --%>
<%--                         key="button.Copy"/></span></a> --%>
<!-- 	            </div> -->
<%-- 	        </agn:ShowByPermission> --%>
<%--         </c:if> --%>

<%--         <div class="action_button"><bean:message key="target.Target"/>:</div> --%>
    </div>

<%--     <c:if test="${not empty targetForm.targetID and targetForm.targetID != 0}"> --%>
<!--         <div class="button_container"> -->
<%--             <div align=right><html:link styleClass="target_view_link" --%>
<%--                                         page="/recipient_stats.do?action=2&mailinglistID=0&targetID=${targetForm.targetID}"><bean:message --%>
<%--                     key="Statistics"/>...</html:link></div> --%>
<%--             <agn:ShowByPermission token="targets.createml"> --%>
<!--                 <br> -->

<%--                 <div align=right><html:link styleClass="target_view_link" --%>
<%--                                             page="/target.do?action=${ACTION_CREATE_ML}&targetID=${targetForm.targetID}"><bean:message --%>
<%--                         key="target.createMList"/></html:link></div> --%>
<%--             </agn:ShowByPermission> --%>

<%--             <agn:ShowByPermission token="recipient.delete"> --%>
<!--                 <br> -->

<%--                 <div align=right><html:link styleClass="target_view_link" --%>
<%--                                             page="/target.do?action=${ACTION_DELETE_RECIPIENTS_CONFIRM}&targetID=${targetForm.targetID}"><bean:message --%>
<%--                         key="target.delete.recipients"/></html:link></div> --%>
<%--             </agn:ShowByPermission> --%>
<!--         </div> -->
<%--     </c:if> --%>
</html:form>
