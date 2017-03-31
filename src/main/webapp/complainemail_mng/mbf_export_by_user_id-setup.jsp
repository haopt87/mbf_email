<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.MbfComplainEmailAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="profileField.show"/>

<% request.setAttribute("sidemenu_active", new String("Administration")); %>
<% request.setAttribute("sidemenu_sub_active", new String("settings.ExportReport1")); %>
<% request.setAttribute("agnTitleKey", new String("settings.ExportReport1")); %>
<% request.setAttribute("agnSubtitleKey", new String("settings.ExportReport1")); %>
<% request.setAttribute("agnNavigationKey", new String("admins")); %>
<% request.setAttribute("agnHighlightKey", new String("settings.ExportReport1")); %>




<% request.setAttribute("ACTION_LIST", MbfComplainEmailAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", MbfComplainEmailAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", MbfComplainEmailAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", MbfComplainEmailAction.ACTION_DELETE); %>

<c:set var="agnHelpKey" value="complainemail_mngGroupView" scope="request" />
