<%@page import ="com.entities.User" %>

<%
User user=(User)session.getAttribute("current-user");
if(user==null){
	
	session.setAttribute("message","You are not logged in !! login first");
	response.sendRedirect("login.jsp");
	return;
}


%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <%@ include file="componants/common_css_js.jsp" %>
<title>Checkout</title>
<style>
.payment-option {
    margin-bottom: 10px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.payment-option-label {
    padding-left: 10px; /* Adjust as needed */
    font-size: 16px; /* Adjust font size */
}
</style>

</head>
<body>
<%@ include file="componants/navbar.jsp" %>

<div class="container">
	<div class="row mt-5">
		<div class="col-md-6">
		<!-- user details -->
			<div class="card">
				<div class="card-body">
					<h3 class="text-center mt-1">Your details for order</h3>
					<form action="PlaceOrderServlet" method="post" onsubmit="submitOrder(event)">
    <input type="hidden" name="cart" id="cartInput">
						<div class="form-group">
							<label for="exampleInputEmail1">Email address</label>
    						<input name="phone" value="<%=user.getUserPhone() %>" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Phone no">
						</div>
						<div class="form-group">
							<label for="name">Your name</label>
    						<input name="name" value="<%=user.getUserName() %>" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
    					</div>
						<div class="form-group">
							<label for="name">Pincode</label>
    						<input name="pincode" value="110086" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
    					</div>
    					<div class="form-group">
    						<label for="exampleFormControlTextarea1" placeholder="Enter your address">Your shipping address</label>
   							<textarea name="address" value="<%=user.getUserAddress() %>" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
  						</div>
		                <div class="container text-center mt-5">
		                    <button class="btn btn-outline-success">Order Now</button>
		                    <button class="btn btn-outline-primary">Continue Shopping</button>
		                </div>
					</form>
					
				</div>
			</div>
		</div>
		<div class="col-md-4">
    <!-- cart data -->
    <div class="card">
        <div class="card-body">
            <h3 class="text-center mt-1">Selected Payment Option</h3>
            <form id="paymentForm">
                <div class="form-check payment-option">
                    <input class="form-check-input" type="radio" name="paymentOption" id="paymentOption1" value="creditCard">
                    <label class="form-check-label" for="paymentOption1">
                        <div class="payment-option-label">
                            Credit Card
                        </div>
                    </label>
                </div>
                <div class="form-check payment-option">
                    <input class="form-check-input" type="radio" name="paymentOption" id="paymentOption2" value="paypal">
                    <label class="form-check-label" for="paymentOption2">
                        <div class="payment-option-label">
                            PayPal
                        </div>
                    </label>
                </div>
                <div class="form-check payment-option">
                    <input class="form-check-input" type="radio" name="paymentOption" id="paymentOption3" value="cod">
                    <label class="form-check-label" for="paymentOption3">
                        <div class="payment-option-label">
                            Cash on Delivery (COD)
                        </div>
                    </label>
                </div>
            </form>
        </div>
    </div>
</div>

	</div>
</div>

<%@include file="componants/common_modal.jsp"%> 
<script>
    function submitOrder(event) {
        event.preventDefault();
        let cart = localStorage.getItem("cart");
        document.getElementById("cartInput").value = cart;
        event.target.submit();
    }
</script>
</body>
</html>