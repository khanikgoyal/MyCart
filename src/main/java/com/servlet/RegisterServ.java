package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;

import com.entities.User;
import com.example.FactoryProvider;



/**
 * Servlet implementation class RegisterServ
 */
public class RegisterServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		try(PrintWriter out = response.getWriter()){
			try {
				String userName = request.getParameter("user_name");
				String userEmail = request.getParameter("user_email");
				String userPassword = BCrypt.hashpw(request.getParameter("user_password"),BCrypt.gensalt());
				String userPhone = request.getParameter("user_phone");
				String userAddress = request.getParameter("user_address");
				
				User user=new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");
				
				Session hibernateSession=FactoryProvider.getFactory().openSession();
				Transaction tx =hibernateSession.beginTransaction();
				
				Query<User> query = hibernateSession.createQuery("FROM User WHERE userEmail = :user_email OR userPhone = :user_phn", User.class);
                query.setParameter("user_email", userEmail);
                query.setParameter("user_phn", userPhone);
                User existingUser = query.uniqueResult();
                
                if (existingUser != null) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("message", "Email or Phone number already exists!");
                    httpSession.setAttribute("messageType", "warning");
                    response.sendRedirect("register.jsp");
                    return;
                }
				
				hibernateSession.persist(user);
				
				int userId = user.getUserId();
				
				tx.commit(); 	
				hibernateSession.close();
				
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Resgistration Successful !!");
				httpSession.setAttribute("messageType", "success");
				response.sendRedirect("login.jsp");
				return;
				
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}


}
