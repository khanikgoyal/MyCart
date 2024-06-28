<!-- <div class="col-md-6">
                <div class="card" data-toggle="modal" data-target="#add-category-modal">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/calculator.png">
                        </div>
                        <p class="mt-2">Click here to add new category</p>
                        <h1 class="text-uppercase text-muted">Add Category</h1>
                    </div>
                </div>
            </div> -->





<%@page import="com.entities.User" %>
<%@page import="com.entities.Category" %>
<%@page import="com.entities.Product" %>
<%@page import="com.dao.CategoryDao" %>
<%@page import="com.dao.ProductDao" %>
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
                <div class="card" data-toggle="modal" data-target="#show-categories">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/options.png">
                        </div>
                        <h1><%=categories.size() %></h1>
                        <h1 class="text-uppercase text-muted">Categories </h1>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" data-toggle="modal" data-target="#show-products">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 100px;" class="img-fluid " alt="user_icon" src="img/products.png">
                        </div>
                        <h1><%=products.size() %></h1>
                        <h1 class="text-uppercase text-muted">Products </h1>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add buttons row -->
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
        

        <!-- Categories and Products Tables -->
       <div class="modal fade" id="show-categories" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header custom-bg text-white">
            <h5 class="modal-title" id="exampleModalLabel">Categories</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="row mt-3">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <thead>
                        <tr>
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
            </div>
        </div>
            
          </div>
        </div>
      </div>
    </div>
    
    
    
    <!-- show products -->
    <div class="modal fade" id="show-products" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header custom-bg text-white">
            <h5 class="modal-title" id="exampleModalLabel">Products</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="row mt-3">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <thead>
                        <tr>
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
            </div>
        </div>
    </div>     
          </div>
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

    <!-- Scripts -->
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
