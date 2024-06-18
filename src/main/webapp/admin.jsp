<%@page import="com.entities.User" %>
<%
	User user=(User)session.getAttribute("current-user");
	if(user==null){
		
		session.setAttribute("message","You are not logged in !! login first");
		response.sendRedirect("login.jsp");
		return;
	}else{
		if(user.getUserType().equals("normal")){
			session.setAttribute("message", "You are not admin");
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
<%@include file="componants/common_css_js.jsp" %>
<meta charset="ISO-8859-1">
<title>Admin panel</title>
</head>
<body>
	<%@include file="componants/navbar.jsp" %>
	<div class="container admin">
		<div class="row mt-3">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="img-fluid rounded-circle" alt="user_icon" src="img/man.png">
						</div>
						<h1>3564</h1>
						<h1 class="text-uppercase text-muted">Users </h1>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/options.png">
						</div>
						<h1>3564</h1>
						<h1 class="text-uppercase text-muted">Categories </h1>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/products.png">
						</div>
						<h1>3564</h1>
						<h1 class="text-uppercase text-muted">Products </h1>
					</div>
				</div>
			</div>
		</div>
		
<!-- 2nd row -->
		<div class="row mt-3">
			<div class="col-md-6">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/calculator.png">
						</div>
						<p class="mt-2">Click here to add new category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/plus.png">
						</div>
						<p class="mt-2">Click here to add new product</p>
						<h1 class="text-uppercase text-muted">Add Product</h1>
					</div>
				</div>
			</div>
		</div>
	</div>	 
	
<!-- Add category model -->	
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<!-- End add category model -->
</body>
</html>