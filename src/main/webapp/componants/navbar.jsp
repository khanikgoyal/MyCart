<%@page import="com.entities.User" %>
<%
	User user1=(User)session.getAttribute("current-user");
%>
<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
   <div class="container">
   		<a class="navbar-brand" href="index.jsp">
   		<img src="img/logo4.png" alt="MyCart Logo" style="height: 36px; width:100px">
   		</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
    </ul>
    <ul class="navbar-nav ml-auto">
    	<li class="nav-item active">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#wish"><i class="fa fa-heart" style="font-size:25px;"></i><span class="ml-0 wish-items" style="font-size:20px;">( 0 )</span> </a>
      	</li>
    	<li class="nav-item active">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#cart"><i class="fa fa-cart-plus" style="font-size:25px;"></i><span class="ml-0 cart-items" style="font-size:20px;">( 0 )</span> </a>
      	</li>
    <% if(user1==null){
      %>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Login
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="login.jsp">Admin</a>
                <a class="dropdown-item" href="login.jsp">Normal</a>
            </div>
        </li>
	    <li class="nav-item active">
	      <a class="nav-link" href="register.jsp">Register </a>
	    </li>
      <% 
    	
    }else{
    %>	
     	<li class="nav-item active">
        <a class="nav-link"
        <%if(user1.getUserType().equals("admin")){%>
        	href="admin.jsp"
        <%}else{%>
        	href="normal.jsp"
        <%} %>
        ><%= user1.getUserName() %></a>
        
      	</li>
	    <li class="nav-item active">
	      <a class="nav-link" href="LogoutServlet">Login Out </a>
	    </li>
    <% 
    }
    %>
    </ul>
  </div>
   </div>
</nav>