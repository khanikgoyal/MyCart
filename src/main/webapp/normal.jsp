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
	<div class="container">
        <div class="row mt-3">
        	<div class="card ">
            <!-- Profile Header -->
            <div class="col-md-12 profile-header">
                <h1 class="mt-3"><%=user.getUserName()%></h1>
            </div>
            </div>
        </div>

        <!-- Profile Details -->
        
        <div class="row mt-4">
            <div class="col-md-6 contact-info">
                <h2>Contact Information</h2>
                <p>Email: <%=user.getUserEmail() %></p>
                <p>Phone: <%=user.getUserPhone() %></p>
                <p>Address: <%=user.getUserAddress() %></p>
                <a href="#" class="btn btn-secondary btn-sm btn-edit-profile">Edit Profile</a>
            </div>
        </div>

        <!-- Order History -->
        <div class="row order-history">
            <div class="col-md-12">
                <h2>Order History</h2>
                <!-- Add your order history content here -->
            </div>
        </div>

        <!-- Wishlist Section -->
        <h3 class="mt-5 wishlist">Wishlist</h3>
        <div class="row mt-2">
            <div class="col-md-6">
                <!-- Wishlist Items -->
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mt-1">Your Selected Items</h3>
                        <div class="wish-body">
                            <!-- Add your wishlist items dynamically -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
</body>
<%@ include file="componants/footer.jsp" %>
</html>