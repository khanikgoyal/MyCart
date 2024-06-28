<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@ include file="componants/common_css_js.jsp" %>
<title>Order Success</title>
</head>
<body>
<%@ include file="componants/navbar.jsp" %>

<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mt-1">Order Placed Successfully</h3>
                    <p>Your order has been placed successfully. You will receive an email confirmation shortly.</p>
                    <div class="container text-center">
                        <a href="index.jsp" class="btn btn-outline-primary">Continue Shopping</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="componants/common_modal.jsp"%>
</body>
</html>
