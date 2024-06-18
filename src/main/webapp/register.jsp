<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="componants/common_css_js.jsp" %>
<title>New User</title>
</head>
<body >
	<%@include file="componants/navbar.jsp" %>
	<div class="container-fluid">
	<div class="row mt-5">
		<div class="col-md-4 offset-md-4">
			<div class="card">
				<%@include file="componants/message.jsp" %>
				<div class="card-body px-5">
				<h1 class="text-center my-3">Sign up here</h1>
		<form action="RegisterServ" method="post">
		  	<div class="form-group">
    			<label for="name">User Name</label>
    			<input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name here">
 			</div>
		  	<div class="form-group">
    			<label for="name">User Email</label>
    			<input name="user_email" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter email here">
 			</div>
		  	<div class="form-group">
    			<label for="password">User password</label>
    			<input name="user_password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter password here">
 			</div>
		  	<div class="form-group">
    			<label for="phone">User Phone</label>
    			<input name="user_phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter phn no here">
 			</div>
		  	<div class="form-group">
    			<label for="phone">User Address</label>
    			<textarea name="user_address" style="height:150px" class="form-control" placeholder="Enter your addres"></textarea>
 			</div>
		  	<div class="container text-center">
		  		<button class="btn btn-outline-success">Register</button>
		  		<button class="btn btn-outline-warning">Reset</button>
 			</div>

		</form>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>