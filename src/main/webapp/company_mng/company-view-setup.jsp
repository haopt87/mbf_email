<%@ page language="java" import="org.agnitas.web.MbfCompanyAction" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="company_mng.show"/>

<c:set var="sidemenu_active" value="Company_mng" scope="request" />
<c:choose>
	<c:when test="${mbfCompanyForm.id != 0}">
		<c:set var="sidemenu_sub_active" value="company_mng.NewCompany" scope="request" />
                <c:set var="agnNavigationKey" value="Company_mngEdit" scope="request" />
                <c:set var="agnHighlightKey" value="company_mng.Edit" scope="request" />
    </c:when>
   	<c:otherwise>
     <c:set var="sidemenu_sub_active" value="company_mng.NewCompany" scope="request" />
     <c:set var="agnNavigationKey" value="company_mngView" scope="request" />
     <c:set var="agnHighlightKey" value="company_mng.NewCompany" scope="request" />
    </c:otherwise>
</c:choose>
<c:set var="agnHelpKey" value="targetGroupView" scope="request" />
<c:set var="agnTitleKey" value="company_mng.Company_mng" scope="request" />
<c:set var="agnSubtitleKey" value="company_mng.Company_mng" scope="request" />
<c:set var="agnSubtitleValue" value="${targetForm.shortname}" scope="request" />
<%-- <c:set var="agnNavHrefAppend" value="&targetID=${targetForm.targetID}" scope="request" /> --%>

<c:set var="ACTION_VIEW" value="<%= MbfCompanyAction.ACTION_VIEW %>" scope="request" />
<c:set var="ACTION_SAVE" value="<%= MbfCompanyAction.ACTION_SAVE %>" scope="request" />
<c:set var="ACTION_CONFIRM_DELETE" value="<%= MbfCompanyAction.ACTION_CONFIRM_DELETE %>" scope="request" />
