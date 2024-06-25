<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.FactoryProvider" %>
<%@ page import="com.dao.ProductDao" %>
<%@ page import="com.dao.CategoryDao" %>
<%@ page import="com.entities.Product" %>
<%@ page import="com.entities.Category" %>
<%@ page import="com.example.Helper" %>
<!DOCTYPE html>
<html>
<head>
	
    <meta charset="UTF-8">
    <title>Product Display</title>
    <%@ include file="componants/common_css_js.jsp" %> <!-- Include your common CSS and JS files -->
</head>
<body>
    <%@ include file="componants/navbar.jsp" %> <!-- Include your navbar -->

    <div class="container-fluid mt-3">
        <div class="row">
            <%-- Left Sidebar with Categories --%>
            <div class="col-md-2">
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>
                    <% CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                       List<Category> clist = cdao.getCategory();
                       for (Category c : clist) { %>
                    <a href="index.jsp?category=<%=c.getCategoryId()%>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>
                    <% } %>
                </div>
            </div>

            <%-- Main Content Area for Products --%>
            <div class="col-md-10">
    <div class="row">
        <% 
           String cat=request.getParameter("category");
           
           ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
           List<Product> list=null;
           if(cat==null||cat.trim().equals("all")){
        	   
           list = pdao.getAllProduct();
           }else{
        	   int cid=Integer.parseInt(cat.trim());
        	   list=pdao.getProductByCategory(cid);
           }
           
           if(list.size()==0){
        	   %>
        	   <div class="container mt-5">
    		        <div class="alert alert-warning" role="alert">
      				No products in this category available.
    				</div>
  				</div>
  		   <%
           }
           int count = 0; // Counter to keep track of products per row
           for (Product product : list) { %>
           
            <% if (count % 3 == 0) { %> <!-- Start a new row for every third product -->
            </div> <!-- Close previous row -->
            <div class="row mt-4"> <!-- Start new row -->
            <% } %>
            
            <div class="col-md-4"> <!-- Each product takes 4 columns on medium screens -->
                <div class="card product-card">
                    <img class="card-img-top" src="img/products/<%= product.getpPhoto() %>" alt="" style="max-height:270px; max-width:100;width:auto;">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getpName() %></h5>
                        <p class="card-text">
                            <% if (product.getpDesc() == null || product.getpDesc().isEmpty()) { %>
                            <small>No description available</small>
                            <% } else { %>
                            <%= Helper.get10Words(product.getpDesc()) %>
                            <% } %>
                        </p>
                    </div>
                    <div class="card-footer text-center">
                        <button class="btn btn-outline-primary">&#8360; <%=product.getOriginalPrice()%>/- <span class="text-secondary discount-label"><%=product.getpPrice()%>/- <%=product.getpDiscount()%>% off</span></button>
                        <button class="btn btn-primary" onclick="add_to_cart(<%=product.getpID()%>,'<%=product.getpName()%>',<%=product.getOriginalPrice()%>, 'img/products/<%= product.getpPhoto() %>')">Add to Cart</button>
                        <i class="fa fa-heart" class="btn btn-primary" onclick="add_to_wish(<%=product.getpID()%>,'<%=product.getpName()%>',<%=product.getOriginalPrice()%>, 'img/products/<%= product.getpPhoto() %>')"></i>
                    </div>
                </div>
            </div>
            
            <% count++; // Increment count for each product %>
           <% } %>
    </div> <!-- Close the final row -->
</div>

</div>

<%@include file="componants/common_modal.jsp"%>
</body>
</html>
