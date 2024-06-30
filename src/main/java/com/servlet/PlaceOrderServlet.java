package com.servlet;

import com.dao.OrderDAO;
import com.entities.Order;
import com.entities.OrderItem;
import com.entities.User;
import com.example.FactoryProvider;
import com.example.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("current-user");

        if (user == null) {
            session.setAttribute("message", "You are not logged in! Please login first.");
            response.sendRedirect("login.jsp");
            return;
        }
        
        String name = request.getParameter("name");
		String phone =request.getParameter("phone");
		String pincode =request.getParameter("pincode");
		String address =request.getParameter("address");

        String cartJson = request.getParameter("cart");
        List<OrderItem> orderItems = new ArrayList<>();

        JSONArray jsonArray = new JSONArray(cartJson);
        double totalPrice = 0;

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            OrderItem item = new OrderItem();
            item.setProductId(jsonObject.getInt("productId"));
            item.setProductName(jsonObject.getString("productName"));
            item.setQuantity(jsonObject.getInt("productQuantity"));
            item.setPrice(jsonObject.getDouble("productPrice"));

            totalPrice += item.getPrice() * item.getQuantity();
            orderItems.add(item);
        }

     // Debug: Print total price
        System.out.println("Total Price: " + totalPrice);
        
        Order order = new Order();
        order.setUser(user);
        order.setOrderItems(orderItems);
        order.setTotalPrice(totalPrice);
        order.setOrderDate(new Date());
        order.setName(name);
        order.setPhone(phone);
        order.setPincode(pincode);
        order.setAddress(address);
        order.setStatus("In Process");
        // Debug: Print order details
        System.out.println("Order Details: " + order);

        for (OrderItem item : orderItems) {
            item.setOrder(order);
            // Debug: Print each order item details
            System.out.println("Order Item: " + item);
        }

        OrderDAO orderDAO = new OrderDAO(FactoryProvider.getFactory());
        orderDAO.saveOrder(order);
        

//        session.setAttribute("message", "Order placed successfully!");
        response.sendRedirect("orderSuccess.jsp");
    }
}
