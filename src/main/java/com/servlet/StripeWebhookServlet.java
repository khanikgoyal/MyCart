package com.servlet;

import com.stripe.Stripe;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.net.Webhook;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.logging.Logger;


public class StripeWebhookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String STRIPE_WEBHOOK_SECRET = "whsec_..."; // Your Stripe webhook secret
    private static final Logger logger = Logger.getLogger(StripeWebhookServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        String payload = sb.toString();
        String sigHeader = request.getHeader("Stripe-Signature");

        Event event;
        try {
            event = Webhook.constructEvent(payload, sigHeader, STRIPE_WEBHOOK_SECRET);
        } catch (SignatureVerificationException e) {
            logger.severe("⚠️  Webhook error while validating signature.");
            response.setStatus(400);
            return;
        }

        // Handle the event
        switch (event.getType()) {
            case "payment_intent.succeeded":
                // Handle successful payment here
                break;
            case "payment_intent.payment_failed":
                // Handle failed payment here
                break;
            default:
                logger.warning("Unhandled event type: " + event.getType());
        }

        // Send a response back
        response.getWriter().write(new JSONObject().put("status", "success").toString());
    }
}
