package com.servlet;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class CreatePaymentIntentServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        Stripe.apiKey = "sk_test_51PXLGmRt1zOrbgzjZXkgLdFLb7Ldufn6Q4FZ3sg6QVlEfHvS8WEklKuLaI8grFRUuzib036UggBy1X2leykGXksG00vwxIjCuh";
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject json = new JSONObject(sb.toString());
        String paymentMethodId = json.getString("payment_method_id");
        JSONArray cartJsonArray = json.getJSONArray("cart");

        double totalPrice = 0;
        for (int i = 0; i < cartJsonArray.length(); i++) {
            JSONObject jsonObject = cartJsonArray.getJSONObject(i);
            double price = jsonObject.getDouble("productPrice");
            int quantity = jsonObject.getInt("productQuantity");
            totalPrice += price * quantity;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("amount", (int) (totalPrice * 100)); // Amount in cents
        params.put("currency", "usd");
        params.put("payment_method", paymentMethodId);
        params.put("confirmation_method", "manual");
        params.put("confirm", true);

        try {
            PaymentIntent paymentIntent = PaymentIntent.create(params);
            JSONObject responseJson = new JSONObject();
            responseJson.put("client_secret", paymentIntent.getClientSecret());
            response.getWriter().write(responseJson.toString());
        } catch (StripeException e) {
            response.setStatus(500);
            response.getWriter().write(new JSONObject().put("error", e.getMessage()).toString());
        }
    }
}
