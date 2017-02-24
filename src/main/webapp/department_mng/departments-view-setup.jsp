<%@ page language="java" import="org.agnitas.web.DepartmentlistAction" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="department_mng.show"/>

<c:set var="sidemenu_active" value="Department_mng" scope="request" />
<c:choose>
	<c:when test="${departmentlistForm.id != 0}">
		<c:set var="sidemenu_sub_active" value="department_mng.NewDepartment" scope="request" />
                <c:set var="agnNavigationKey" value="Department_mngEdit" scope="request" />
                <c:set var="agnHighlightKey" value="department_mng.Edit" scope="request" />
    </c:when>
   	<c:otherwise>
     <c:set var="sidemenu_sub_active" value="department_mng.NewDepartment" scope="request" />
     <c:set var="agnNavigationKey" value="department_mngView" scope="request" />
     <c:set var="agnHighlightKey" value="department_mng.NewDepartment" scope="request" />
    </c:otherwise>
</c:choose>
<c:set var="agnHelpKey" value="targetGroupView" scope="request" />
<c:set var="agnTitleKey" value="department_mng.Department_mng" scope="request" />
<c:set var="agnSubtitleKey" value="department_mng.Department_mng" scope="request" />
<c:set var="agnSubtitleValue" value="${targetForm.shortname}" scope="request" />
<%-- <c:set var="agnNavHrefAppend" value="&targetID=${targetForm.targetID}" scope="request" /> --%>

<c:set var="ACTION_VIEW" value="<%= DepartmentlistAction.ACTION_VIEW %>" scope="request" />
<c:set var="ACTION_SAVE" value="<%= DepartmentlistAction.ACTION_SAVE %>" scope="request" />
<c:set var="ACTION_CONFIRM_DELETE" value="<%= DepartmentlistAction.ACTION_CONFIRM_DELETE %>" scope="request" />


<%-- <c:set var="ACTION_DELETE_RECIPIENTS_CONFIRM" value="<%= DepartmentlistAction.ACTION_DELETE_RECIPIENTS_CONFIRM %>" scope="request" /> --%>
<%-- <c:set var="ACTION_CLONE" value="<%= DepartmentlistAction.ACTION_CLONE %>" scope="request" /> --%>
