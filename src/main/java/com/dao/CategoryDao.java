package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.entities.Category;
import com.entities.User;

public class CategoryDao {
	private SessionFactory factory;
	public CategoryDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public int saveCategory(Category cat) { 
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		session.persist(cat);
		int catId=cat.getCategoryId();
		tx.commit();
		session.close();
		return catId;
	}
	
	public List<Category> getCategory(){
		Session s=this.factory.openSession();
		String query="from Category";
		Query<Category> q=s.createQuery(query, Category.class);
		List<Category> list=q.list();
		return list;
		
	}
	Category cat=null;
	public Category getCategoryById(int cid) {
		try {
			Session session=this.factory.openSession();
			cat=session.get(Category.class, cid);
			session.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return cat;
	}
}
