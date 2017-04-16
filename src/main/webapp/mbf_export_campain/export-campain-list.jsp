<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.beans.Mailloop, org.agnitas.util.AgnUtils"  errorPage="/error.jsp" %>
<%@ page import="org.agnitas.web.ExportreportAction" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>


<script src="<%=request.getContextPath()%>/js/lib/tablecolumnresize.js" type="text/javascript"></script>

<script type="text/javascript">
    var prevX = -1;
    var tableID = 'exportcampainbyuser';
    var columnindex = 0;
    var dragging = false;
    document.onmousemove = drag;
    document.onmouseup = dragstop;
    window.onload = onPageLoad;

    function parametersChanged() {
        document.getElementsByName('exportreportForm')[0].numberOfRowsChanged.value = true;
    }
</script>

<!-- MbfExportCampainByUserForm -->
 <html:form action="/exportreport">
 <html:hidden property="numberOfRowsChanged"/>
 <html:hidden property="action"/>


	<display:table class="list_table" id="exportreportTable" name="settingSystemLists">
		<display:column class="email" headerClass="" sortable="true" property="id" title="STT" style="width: 100px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="sendEmail" title="Email gửi" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="replyEmail" title="Email nhận reply" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="backupType" title="Kiểu backup" style="width: 150px;"></display:column>
        <display:column class="email" headerClass="" sortable="true" property="backupTime" title="Thời gian backup" style="width: 150px;"></display:column>
                
		<display:column class="edit" >
		
        	<html:link styleClass="mailing_edit"
         		page="/exportreport.do?action=${ACTION_VIEW}&id=${exportreportTable.id}"> </html:link>
         		 
		</display:column>
    </display:table>

    <script type="text/javascript">
        table = document.getElementById('exportreportTable');
        rewriteTableHeader(table);
        writeWidthFromHiddenFields(table);
        $$('#exportreportTable tbody tr').each(function(item) {
            item.observe('mouseover', function() {
                item.addClassName('list_highlight');
            });
            item.observe('mouseout', function() {
                item.removeClassName('list_highlight');
            });
        });
    </script>

</html:form>
