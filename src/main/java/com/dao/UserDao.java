package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entities.Product;
import com.entities.User;

import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;

public class UserDao {
	private SessionFactory factory;
	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public User getUserByEmail(String email) {
        User user = null;
        try {
            String query = "from User where userEmail =: e";
            Session session = this.factory.openSession();
            Query<User> q = session.createQuery(query, User.class);
            q.setParameter("e", email);
            user = q.uniqueResult();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean authenticateUser(String email, String password) {
        User user = getUserByEmail(email);
        if (user != null) {
            return BCrypt.checkpw(password, user.getUserPassword());
        }
        return false;
    }
	public List<User> getAllUsers() {
		Session s=this.factory.openSession();
		Query query=s.createQuery("from User");
		List<User> list=query.list();
		return list;
		
	}
}
