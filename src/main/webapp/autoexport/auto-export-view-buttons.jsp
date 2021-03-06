<%@ page errorPage="/error.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8" buffer="32kb" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="action_button">
    <a href="#" onclick="document.autoExportForm.submit(); return false;">
        <span><bean:message key="button.Save"/></span>
    </a>
</div>
<c:if test="${autoExportForm.autoExportId != 0}">
    <div class="action_button">
        <a href='<html:rewrite page="/autoexport.do?method=delete&autoExportId=${autoExportForm.autoExportId}"/>'>
            <span><bean:message key="button.Delete"/></span>
        </a>
    </div>

    <%--@todo: this button should be removed--%>
    <div class="action_button">
        <a href='<html:rewrite page="/autoexport.do?method=doExport&autoExportId=${autoExportForm.autoExportId}"/>'>
            <span><bean:message key="dashboard.recipient.export"/></span>
        </a>
    </div>

    <c:if test="${not autoExportForm.autoExport.active}">
        <div class="action_button">
            <a href='<html:rewrite page="/autoexport.do?method=changeActiveStatus&activeStatus=true&autoExportId=${autoExportForm.autoExportId}"/>'>
                <span><bean:message key="btnactivate"/></span>
            </a>
        </div>
    </c:if>

    <c:if test="${autoExportForm.autoExport.active}">
        <div class="action_button">
            <a href='<html:rewrite page="/autoexport.do?method=changeActiveStatus&activeStatus=false&autoExportId=${autoExportForm.autoExportId}"/>'>
                <span><bean:message key="btndeactivate"/></span>
            </a>
        </div>
    </c:if>
</c:if>