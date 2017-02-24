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
    var tableID = 'company_mngCompany';
    var columnindex = 0;
    var dragging = false;

   document.onmousemove = drag;
   document.onmouseup = dragstop;
   window.onload = onPageLoad;

   function parametersChanged() {
       document.getElementsByName('mbfCompanyForm')[0].numberOfRowsChanged.value = true;
   }
</script>
<html:form action="/company_mng">
	
    <html:hidden property="numberOfRowsChanged"/>

    <div class="list_settings_container">
        <div class="filterbox_form_button"><a href="#" onclick="parametersChanged(); document.mbfCompanyForm.submit(); return false;"><span><bean:message key="button.Show"/></span></a></div>
        <div class="list_settings_mainlabel"><bean:message key="settings.Admin.numberofrows"/>:</div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="20"/><label
                for="list_settings_length_0">20</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="50"/><label
                for="list_settings_length_1">50</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="100"/><label
                for="list_settings_length_2">100</label></div>
        <logic:iterate collection="${mbfCompanyForm.columnwidthsList}" indexId="i" id="width">
            <html:hidden property="columnwidthsList[${i}]"/>
        </logic:iterate>
    </div>
	<display:table class="list_table" id="company_mngCompany" name="company_mngCompanyList">
        <display:column class="email" headerClass="" sortable="true" property="id" titleKey="company_mng.id" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="companyName" titleKey="company_mng.companyName" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="description" titleKey="company_mng.description" style="width: 150px;"></display:column>
<%--         <display:column class="email" headerClass="" property="deleted" sortable="true" style="width: 220px;"></display:column> --%>
		<display:column class="edit" >
        	<html:link styleClass="mailing_edit"
        		page="/company_mng.do?action=${ACTION_VIEW}&&id=${company_mngCompany.id}"> </html:link>
			<html:link styleClass="mailing_delete"
        		page="/company_mng.do?action=${ACTION_DELETE}&&id=${company_mngCompany.id}&previousAction=${ACTION_LIST}" onclick="return confirm('Xóa company vĩnh viễn?')"> </html:link>
		</display:column>
 	</display:table>



    <script type="text/javascript">
        table = document.getElementById('company_mngCompany');
        rewriteTableHeader(table);
        writeWidthFromHiddenFields(table);

        $$('#company_mngCompany tbody tr').each(function(item) {
            item.observe('mouseover', function() {
                item.addClassName('list_highlight');
            });
            item.observe('mouseout', function() {
                item.removeClassName('list_highlight');
            });
        });
    </script>
</html:form>

