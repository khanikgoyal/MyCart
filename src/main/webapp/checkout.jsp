<%@page import ="com.entities.User" %>

<%
User user=(User)session.getAttribute("current-user");
if(user==null){
	
	session.setAttribute("message","You are not logged in !! login first");
	response.sendRedirect("login.jsp");
	return;
}


%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <%@ include file="componants/common_css_js.jsp" %>
<title>Checkout</title>

</head>
<body>
<%@ include file="componants/navbar.jsp" %>

<div class="container">
	<div class="row mt-5">
		<div class="col-md-6">
		<!-- cart data -->
			<div class="card">
				<div class="card-body">
					<h3 class="text-center mt-1">Your Selected Items</h3>
					<div class="cart-body">
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
		<!-- user details -->
			<div class="card">
				<div class="card-body">
					<h3 class="text-center mt-1">Your details for order</h3>
					<form action="OrderServlet" method="post">
						<div class="form-group">
							<label for="exampleInputEmail1">Email address</label>
    						<input value="<%=user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="name">Your name</label>
    						<input value="<%=user.getUserName() %>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
    					</div>
    					<div class="form-group">
    						<label for="exampleFormControlTextarea1" placeholder="Enter your address">Your shipping address</label>
   							<textarea value="<%=user.getUserAddress() %>" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
  						</div>
  						<div class="container text-center">
  							<button class="btn btn-outline-success">Order Now</button>
  							<button class="btn btn-outline-primary">Continue Shopping</button>
  						</div>
					</form>
					
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="componants/common_modal.jsp"%> 
</body>
</html>