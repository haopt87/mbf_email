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
    </div>
</html:form>
