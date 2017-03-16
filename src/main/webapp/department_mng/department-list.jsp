<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<script src="<%=request.getContextPath()%>/js/lib/tablecolumnresize.js" type="text/javascript"></script>
<script type="text/javascript">
	var prevX = -1;
    var tableID = 'department_mngObject';
    var columnindex = 0;
    var dragging = false;

   document.onmousemove = drag;
   document.onmouseup = dragstop;
   window.onload = onPageLoad;

   function parametersChanged() {
       document.getElementsByName('departmentlistForm')[0].numberOfRowsChanged.value = true;
   }
</script>
<html:form action="/department_mng">
	
    <html:hidden property="numberOfRowsChanged"/>

    <div class="list_settings_container">
        <div class="filterbox_form_button"><a href="#" onclick="parametersChanged(); document.departmentlistForm.submit(); return false;"><span><bean:message key="button.Show"/></span></a></div>
        <div class="list_settings_mainlabel"><bean:message key="settings.Admin.numberofrows"/>:</div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="20"/><label
                for="list_settings_length_0">20</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="50"/><label
                for="list_settings_length_1">50</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="100"/><label
                for="list_settings_length_2">100</label></div>
        <logic:iterate collection="${departmentlistForm.columnwidthsList}" indexId="i" id="width">
            <html:hidden property="columnwidthsList[${i}]"/>
        </logic:iterate>
    </div>
	<display:table class="list_table" id="department_mngObject" name="department_mngObjectList">
            <display:column class="email" headerClass="" sortable="true" property="id" titleKey="department_mng.id" style="width: 150px;"></display:column>
            <display:column class="email" headerClass="" sortable="true" property="departmentName" titleKey="department_mng.departmentName" style="width: 150px;"></display:column>
            <display:column class="email" headerClass="" sortable="true" property="description" titleKey="department_mng.description" style="width: 150px;"></display:column>
            <display:column class="email" headerClass="" sortable="true" property="company.companyName" titleKey="department_mng.company.companyName" style="width: 150px;"></display:column>
            <display:column class="email" headerClass="" sortable="true" property="disabledTag" title="Trạng thái" style="width: 150px;"></display:column>
<%--             <display:column headerClass="admin_head_name header" class="description" title="Trạng thái" sortable="false"></display:column> --%>
			<display:column class="edit" >
                	<html:link styleClass="mailing_edit" 
                       page="/department_mng.do?action=${ACTION_VIEW}&&id=${department_mngObject.id}"> </html:link>
                    <html:link styleClass="mailing_delete" 
                    	page="/department_mng.do?action=${ACTION_DELETE}&&id=${department_mngObject.id}&previousAction=${ACTION_LIST}" 
                    	onclick="return confirm('Xóa phòng vĩnh viễn?')"> </html:link>
                    
                    <html:link styleClass="status_error" titleKey="settings.admin.disable"
                           page="/department_mng.do?action=${18}&id=${department_mngObject.id}" onclick="return confirm('Bạn muốn khóa phòng này? Tài khoản trong phòng sẽ bị khóa, các tài khoản sẽ không thể đăng nhập vào hệ thống?')"> </html:link>
                           
                	<html:link styleClass="status_ok" titleKey="settings.admin.ennable"
                           page="/department_mng.do?action=${19}&id=${department_mngObject.id}" onclick="return confirm('Bạn muốn kích hoạt lại phòng này?')"> </html:link>
                           
				</display:column>
 	</display:table>



    <script type="text/javascript">
        table = document.getElementById('department_mngObject');
        rewriteTableHeader(table);
        writeWidthFromHiddenFields(table);

        $$('#department_mngObject tbody tr').each(function(item) {
            item.observe('mouseover', function() {
                item.addClassName('list_highlight');
            });
            item.observe('mouseout', function() {
                item.removeClassName('list_highlight');
            });
        });
    </script>
</html:form>

