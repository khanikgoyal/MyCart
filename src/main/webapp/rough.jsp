<%@page import ="com.entities.User" %>
<%
User user=(User)session.getAttribute("current-user");
if(user==null){
    session.setAttribute("message","You are not logged in !! login first");
    response.sendRedirect("login.jsp");
    return;
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@ include file="componants/common_css_js.jsp" %>
<title>Checkout</title>
<script src="https://js.stripe.com/v3/"></script>
</head>
<body>
<%@ include file="componants/navbar.jsp" %>

<div class="container">
    <div class="row mt-5">
        <div class="col-md-6">
        <!-- cart data -->
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mt-1">Your Selected Items</h3>
                    <div class="cart-body">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
        <!-- user details -->
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mt-1">Your details for order</h3>
                    <form id="payment-form">
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
                            <textarea name="address" class="form-control" id="exampleFormControlTextarea1" rows="3"><%=user.getUserAddress() %></textarea>
                        </div>
                        <div id="card-element"><!-- A Stripe Element will be inserted here. --></div>
                        <div id="card-errors" role="alert"></div>
                        <div class="container text-center">
                            <button class="btn btn-outline-success" id="submit">Order Now</button>
                            <button class="btn btn-outline-primary">Continue Shopping</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="componants/common_modal.jsp"%>
<script>
    const stripe = Stripe('pk_test_51PXLGmRt1zOrbgzjKUUCZvtEZCLhLWzcBnWJy7pVGVP0Zfwj0hDmx7XoKExOBXuK2BnT9ef3QjZXUHGbi7OB3ASW00TOgEwclF');
    const elements = stripe.elements();
    const card = elements.create('card');
    card.mount('#card-element');

    card.on('change', function(event) {
        const displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';
        }
    });

    const form = document.getElementById('payment-form');
    form.addEventListener('submit', async function(event) {
        event.preventDefault();
        let cart = localStorage.getItem("cart");
        document.getElementById("cartInput").value = cart;

        const { paymentMethod, error } = await stripe.createPaymentMethod({
            type: 'card',
            card: card,
        });
        if (error) {
            const errorElement = document.getElementById('card-errors');
            errorElement.textContent = error.message;
        } else {
            handlePaymentMethod(paymentMethod);
        }
    });

    function handlePaymentMethod(paymentMethod) {
        fetch('CreatePaymentIntentServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                payment_method_id: paymentMethod.id,
                cart: document.getElementById("cartInput").value
            })
        })
        .then(response => response.json())
        .then(paymentIntent => {
            stripe.confirmCardPayment(paymentIntent.client_secret)
            .then(result => {
                if (result.error) {
                    const errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                } else {
                    if (result.paymentIntent.status === 'succeeded') {
                        form.submit();
                    }
                }
            });
        });
    }
</script>

</body>
</html>





