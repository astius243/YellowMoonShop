/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.controllers;

import huonglh.blos.CakeBLO;
import huonglh.blos.OrderBLO;
import huonglh.entities.Account;
import huonglh.entities.Cake;
import huonglh.entities.OrderDetail;
import huonglh.entities.Orders;
import huonglh.models.ShoppingCart;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hau Huong
 */
public class SubmitCartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            ArrayList listOrder = null;
            ArrayList listCake = null;
            Cake cake = null;
            String fullname = request.getParameter("txtFullname");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String paymentMethod = "Cash";
            String total = request.getParameter("total");
            HttpSession session = request.getSession();
            ShoppingCart cart = (ShoppingCart) session.getAttribute("CART");
            Account acc = (Account) session.getAttribute("USER");
            if (acc == null) {
                acc = new Account("guest");
            }
            if (cart != null) {
                listOrder = new ArrayList<>();
                listCake = new ArrayList();
                OrderDetail detail = null;
                Orders order = new Orders(null, fullname, phone, address, paymentMethod, "Paid",
                        Integer.parseInt(total), new Date(), acc);
                for (Map.Entry<Integer, OrderDetail> entry : cart.getCart().entrySet()) {
                    detail = new OrderDetail(null, entry.getValue().getCakeID().getPrice(),
                            entry.getValue().getQuantities(), entry.getValue().getCakeID(), order);
                    listOrder.add(detail);
                    cake = entry.getValue().getCakeID();
                    cake.setQuantities(cake.getQuantities()-entry.getValue().getQuantities());
                    listCake.add(cake);
                }
                order.setOrderDetailCollection(listOrder);
                OrderBLO orderBLO = new OrderBLO();
                orderBLO.addOrder(order);
                CakeBLO cakeBLO = new CakeBLO();
                cakeBLO.updateQuantities(listCake);
                session.removeAttribute("CART");
            }
        } catch (Exception e) {
            log("ERROR at SubmitCartController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("ShowCakeController").forward(request, response);
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
