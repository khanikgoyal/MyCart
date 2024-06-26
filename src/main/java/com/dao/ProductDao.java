package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.entities.Product;

public class ProductDao {
	private SessionFactory factory;
	public ProductDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public boolean saveProduct(Product product) { 
		boolean f=false;
		try {
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		session.persist(product);
		tx.commit();
		session.close();
		f=true;
		
		}catch(Exception e) {
			e.printStackTrace();
			f=false;
		}
		return f;
	}
	
	public List<Product> getAllProduct() {
		Session s=this.factory.openSession();
		Query query=s.createQuery("from Product");
		List<Product> list=query.list();
		return list;
		
	}
	public List<Product> getProductByCategory(int cid) {
		Session s=this.factory.openSession();
		Query query=s.createQuery("from Product as p where p.category.categoryId=: id");
		query.setParameter("id", cid);
		List<Product> list=query.list();
		return list;	
	}
	public List<Product> searchProducts(String query) {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product as p where p.pName like :searchQuery or p.pDesc like :searchQuery");
        q.setParameter("searchQuery", "%" + query + "%");
        List<Product> list = q.list();
        return list;
    }
	public void updateProduct(Product product) {
	    Session session = factory.openSession();
	    Transaction tx = session.beginTransaction();
	    session.update(product);
	    tx.commit();
	    session.close();
	}

	public void deleteProduct(int productId) {
	    Session session = factory.openSession();
	    Transaction tx = session.beginTransaction();
	    Product product = (Product) session.get(Product.class, productId);
	    session.delete(product);
	    tx.commit();
	    session.close();
	}

}
