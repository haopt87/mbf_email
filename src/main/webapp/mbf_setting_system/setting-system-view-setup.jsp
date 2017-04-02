<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.MbfSettingSystemAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="admin.show"/>

<% request.setAttribute("sidemenu_active", new String("Administration")); %>
<% request.setAttribute("sidemenu_sub_active", new String("settings.setting_system_view")); %>
<% request.setAttribute("agnTitleKey", new String("settings.setting_system_view")); %>
<% request.setAttribute("agnSubtitleKey", new String("Administration")); %>
<% request.setAttribute("agnNavigationKey", new String("statsMailing")); %>
<% request.setAttribute("agnHighlightKey", new String("settings.setting_system_view")); %>

<% request.setAttribute("ACTION_LIST", MbfSettingSystemAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", MbfSettingSystemAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_SAVE", MbfSettingSystemAction.ACTION_SAVE ); %>

<% request.setAttribute("ACTION_CONFIRM_DELETE", MbfSettingSystemAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", MbfSettingSystemAction.ACTION_DELETE); %>
