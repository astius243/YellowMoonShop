/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.controllers;

import huonglh.blos.CakeBLO;
import huonglh.entities.Account;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hau Huong
 */
public class ShowCakeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            CakeBLO blo = new CakeBLO();

            int pageSize = 20;
            int pageNo;
            String pageNumber = (String) request.getParameter("pageNo");
            if (pageNumber == null) {
                pageNo = 1;
            } else {
                pageNo = Integer.parseInt(pageNumber);
            }

            long totalPages;
            long count = blo.getCountCake();
            if (count % pageSize == 0) {
                totalPages = count / pageSize;
            } else {
                totalPages = (count / pageSize) + 1;
            }
            List cakeList = blo.showCake(pageNo, pageSize);

            request.setAttribute("CAKELIST", cakeList);
            session.setAttribute("TOTALPAGES", totalPages);

            Account acc = (Account) session.getAttribute("USER");
            if (acc == null) {
                acc = new Account("guest");
                acc.setRole("Guest");
                session.setAttribute("USER", acc);
            }
        } catch (Exception e) {
            log("ERROR at ShowCakeController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("main.jsp").forward(request, response);
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
