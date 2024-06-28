package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.entities.Order;
import com.entities.Product;
import com.entities.User;
import com.example.HibernateUtil;

/**
 * Servlet implementation class OrderServlet
 */
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = (User) request.getSession().getAttribute("current-user");

        if (user == null) {
            request.getSession().setAttribute("message", "You are not logged in !! Login first");
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve selected products from the session or request
        List<Product> products = new ArrayList<>();
        // Here you need to populate the products list based on your cart implementation

        double totalAmount = 0;
        for (Product product : products) {
            totalAmount += product.getpPrice();
        }

        Order order = new Order(user, products, new Date(), totalAmount);

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.save(order);
            tx.commit();
        }

        response.sendRedirect("orderSuccess.jsp");
    }
}


