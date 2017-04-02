<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.ExportreportAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="stats.mailing"/>

<% request.setAttribute("sidemenu_active", new String("Statistics")); %>
<% request.setAttribute("sidemenu_sub_active", new String("exportreport.Dataexport")); %>
<% request.setAttribute("agnTitleKey", new String("Statistics")); %>
<% request.setAttribute("agnSubtitleKey", new String("Statistics")); %>
<% request.setAttribute("agnNavigationKey", new String("statsMailing")); %>
<% request.setAttribute("agnHighlightKey", new String("statistic.MailStat")); %>

<% request.setAttribute("ACTION_LIST", ExportreportAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", ExportreportAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", ExportreportAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", ExportreportAction.ACTION_DELETE); %>
