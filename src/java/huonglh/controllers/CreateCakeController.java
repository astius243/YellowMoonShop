/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.controllers;

import huonglh.blos.CakeBLO;
import huonglh.entities.Cake;
import huonglh.entities.Category;
import huonglh.entities.Status;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Hau Huong
 */
public class CreateCakeController extends HttpServlet {

    private static final String SUCCESS = "ShowCakeController";
    private static final String INVALID = "insert.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);
                } catch (FileUploadException e) {
                    log("ERROR at CreateCakeController: " + e.getMessage());
                }
                Iterator it = items.iterator();
                Hashtable params = new Hashtable();
                String fileName = "not";
                String realPath = null;
                String itemName = null;
                while (it.hasNext()) {
                    FileItem item = (FileItem) it.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            itemName = item.getName();
                            if (itemName.length() > 0) {
                                fileName = itemName;
                            }
                            if (itemName.length() > 0) {
                                realPath = getServletContext().getRealPath("/") + "images\\" + fileName;
                                File savedFile = new File(realPath);
                                if (!savedFile.exists()) {
                                    item.write(savedFile);
                                }
                            }
                        } catch (Exception e) {
                            log("ERROR at PostController: " + e.getMessage());
                        }
                    }
                }
                String name = (String) params.get("txtName");
                String description = (String) params.get("txtDescription");
                int price = Integer.parseInt((String) params.get("txtPrice"));

                Date createDate = Date.valueOf((String) params.get("txtCreateDate"));

                Date expireDate = Date.valueOf((String) params.get("txtExpireDate"));

                int quantities = Integer.parseInt((String) params.get("txtQuantities"));

                int categoryID = Integer.parseInt((String) params.get("category"));
                CakeBLO blo = new CakeBLO();
                if (fileName.equals("not")) {
                    fileName = "Mooncake.jpg";
                }
                Cake cake = new Cake(name, fileName, description, price, createDate, expireDate, quantities, new Category(categoryID), new Status(1));
                if (blo.createCake(cake)) {
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("ERROR at CreateCakeController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

}
