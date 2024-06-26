<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.FactoryProvider" %>
<%@ page import="com.dao.ProductDao" %>
<%@ page import="com.entities.Product" %>
<%@ page import="com.example.Helper" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <%@ include file="componants/common_css_js.jsp" %>
</head>
<body>
    <%@ include file="componants/navbar.jsp" %>
    <div class="container-fluid p-5">
        <h2 class="custom-text">Search Results</h2>
        <div class="row">
            <%
                String query = request.getParameter("query");
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                List<Product> products = pdao.searchProducts(query);
                
                if (products.isEmpty()) {
            %>
                <div class="alert alert-warning" role="alert">
                    No products found for "<%= query %>"
                </div>
            <% } else {
                for (Product product : products) { %>
                    <div class="col-md-4 mt-5">
                        <div class="card product-card">
                            <img class="card-img-top" src="img/products/<%= product.getpPhoto() %>" alt="" style="max-height:270px; max-width:100%; width:auto;">
                            <div class="card-body">
                                <h5 class="card-title"><%= product.getpName() %></h5>
                                <p class="card-text"><%= product.getpDesc() != null ? Helper.get10Words(product.getpDesc()) : "No description available" %></p>
                                <div class="card-footer text-center">
                                    <button class="btn btn-outline-primary">&#8360; <%= product.getOriginalPrice() %>/- <span class="text-secondary discount-label"><%= product.getpPrice() %>/- <%= product.getpDiscount() %>% off</span></button>
                                    <button class="btn btn-primary" onclick="add_to_cart(<%= product.getpID() %>,'<%= product.getpName() %>',<%= product.getOriginalPrice() %>, 'img/products/<%= product.getpPhoto() %>')">Add to Cart</button>
                                    <i class="fa fa-heart" class="btn btn-primary" onclick="add_to_wish(<%= product.getpID() %>,'<%= product.getpName() %>',<%= product.getOriginalPrice() %>, 'img/products/<%= product.getpPhoto() %>')"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                <% }
            } %>
        </div>
    </div>
    <%@ include file="componants/common_modal.jsp" %>
    <%@ include file="componants/footer.jsp" %>
</body>
</html>
