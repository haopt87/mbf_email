<%-- checked --%>
<%@ page language="java" contentType="text/html; charset=utf-8"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="blue_box_container">
       <div class="blue_box_top"></div>
       <div class="blue_box_content">
           <div class="admin_filed_detail_topic_item">
           	Thực hiện xuất báo cáo tổng quan các chiến dịch của tài khoản hiện tại đang đăng nhập               
           </div>
    
		     <div class="contentbox_left_column">
		     	Nhấn vào nút bên cạnh để tải về:
<%-- 	            <div class="action_button download_button"><a href="/Openemm/complainemail_mng.do;jsessionid=${sessionId}?action=11"><span>Tải về</span></a> --%>
	            <div class="action_button download_button"><a href="/Openemm/admin.do;jsessionid=${sessionId}?action=23"><span>Tải về</span></a>            
			 	</div>
		 	</div>       
	</div>
	<div class="blue_box_bottom"></div>
</div>    

