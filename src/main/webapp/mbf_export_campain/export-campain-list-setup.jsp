<%@ page import="org.agnitas.web.ExportreportAction"  errorPage="/error.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="exportreport.show"/>
<% request.setAttribute("sidemenu_active", new String("Exportreport")); %>
<% request.setAttribute("sidemenu_sub_active", new String("default.Overview")); %>
<% request.setAttribute("agnTitleKey", new String("Exportreport")); %>
<% request.setAttribute("agnSubtitleKey", new String("target.Targets")); %>
<% request.setAttribute("agnNavigationKey", new String("exportreport")); %>
<% request.setAttribute("agnHighlightKey", new String("default.Overview")); %>
<% request.setAttribute("ACTION_LIST", ExportreportAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", ExportreportAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", ExportreportAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", ExportreportAction.ACTION_DELETE); %>
<c:set var="agnHelpKey" value="exportreportGroupView" scope="request" />

