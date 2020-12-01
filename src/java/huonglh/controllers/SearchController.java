package huonglh.controllers;

import huonglh.blos.CakeBLO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "main.jsp";
        try {
            HttpSession session = request.getSession();
            int action = Integer.parseInt(request.getParameter("action"));
            String pageNumber = request.getParameter("pageNo");
            CakeBLO blo = new CakeBLO();
            int pageNo;
            int pageSize = 10;
            List cakeList = null;
            long totalPages = 0;
            switch (action) {
                case 1:
                    String search = request.getParameter("txtSearch");
                    if (search.length() > 0) {
                        if (pageNumber == null) {
                            pageNo = 1;
                        } else {
                            pageNo = Integer.parseInt(pageNumber);
                        }
                        cakeList = blo.findCakeByLikeName(search, pageNo, pageSize);
                        long count = blo.countCakeByLikeName(search);
                        if (count % pageSize == 0) {
                            totalPages = count / pageSize;
                        } else {
                            totalPages = (count / pageSize) + 1;
                        }
                        request.setAttribute("LASTSEARCH", search);
                    } else {
                        session.removeAttribute("TOTALPAGES");
                        url = "ShowCakeController";
                    }
                    break;
                case 2:
                    int categoryID = Integer.parseInt(request.getParameter("category"));
                    if (pageNumber == null) {
                        pageNo = 1;
                    } else {
                        pageNo = Integer.parseInt(pageNumber);
                    }
                    cakeList = blo.findCakeByCategory(categoryID, pageNo, pageSize);
                    long count = blo.countCakeByCategory(categoryID);
                    if (count % pageSize == 0) {
                        totalPages = count / pageSize;
                    } else {
                        totalPages = (count / pageSize) + 1;
                    }
                    request.setAttribute("LASTCATEGORY", categoryID);
                    break;
                case 3:
                    String fromPrice = request.getParameter("fromPrice");
                    String toPrice = request.getParameter("toPrice");
                    if (pageNumber == null) {
                        pageNo = 1;
                    } else {
                        pageNo = Integer.parseInt(pageNumber);
                    }
                    cakeList = blo.findCakeByPrice(Integer.parseInt(fromPrice), Integer.parseInt(toPrice), pageNo, pageSize);
                    count = blo.countCakeByPrice(Integer.parseInt(fromPrice), Integer.parseInt(toPrice), pageNo, pageSize);
                    if (count % pageSize == 0) {
                        totalPages = count / pageSize;
                    } else {
                        totalPages = (count / pageSize) + 1;
                    }
                    request.setAttribute("LASTFROMPRICE", fromPrice);
                    request.setAttribute("LASTTOPRICE", toPrice);
                    break;
            };
            request.setAttribute("ACTION", action);
            request.setAttribute("CAKELIST", cakeList);
            session.setAttribute("TOTALPAGES", totalPages);
        } catch (Exception e) {
            log("ERROR at SearchController: " + e.getMessage());
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
