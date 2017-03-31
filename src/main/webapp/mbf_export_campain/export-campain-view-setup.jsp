<%@ page language="java" import="org.agnitas.web.ExportreportAction" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="exportreport.show"/>

<c:set var="sidemenu_active" value="NewExportreport" scope="request" />
<c:choose>
	<c:when test="${mbfComplainEmailForm.id != 0}">
		<c:set var="sidemenu_sub_active" value="exportreport.NewExportreport" scope="request" />
        <c:set var="agnNavigationKey" value="ExportreportEdit" scope="request" />
        <c:set var="agnHighlightKey" value="exportreport.Edit" scope="request" />
    </c:when>
   	<c:otherwise>
     <c:set var="sidemenu_sub_active" value="exportreport.NewExportreport" scope="request" />
     <c:set var="agnNavigationKey" value="exportreportView" scope="request" />
     <c:set var="agnHighlightKey" value="exportreport.NewExportreport" scope="request" />
    </c:otherwise>
</c:choose>
<c:set var="agnHelpKey" value="targetGroupView" scope="request" />
<c:set var="agnTitleKey" value="exportreport.Exportreport" scope="request" />
<c:set var="agnSubtitleKey" value="exportreport.Exportreport" scope="request" />

<c:set var="ACTION_VIEW" value="<%= ExportreportAction.ACTION_VIEW %>" scope="request" />
<c:set var="ACTION_SAVE" value="<%= ExportreportAction.ACTION_SAVE %>" scope="request" />
<c:set var="ACTION_CONFIRM_DELETE" value="<%= ExportreportAction.ACTION_CONFIRM_DELETE %>" scope="request" />
