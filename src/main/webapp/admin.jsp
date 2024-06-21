<%@page import="com.entities.User" %>
<%@page import="com.entities.Category" %>
<%@page import="com.dao.CategoryDao" %>
<%@page import="com.example.FactoryProvider" %>
<%@page import="java.util.List" %>
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
		<div class="container-fluid mt-3">
		<%@include file="componants/message.jsp" %>
		</div>
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
				<div class="card" data-toggle="modal" data-target="#add-category-modal">
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
				<div class="card" data-toggle="modal" data-target="#add-product-modal">
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

<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form action="ProductOperationServlet" method="post">
      		<input type="hidden" name="operation" value="addcategory"/>
      		<div class="form-group">
      			<input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />
      		</div>
      		<div class="form-group">
      			<textarea style="height:300px" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
      		</div>
      		<div class="container text-center">
      			<button class="btn btn-outline-success">Add Category</button>
      			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      		</div>
      	</form>
      </div>
    </div>
  </div>
</div>
<!-- End add category model -->

<!-- Start product modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
      		<input type="hidden" name="operation" value="addproduct"/>
      		<div class="form-group">
      			<input type="text" class="form-control" name="pName" placeholder="Enter product name" required />
      		</div>
      		<div class="form-group">
      			<textarea style="height:200px" class="form-control" placeholder="Enter product description" name="pDescription" required></textarea>
      		</div>
      		<div class="form-group">
      			<input type="number" class="form-control" name="pPrice" placeholder="Enter product price" required />
      		</div>
      		<div class="form-group">
      			<input type="number" class="form-control" name="pDiscount" placeholder="Enter product discount" required />
      		</div>
      		<div class="form-group">
      			<input type="number" class="form-control" name="pQuantity" placeholder="Enter product quantity" required />
      		</div>
      		<div class="form-group">
      		
      		
      		<%
      		CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
      		List<Category> list=cDao.getCategory();
      		%>
            <select class="form-control" name="catId" required>
              <option>Select category</option>
              <%
              for(Category c:list){            	  
              %>
              <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
              <%} %>
            </select>
          </div>
      		<div class="form-group">
      			<label for="pPic">Select product image</label><br>
      			<input type="file" class="form-control-file" id="pPic" name="pPic">
      		</div>
      		
      		<div class="form-group">
      			
      		</div>
      		
      		<div class="container text-center">
      			<button class="btn btn-outline-success">Add product</button>
      			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      		</div>
      	</form>
      </div>
    </div>
  </div>
</div>
<!-- End of product modal -->
</body>
</html>