<%-- checked --%>
<%-- <%@ page language="java" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %> --%>

<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8" 
         import="org.agnitas.beans.Admin" 
         buffer="32kb"  errorPage="/error.jsp" %> 
         

<%@ page import="org.agnitas.util.AgnUtils" %>

<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="<%=request.getContextPath()%>/js/lib/tablecolumnresize.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/lib/option_title.js"></script>

<agn:ShowColumnInfo id="colsel"/>

<script type="text/javascript">
	function submitAction(actionId) {
		
		document.getElementsByName("action")[0].value = actionId;
		document.mbfSettingSystemForm.submit();
	}
	
	var prevX = -1;
    var tableID = 'logs';
    var columnindex = 0;
    var dragging = false;
    var minWidthLast = 200;

    document.onmousemove = drag;
    document.onmouseup = dragstop;

    Event.observe(window, 'load', function() {
        createPickers();
        onPageLoad();
    });

    function createPickers() {
        $(document.body).select('input.datepicker').each(
            function(e) {
                new Control.DatePicker(e, { 'icon': 'images/datepicker/calendar.png' ,
                    timePicker: false,
                    timePickerAdjacent: false,
                    dateFormat: '${localDatePattern}',
                    locale:'<bean:write name="emm.locale" property="language" scope="session"/>'

                });
            }
        );
    }

    function parametersChanged() {
        document.getElementsByName('userActivityLogForm')[0].numberOfRowsChanged.value = true;
    }
    
</script>

<c:set var="ACTION_VIEW" value="2" />

<html:form action="/setting_system_view" focus="sendEmail">
	<html:hidden property="id"/>
    <html:hidden property="action"/>
    <html:hidden property="previousAction" value="${ACTION_VIEW}"/>
    
	<label id="displayError" style="color: red;"></label>

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
	    	<label for="mailing_name">Kiểu back-up dữ liệu:</label>
	        <html:select styleId="backupType" property="backupType" size="1">
		    	<c:forEach var="item" items="${backupTypeList}">
		        <html:option value="${item.id}">
		        	${item.name}
		        </html:option>
		        </c:forEach>
			</html:select>
	    </div>
	             
         <br/>
         <div class="recipient_detail_form_item">
             <label for="empfaenger_detail_title4">Thiết lập giá cho một email :</label> 
             <html:text styleId="empfaenger_detail_title4" styleClass="empfaenger_detail_input_text" property="priceAnEmail"/> <br/>
         </div>
         
         <div class="recipient_detail_form_item">
	    	<label for="mailing_name">Cấu hình lưu vết hoạt động người dùng:</label>
	        <html:select styleId="logUserType" property="logUserType" size="1">
		    	<c:forEach var="item" items="${logUserTypeList}">
		        <html:option value="${item.id}">
		        	${item.name}
		        </html:option>
		        </c:forEach>
			</html:select>
	    </div>  
         
         <div class="grey_box_right_column"></div>
     </div>
     <script type="text/javascript">
		function submitAction(actionId) {
			document.getElementsByName("action")[0].value = actionId;
			document.mbfSettingSystemForm.submit();
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
