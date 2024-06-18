<%@page import="com.example.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>JSP page</title>
<%@include file="componants/common_css_js.jsp" %>
</head>
<body>
	<%@include file="componants/navbar.jsp" %>
	<h1>Hello world</h1>
	<h1>creating session factory object</h1>
	<%
		out.println(FactoryProvider.getFactory());
	%>
</body>
</html>