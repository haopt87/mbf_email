<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.MbfCompanyAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="company_mng.show"/>
<% request.setAttribute("sidemenu_active", new String("Company_mng")); %>
<% request.setAttribute("sidemenu_sub_active", new String("default.Overview")); %>
<% request.setAttribute("agnTitleKey", new String("Company_mng")); %>
<% request.setAttribute("agnSubtitleKey", new String("target.Targets")); %>
<% request.setAttribute("agnNavigationKey", new String("company_mng")); %>
<% request.setAttribute("agnHighlightKey", new String("default.Overview")); %>
<% request.setAttribute("ACTION_LIST", MbfCompanyAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", MbfCompanyAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", MbfCompanyAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", MbfCompanyAction.ACTION_DELETE); %>
<c:set var="agnHelpKey" value="company_mngGroupView" scope="request" />
