<%@ page language="java" import="org.agnitas.web.MbfComplainEmailAction" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="complainemail_mng.show"/>

<c:set var="sidemenu_active" value="Complainemail_mng" scope="request" />
<c:choose>
	<c:when test="${mbfComplainEmailForm.id != 0}">
		<c:set var="sidemenu_sub_active" value="complainemail_mng.NewComplainemail" scope="request" />
                <c:set var="agnNavigationKey" value="Complainemail_mngEdit" scope="request" />
                <c:set var="agnHighlightKey" value="complainemail_mng.Edit" scope="request" />
    </c:when>
   	<c:otherwise>
     <c:set var="sidemenu_sub_active" value="complainemail_mng.NewComplainemail" scope="request" />
     <c:set var="agnNavigationKey" value="complainemail_mngView" scope="request" />
     <c:set var="agnHighlightKey" value="complainemail_mng.NewComplainemail" scope="request" />
    </c:otherwise>
</c:choose>
<c:set var="agnHelpKey" value="targetGroupView" scope="request" />
<c:set var="agnTitleKey" value="complainemail_mng.Complainemail_mng" scope="request" />
<c:set var="agnSubtitleKey" value="complainemail_mng.Complainemail_mng" scope="request" />
<%-- <c:set var="agnSubtitleValue" value="${targetForm.shortname}" scope="request" /> --%>

<c:set var="ACTION_VIEW" value="<%= MbfComplainEmailAction.ACTION_VIEW %>" scope="request" />
<c:set var="ACTION_SAVE" value="<%= MbfComplainEmailAction.ACTION_SAVE %>" scope="request" />
<c:set var="ACTION_CONFIRM_DELETE" value="<%= MbfComplainEmailAction.ACTION_CONFIRM_DELETE %>" scope="request" />
