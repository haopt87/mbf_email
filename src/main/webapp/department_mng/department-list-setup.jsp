<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.DepartmentlistAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="department_mng.show"/>
<% request.setAttribute("sidemenu_active", new String("Department_mng")); %>
<% request.setAttribute("sidemenu_sub_active", new String("default.Overview")); %>
<% request.setAttribute("agnTitleKey", new String("Department_mng")); %>
<% request.setAttribute("agnSubtitleKey", new String("target.Targets")); %>
<% request.setAttribute("agnNavigationKey", new String("department_mng")); %>
<% request.setAttribute("agnHighlightKey", new String("default.Overview")); %>
<% request.setAttribute("ACTION_LIST", DepartmentlistAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", DepartmentlistAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", DepartmentlistAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", DepartmentlistAction.ACTION_DELETE); %>
<c:set var="agnHelpKey" value="department_mngGroupView" scope="request" />
