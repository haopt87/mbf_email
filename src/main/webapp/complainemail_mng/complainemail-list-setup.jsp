<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.MbfComplainEmailAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="complainemail_mng.show"/>
<% request.setAttribute("sidemenu_active", new String("Complainemail_mng")); %>
<% request.setAttribute("sidemenu_sub_active", new String("default.Overview")); %>
<% request.setAttribute("agnTitleKey", new String("Complainemail_mng")); %>
<% request.setAttribute("agnSubtitleKey", new String("target.Targets")); %>
<% request.setAttribute("agnNavigationKey", new String("complainemail_mng")); %>
<% request.setAttribute("agnHighlightKey", new String("default.Overview")); %>
<% request.setAttribute("ACTION_LIST", MbfComplainEmailAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", MbfComplainEmailAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", MbfComplainEmailAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", MbfComplainEmailAction.ACTION_DELETE); %>
<c:set var="agnHelpKey" value="complainemail_mngGroupView" scope="request" />
