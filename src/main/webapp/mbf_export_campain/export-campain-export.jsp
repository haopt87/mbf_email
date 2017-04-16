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

<html:form action="/exportreport" focus="sendEmail">
	<html:hidden property="id"/>
    <html:hidden property="action"/>
    <html:hidden property="previousAction" value="${ACTION_VIEW}"/>
    <div class="blue_box_container">
        <div class="blue_box_top"></div>
        <div class="blue_box_content">
            <div class="admin_filed_detail_topic_item">
            	Thực hiện xuất báo cáo chi tiết từng chiến dịch của tài khoản chọn dưới đây               
            </div>
     
		     <div class="contentbox_left_column">
		     	<label for="mailing_name">Chọn tài khoản:</label>
			    <html:select styleId="userId" property="userId" size="1">
					<c:forEach var="item" items="${userList}">
				    <html:option value="${item.id}">
				    ${item.fullname}
				    </html:option>
				    </c:forEach>
				</html:select>
			 </div>
		 </div>
        <div class="blue_box_bottom"></div>
	</div>  
     <script type="text/javascript">
 			function submitAction(actionId) { 
 				document.getElementsByName("action")[0].value = actionId; 
				document.exportreportForm.submit(); 
			} 
	</script> 
	
     <div class="button_container">
        <input type="hidden" id="save" name="save" value=""/>
        	<div class="action_button">
            	<a href="#"
               		onclick="submitAction(${13}); return false;"><span>Tải về</span></a>
        	</div>
	</div>    
</html:form>

