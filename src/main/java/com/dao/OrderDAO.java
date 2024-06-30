package com.dao;

import com.entities.Order;
import com.entities.User;
import com.example.HibernateUtil;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDAO {
    
	  private SessionFactory factory;

	    public OrderDAO(SessionFactory factory) {
	        this.factory = factory;
	    }

	    public void saveOrder(Order order) {
	        Session session = factory.openSession();
	        Transaction tx = session.beginTransaction();
	        session.save(order);
	        tx.commit();
	        session.close();
	    }

	    public List<Order> getAllOrders() {
	        Session session = factory.openSession();
	        List<Order> orders = session.createQuery("from Order", Order.class).list();
	        session.close();
	        return orders;
	    }
	    public List<Order> getAllOrder() {
			Session s=this.factory.openSession();
			Query query=s.createQuery("from Order");
			List<Order> list=query.list();
			return list;
			
		}
    // Other CRUD methods as needed
}

