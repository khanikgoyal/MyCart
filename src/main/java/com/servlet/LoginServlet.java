package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.entities.User;
import com.example.FactoryProvider;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try(PrintWriter out = response.getWriter()){
			
			String email = request.getParameter("email");
			String password =request.getParameter("password");
			
			//authentication
			UserDao userDao=new UserDao(FactoryProvider.getFactory());
			boolean isAuthenticated = userDao.authenticateUser(email, password);
			
			HttpSession httpSession = request.getSession();
			
			if(!isAuthenticated) {
				httpSession.setAttribute("message", "Invalid Details");
				httpSession.setAttribute("messageType", "warning");
				response.sendRedirect("login.jsp");
				return;
			}else {
//				out.println("<h1>Welcome " +user.getUserName()+"</h1>");
				
				//login
				User user = userDao.getUserByEmail(email);
				httpSession.setAttribute("current-user", user);
				System.out.println(user.getUserType());
				
				if(user.getUserType().equals("admin")) {
					//admin.jsp
					response.sendRedirect("admin.jsp");
				}else if(user.getUserType().equals("normal")) {
					//normal.jsp
					response.sendRedirect("normal.jsp");
				}else {
					out.println("We have not identify user type !!");
				}
				
				
			}
		}
		
		
	}

}
