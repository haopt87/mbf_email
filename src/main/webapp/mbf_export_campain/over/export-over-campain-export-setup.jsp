<%@ page language="java" contentType="text/html; charset=utf-8" import="org.agnitas.web.ExportCampaignAction"  errorPage="/error.jsp" %>
<%@ taglib uri="/WEB-INF/agnitas-taglib.tld" prefix="agn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<agn:CheckLogon/>

<agn:Permission token="stats.mailing"/>

<% request.setAttribute("sidemenu_active", new String("Statistics")); %>
<% request.setAttribute("sidemenu_sub_active", new String("statistic.campaign_export_over")); %>
<% request.setAttribute("agnTitleKey", new String("statistic.campaign_export_over")); %>
<% request.setAttribute("agnSubtitleKey", new String("Statistics")); %>
<% request.setAttribute("agnNavigationKey", new String("statsMailing")); %>
<% request.setAttribute("agnHighlightKey", new String("statistic.campaign_export_over")); %>

<% request.setAttribute("ACTION_LIST", ExportCampaignAction.ACTION_LIST ); %>
<% request.setAttribute("ACTION_VIEW", ExportCampaignAction.ACTION_VIEW ); %>
<% request.setAttribute("ACTION_CONFIRM_DELETE", ExportCampaignAction.ACTION_CONFIRM_DELETE); %>
<% request.setAttribute("ACTION_DELETE", ExportCampaignAction.ACTION_DELETE); %>
