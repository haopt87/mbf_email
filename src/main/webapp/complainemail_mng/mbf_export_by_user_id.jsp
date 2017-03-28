<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:ShowColumnInfo id="colsel"/>

<script type="text/javascript">
	function submitAction(actionId) {
		document.getElementsByName("action")[0].value = actionId;
		document.mbfComplainEmailForm.submit();
	}
</script>

<c:set var="ACTION_VIEW" value="2" />

<div class="export_stats_content"> 
        <div class="target_view_link_container">
        	Nhấn vào nút bên cạnh để tải về
<%--             <div class="action_button download_button"><a href="/Openemm/update.do;jsessionid=${sessionId}?action=23"><span>Tải về</span></a> --%>
            <div class="action_button download_button"><a href="/Openemm/admin.do;jsessionid=${sessionId}?action=23"><span>Tải về</span></a>
            </div>
        </div>
        <br>        
</div> 

