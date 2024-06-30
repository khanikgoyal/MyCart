<%@page import="com.entities.User" %>
<%@page import="com.entities.Category" %>
<%@page import="com.entities.Product" %>
<%@page import="com.dao.CategoryDao" %>
<%@page import="com.entities.Order" %>
<%@page import="com.dao.OrderDAO" %>
<%@page import="com.dao.ProductDao" %>
<%@page import="com.dao.UserDao" %>
<%@page import="com.example.FactoryProvider" %>
<%@page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin");
            response.sendRedirect("login.jsp");
            return;
        }
    }
    
    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> categories = cDao.getCategory();
    
    ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
    List<Product> products = pDao.getAllProduct();
    
    UserDao uDao = new UserDao(FactoryProvider.getFactory());
    List<User> users = uDao.getAllUsers();
    
    OrderDAO oDao = new OrderDAO(FactoryProvider.getFactory());
    List<Order> orders = oDao.getAllOrder();
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
     <div class="container-fluid admin">
     	<div class="container-fluid mt-3">
     		<%@include file="componants/message.jsp" %>
     	</div>
     		<div class="row mt-5">
     			<div class="col-md-2">
            	    <div class="list-group">
                	    <a href="#" class="list-group-item list-group-item-action active">Dashboard</a>
                    	<a href="admin.jsp?para=users" class="list-group-item list-group-item-action">Users</a>
                    	<a href="admin.jsp?para=cat" class="list-group-item list-group-item-action">Categories</a>
                    	<a href="admin.jsp?para=prod" class="list-group-item list-group-item-action">Products</a>
                    	<a href="admin.jsp?para=order" class="list-group-item list-group-item-action">Orders</a>
                    
                	</div>
            	</div>
            	 <div class="col-md-10">
    
         <% 
           String para=request.getParameter("para");
          
           if(para != null && para.trim().equals("cat")){%>
           <div class="row">
            	<div class="col-md-4">
            		<div class="container">
        				<div class="d-flex justify-content-center">
            				<h3 class="custom-text">Total Category count <%=categories.size() %></h3>
      				    </div>
    				</div>
            	</div>
            	<div class="col-md-4">
                    <div class="container">
        				<div class="d-flex justify-content-center">
            				<button class="btn custom-bg btn-lg d-flex align-items-center text-white" data-toggle="modal" data-target="#add-category-modal">
               					 <i class="fa fa-plus mr-2"></i>
               					 <span>Add New Category</span>
           					</button>
      				    </div>
    				</div>
            	</div>
            </div>
            <table class="table table-bordered mt-4">
                    <thead>
                        <tr class="custom-bg text-white">
                            <th>ID</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                            for (Category category : categories) {
                        %>
                        <tr>
                            <td><%= category.getCategoryId() %></td>
                            <td><%= category.getCategoryTitle() %></td>
                            <td><%= category.getCategoryDescription() %></td>
                            <td>
                                <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#edit-category-modal-<%= category.getCategoryId() %>">Edit</button>
                                <br>
                                <button class="btn btn-danger btn-sm" onclick="deleteCategory(<%= category.getCategoryId() %>)">Delete</button>
                            </td>
                        </tr>

                        <!-- Edit Category Modal -->
                        <div class="modal fade" id="edit-category-modal-<%= category.getCategoryId() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                              <div class="modal-header custom-bg text-white">
                                <h5 class="modal-title" id="exampleModalLabel">Edit Category</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                <form action="ProductOperationServlet" method="post">
                                    <input type="hidden" name="operation" value="editcategory"/>
                                    <input type="hidden" name="catId" value="<%= category.getCategoryId() %>"/>
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="catTitle" value="<%= category.getCategoryTitle() %>" required />
                                    </div>
                                    <div class="form-group">
                                        <textarea style="height:300px" class="form-control" name="catDescription" required><%= category.getCategoryDescription() %></textarea>
                                    </div>
                                    <div class="container text-center">
                                        <button class="btn btn-outline-success">Update Category</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </form>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!-- End Edit Category Modal -->
                        <% } %>
                    </tbody>
                </table>
                 
        <% }else if(para != null && para.trim().equals("prod")){%>
        	<div class="row">
            		<div class="col-md-4">
            		<div class="container">
        				<div class="d-flex justify-content-center">
            				<h3 class="custom-text">Total Product Count <%=products.size() %></h3>
      				    </div>
    				</div>
            	</div>
            	<div class="col-md-4">
                    <div class="container">
        				<div class="d-flex justify-content-center">
            				<button class="btn custom-bg btn-lg d-flex align-items-center text-white" data-toggle="modal" data-target="#add-product-modal">
               					 <i class="fa fa-plus mr-2"></i>
               					 <span>Add New Product</span>
           					</button>
      				    </div>
    				</div>
            	</div>
            </div>	
        		<table class="table table-bordered mt-4">
                    <thead>
                        <tr class="custom-bg text-white">
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Discount</th>
                            <th>Quantity</th>
                            <th>Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                     
                            for (Product product : products) {
                        %>
                        <tr>
                            <td><%= product.getpID() %></td>
                            <td><%= product.getpName() %></td>
                            <td><%= product.getpDesc() %></td>
                            <td><%= product.getpPrice() %></td>
                            <td><%= product.getpDiscount() %></td>
                            <td><%= product.getpQuantity() %></td>
                            <td><%= product.getCategory().getCategoryTitle() %></td>
                            <td>
                                <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#edit-product-modal-<%= product.getpID() %>">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteProduct(<%= product.getpID() %>)">Delete</button>
                            </td>
                        </tr>

                        <!-- Edit Product Modal -->
                        <div class="modal fade" id="edit-product-modal-<%= product.getpID() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                              <div class="modal-header custom-bg text-white">
                                <h5 class="modal-title" id="exampleModalLabel">Edit Product</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="operation" value="editproduct"/>
                                    <input type="hidden" name="pId" value="<%= product.getpID() %>"/>
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="pName" value="<%= product.getpName() %>" required />
                                    </div>
                                    <div class="form-group">
                                        <textarea style="height:200px" class="form-control" name="pDescription" required><%= product.getpDesc() %></textarea>
                                    </div>
                                    <div class="form-group">
                                        <input type="number" class="form-control" name="pPrice" value="<%= product.getpPrice() %>" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="number" class="form-control" name="pDiscount" value="<%= product.getpDiscount() %>" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="number" class="form-control" name="pQuantity" value="<%= product.getpQuantity() %>" required />
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control" name="catId" required>
                                            <option value="<%= product.getCategory().getCategoryId() %>"><%= product.getCategory().getCategoryTitle() %></option>
                                            <%
                                                for (Category c : categories) {
                                            %>
                                            <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="pPic">Select product image</label><br>
                                        <input type="file" class="form-control-file" id="pPic" name="pPic">
                                    </div>
                                    <div class="container text-center">
                                        <button class="btn btn-outline-success">Update Product</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </form>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!-- End Edit Product Modal -->
                        <% } %>
                    </tbody>
                </table>
                
        	   <%}else if(para != null && para.trim().equals("users")){%>
        	   			<table class="table table-bordered">
                    <thead>
                        <tr class="custom-bg text-white">
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                     
                            for (User u : users) {
                        %>
                        <tr>
                            <td><%= u.getUserId() %></td>
                            <td><%= u.getUserName() %></td>
                            <td><%= u.getUserEmail() %></td>
                            <td><%= u.getUserPhone() %></td>
                            <td><%= u.getUserAddress() %></td>
                        </tr>
                        <%} %>
                        </tbody>
                        </table>
        	   <%}else if(para != null && para.trim().equals("order")){%>
        	   			<table class="table table-bordered">
                    <thead>
                        <tr class="custom-bg text-white">
                            <th>ID</th>
                            <th>orderDate</th>
                            <th>Total amount</th>
                            <th>Status</th>
                            <th>Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                     
                            for (Order order : orders) {
                        %>
                        <tr>
                            <td><%= order.getId() %></td>
                            <td><%= order.getOrderDate() %></td>
                            <td><%= order.getTotalPrice() %></td>
                            <td><%= order.getStatus() %></td>
                            <td><%= order.getName() %></td>
                        </tr>
                        <%} %>
                        </tbody>
                        </table>
        	   <%} %>
        	   </div>
           </div>
     </div>
     
     <!-- Add Category Modal -->    
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
    <!-- End Add Category Modal -->

    <!-- Add Product Modal -->
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
                    <select class="form-control" name="catId" required>
                        <option>Select category</option>
                        <% for (Category c : categories) { %>
                        <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="pPic">Select product image</label><br>
                    <input type="file" class="form-control-file" id="pPic" name="pPic">
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
    <!-- End Add Product Modal -->
      <script>
        function deleteCategory(categoryId) {
            if (confirm('Are you sure you want to delete this category?')) {
                // AJAX call to delete category
                $.ajax({
                    url: 'ProductOperationServlet',
                    type: 'POST',
                    data: {
                        operation: 'deletecategory',
                        catId: categoryId
                    },
                    success: function(response) {
                        location.reload();
                    },
                    error: function() {
                        alert('Error deleting category');
                    }
                });
            }
        }

        function deleteProduct(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                // AJAX call to delete product
                $.ajax({
                    url: 'ProductOperationServlet',
                    type: 'POST',
                    data: {
                        operation: 'deleteproduct',
                        pId: productId
                    },
                    success: function(response) {
                        location.reload();
                    },
                    error: function() {
                        alert('Error deleting product');
                    }
                });
            }
        }
    </script>
</body>
</html>    
