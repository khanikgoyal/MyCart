package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entities.Product;
import com.entities.User;

import org.hibernate.query.Query;

public class UserDao {
	private SessionFactory factory;
	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public User getUserByEmailAndPassword(String email, String password) {
		User user=null;
		try{
			String query="from User where userEmail =: e and userPassword=: p";
			Session session = this.factory.openSession();
			Query<User> q=session.createQuery(query, User.class);
			q.setParameter("e", email);
			q.setParameter("p", password);
			
			user=(User)q.uniqueResult();
			
			session.close();
		}catch(Exception e) {
			
			e.printStackTrace();
		}
		
		return user;
	}
	public List<User> getAllUsers() {
		Session s=this.factory.openSession();
		Query query=s.createQuery("from User");
		List<User> list=query.list();
		return list;
		
	}
}
