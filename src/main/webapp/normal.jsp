<%@page import="com.entities.User" %>
<%
	User user=(User)session.getAttribute("current-user");
	if(user==null){
		
		session.setAttribute("message","You are not logged in !! login first");
		response.sendRedirect("login.jsp");
		return;
	}else{
		if(user.getUserType().equals("admin")){
			session.setAttribute("message", "You are not normal");
			response.sendRedirect("login.jsp");
			return;
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="componants/common_css_js.jsp" %>
<title>Normal User</title>
</head>
<body>
	<%@include file="componants/navbar.jsp" %>
</body>
</html>