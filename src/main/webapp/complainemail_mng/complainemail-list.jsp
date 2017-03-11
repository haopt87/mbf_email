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
    var tableID = 'complainemailObject';
    var columnindex = 0;
    var dragging = false;

   document.onmousemove = drag;
   document.onmouseup = dragstop;
   window.onload = onPageLoad;

   function parametersChanged() {
       document.getElementsByName('mbfComplainemailForm')[0].numberOfRowsChanged.value = true;
   }
</script>
<html:form action="/complainemail_mng">
	
    <html:hidden property="numberOfRowsChanged"/>

    <div class="list_settings_container">
        <div class="filterbox_form_button"><a href="#" onclick="parametersChanged(); document.mbfComplainemailForm.submit(); return false;"><span><bean:message key="button.Show"/></span></a></div>
        <div class="list_settings_mainlabel"><bean:message key="settings.Admin.numberofrows"/>:</div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="20"/><label
                for="list_settings_length_0">20</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="50"/><label
                for="list_settings_length_1">50</label></div>
        <div class="list_settings_item"><html:radio property="numberofRows" value="100"/><label
                for="list_settings_length_2">100</label></div>
    </div>
	<display:table class="list_table" id="complainemailObject" name="complainemailList">
        <display:column class="email" headerClass="" sortable="true" property="id" titleKey="complainemail_mng.id" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="customerName" titleKey="complainemail_mng.customerName" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="customerMobile" titleKey="complainemail_mng.customer_mobile" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="emailAddress" titleKey="complainemail_mng.email_address" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="otherInformation" titleKey="complainemail_mng.other_info" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="statusName" titleKey="complainemail_mng.status" style="width: 150px;"></display:column>
		<display:column class="edit" >
        	<html:link styleClass="mailing_edit"
        		page="/complainemail_mng.do?action=${ACTION_VIEW}&id=${complainemailObject.id}"> </html:link>
			<html:link styleClass="mailing_delete"
        		page="/complainemail_mng.do?action=${ACTION_DELETE}&id=${complainemailObject.id}&previousAction=${ACTION_LIST}" onclick="return confirm('Xóa email này vĩnh viễn?')"> </html:link>
		</display:column>
 	</display:table>



    <script type="text/javascript">
        table = document.getElementById('complainemailObject');
        rewriteTableHeader(table);
        writeWidthFromHiddenFields(table);

        $$('#complainemailObject tbody tr').each(function(item) {
            item.observe('mouseover', function() {
                item.addClassName('list_highlight');
            });
            item.observe('mouseout', function() {
                item.removeClassName('list_highlight');
            });
        });
    </script>
</html:form>

