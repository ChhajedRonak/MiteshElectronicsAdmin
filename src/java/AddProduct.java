/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import POJOs.BrandMaster;
import POJOs.CategoryMaster;
import POJOs.ProductMaster;
import POJOs.SubCategoryMaster;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author HP PC
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10 MB 
        maxFileSize = 1024 * 1024 * 50, // 50 MB
        maxRequestSize = 1024 * 1024 * 100)   	// 100 MB
public class AddProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            int subCategoryId = Integer.parseInt(request.getParameter("sub_category_id"));
            int brandId = Integer.parseInt(request.getParameter("brand_id"));
            String productName = request.getParameter("product_name");
            String description = request.getParameter("description");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            double price = Double.parseDouble(request.getParameter("price"));

            Part part = request.getPart("image");
            InputStream inputStream=part.getInputStream();
            byte [] byteImg= new byte[(int)part.getSize() ];
            inputStream.read(byteImg);
//            String fileName = extractFileName(part);
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String savePath = "E:\\MCA\\SEM-3\\Advance Java\\Project\\MiteshElectronics\\images" + File.separator + fileName;
          //  File fileSaveDir = new File(savePath);
           // Files.copy(part.getInputStream(), fileSaveDir.toPath());
//            part.write(savePath + File.separator);

            Session session = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory().openSession();
            Transaction tx = session.beginTransaction();
            ProductMaster product = new ProductMaster();
            
            product.setProductName(productName);
            product.setDescription(description);
            product.setInStock(quantity);
            product.setCategoryDiscount(discount);
            product.setImageName(fileName);
            product.setPrice(price);
   
            
            product.setProductImagel(byteImg);

            //setting category
            CategoryMaster categoryMaster = new CategoryMaster();
            categoryMaster.setCategoryId(categoryId);
            product.setCategoryMaster(categoryMaster);

//setting sub category
            SubCategoryMaster subCategoryMaster = new SubCategoryMaster();
            subCategoryMaster.setSubCategoryId(subCategoryId);
            product.setSubCategoryMaster(subCategoryMaster);

//setting brand
            BrandMaster brand = new BrandMaster();
            brand.setBrandId(brandId);
            product.setBrandMaster(brand);

            session.save(product);
            session.flush();
            tx.commit();

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Adding Product</title>");
            out.println("</head>");
            out.println("<body>");
            RequestDispatcher rd = request.getRequestDispatcher("addProduct.jsp");
            rd.include(request, response);

            out.println("<h3 align=center>Product Added<h3>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String items[] = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
//            return s.substring(s.indexOf("=")+2,s.length()-1);
                return s.substring(s.lastIndexOf("\\") + 1, s.length() - 1);
            }

        }
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
