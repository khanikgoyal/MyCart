package com.servlet;
import com.dao.ProductDao;
import org.hibernate.SessionFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.dao.CategoryDao;
import com.dao.ProductDao;
import com.entities.Category;
import com.entities.Product;
import com.example.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated methdoGet(request, response);
		// Inside the doPost method of ProductOperationServlet

		String operation = request.getParameter("operation");

		if (operation.trim().equals("addcategory")) {
		    // existing add category code
			 String title = request.getParameter("catTitle");
             String description = request.getParameter("catDescription");

             Category category = new Category();
             category.setCategoryTitle(title);
             category.setCategoryDescription(description);

             //category databse save:
             CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
             int catId = categoryDao.saveCategory(category);
//             out.println("Category Saved");
             HttpSession httpSession = request.getSession();
             httpSession.setAttribute("message", "Category added successfully : " + catId);
             response.sendRedirect("admin.jsp");
             return;

		} else if (operation.trim().equals("addproduct")) {
		    // existing add product code
			 String pName = request.getParameter("pName");
             String pDesc = request.getParameter("pDesc");
             int pPrice = Integer.parseInt(request.getParameter("pPrice"));
             int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
             int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
             int catId = Integer.parseInt(request.getParameter("catId"));
             Part part = request.getPart("pPic");

             Product p = new Product();
             p.setpName(pName);
             p.setpDesc(pDesc);
             p.setpPrice(pPrice);
             p.setpDiscount(pDiscount);
             p.setpQuantity(pQuantity);
             p.setpPhoto(part.getSubmittedFileName());

             //get category by id
             CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
             Category category = cdoa.getCategoryById(catId);

             p.setCategory(category);

             //product save...
             ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
             pdao.saveProduct(p);

             //pic upload
//             find out the path to upload photo
             String path = request.getRealPath("img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
             System.out.println(path);

             //uploading code..
             try {

                 FileOutputStream fos = new FileOutputStream(path);

                 InputStream is = part.getInputStream();

//             reading data
                 byte[] data = new byte[is.available()];

                 is.read(data);

//             writing the data
                 fos.write(data);

                 fos.close();

             } catch (Exception e) {
                 e.printStackTrace();
             }

//             out.println("Product save sucess...");
             HttpSession httpSession = request.getSession();
             httpSession.setAttribute("message", "Product is added successfully..");
             response.sendRedirect("admin.jsp");
             return;

		} else if (operation.trim().equals("editcategory")) {
		    // Edit category code
		    int catId = Integer.parseInt(request.getParameter("catId"));
		    String catTitle = request.getParameter("catTitle");
		    String catDescription = request.getParameter("catDescription");
		    
		    Category category = new Category(catId, catTitle, catDescription);
		    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
		    cDao.updateCategory(category);
		    response.sendRedirect("admin.jsp");
		} else if (operation.trim().equals("editproduct")) {
		    // Edit product code
		    int pId = Integer.parseInt(request.getParameter("pId"));
		    String pName = request.getParameter("pName");
		    String pDescription = request.getParameter("pDescription");
		    int pPrice = Integer.parseInt(request.getParameter("pPrice"));
		    int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
		    int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
		    int catId = Integer.parseInt(request.getParameter("catId"));
		    
		    Category category = new CategoryDao(FactoryProvider.getFactory()).getCategoryById(catId);
		    Product product = new Product(pId, pName, pDescription, pPrice, pDiscount, pQuantity, category);
		    
		    ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
		    pDao.updateProduct(product);
		    response.sendRedirect("admin.jsp");
		} else if (operation.trim().equals("deletecategory")) {
		    // Delete category code
		    int catId = Integer.parseInt(request.getParameter("catId"));
		    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
		    cDao.deleteCategory(catId);
		    response.getWriter().write("success");
		} else if (operation.trim().equals("deleteproduct")) {
		    // Delete product code
		    int pId = Integer.parseInt(request.getParameter("pId"));
		    ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
		    pDao.deleteProduct(pId);
		    response.getWriter().write("success");
		}

	}

}
