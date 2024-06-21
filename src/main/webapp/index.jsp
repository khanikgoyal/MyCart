<%@page import="com.example.FactoryProvider"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.entities.Product"%>
<%@page import="com.entities.Category"%>
<%@page import="com.example.Helper"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>JSP page</title>
<%@include file="componants/common_css_js.jsp" %>
</head>
<body>
	<%@include file="componants/navbar.jsp" %>
	<div class="row mt-3 mx-2">
		<%
			ProductDao pdao=new ProductDao(FactoryProvider.getFactory());
			List<Product> list=pdao.getAllProduct();
			
			CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
			List<Category> clist=cdao.getCategory();
		%>
		<div class="col-md-2">
		<div class="list-group mt-4 ">
			<a href="#" class="list-group-item list-group-item-action active">All Products</a>
			<%for(Category c:clist){%>
			<a href="#" class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>
		
			<%}%>
		</div>
		</div>
		<div class="col-md-8">
			<div class="row mt-4">
				<div class="col-md-12">
					<div class="card-columns">
						<%for(Product product : list){ %>
						<div class="card">
							<div class="card-body">
								<h5 class="card-title"><%=product.getpName() %></h5>
								<p class="card-text"><%if(product.getpDesc()==null){%>
									<H6>Nothing in description</H6>	
								<%}else{%>
								<%=Helper.get10Words(product.getpDesc()) %></p>
								<%}%>
							</div>
						</div>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>