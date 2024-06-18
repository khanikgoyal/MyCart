<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="componants/common_css_js.jsp" %>
<title>User Login - MyCart</title>
</head>
<body>
	<%@include file="componants/navbar.jsp" %>
	<div class="conatiner">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card mt-3">
					<div class="card-header custom-bg text-white">
						<h3>Login here</h3>
					</div>
					<div class="card-body">
						<%@include file="componants/message.jsp" %>
						<form action="LoginServlet" method="post">
							  <div class="form-group">
							    <label for="exampleInputEmail1">Email address</label>
							    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
							  </div>
							  <div class="form-group">
							    <label for="exampleInputPassword1">Password</label>
							    <input name="password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
							  </div>
							  <a href="register.jsp" class="text-center d-block mb-2">if not registered click here</a>
							  <div class="container text-center">
							    <button type="submit" class="btn btn-primary custom-bg border-0">Submit</button>
							    <button type="reset" class="btn btn-primary custom-bg border-0">Reset</button>
							  </div>
							  
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>