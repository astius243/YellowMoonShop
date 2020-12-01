/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.filters;

import huonglh.entities.Account;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hau Huong
 */
public class AuthFilter implements Filter {
    
    private static final boolean debug = true;
    private FilterConfig filterConfig = null;
    
    private final List<String> admin;
    private final List<String> guest;
    private final List<String> member;
    
    public AuthFilter() {
        admin = new ArrayList<>();
        admin.add("insert.jsp");
        admin.add("main.jsp");
        admin.add("update.jsp");
        admin.add("CreateCakeController");
        admin.add("SearchController");
        admin.add("ShowCakeController");
        admin.add("ShowCakeDetailController");
        admin.add("UpdateCakeController");
        admin.add("LogoutController");
        admin.add("createCake");
        admin.add("search");
        admin.add("showCake");
        admin.add("showCakeDetail");
        admin.add("updateCake");
        admin.add("logout");
        
        member = new ArrayList<>();
        member.add("main.jsp");
        member.add("order.jsp");
        member.add("track.jsp");
        member.add("viewCart.jsp");
        member.add("AddToCartController");
        member.add("LogoutController");
        member.add("SearchController");
        member.add("SearchOrderController");
        member.add("ShowCakeController");
        member.add("ShowOrderDetailController");
        member.add("SubmitCartController");
        member.add("TrackOrderController");
        member.add("UpdateCartController");
        member.add("addToCart");
        member.add("logout");
        member.add("search");
        member.add("searchOrder");
        member.add("showCake");
        member.add("showOrderDetail");
        member.add("submitCart");
        member.add("trackOrder");
        member.add("updateCart");
        
        guest = new ArrayList<>();
        guest.add("login.jsp");
        guest.add("main.jsp");
        guest.add("viewCart.jsp");
        guest.add("");
        guest.add("AddToCartController");
        guest.add("LogoutController");
        guest.add("SearchController");
        guest.add("ShowCakeController");
        guest.add("SubmitCartController");
        guest.add("UpdateCartController");
        guest.add("addToCart");
        guest.add("login");
        guest.add("logout");
        guest.add("search");
        guest.add("showCake");
        guest.add("submitCart");
        guest.add("updateCart");
        guest.add("''");
    }
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String uri = req.getRequestURI();
        int index = uri.lastIndexOf("/");
        String[] resources = uri.substring(index + 1).split(";");
        String resource = resources[0];
        HttpSession session = req.getSession();
        System.out.println(resource);
        System.out.println((Account) session.getAttribute("USER"));
        if (uri.endsWith("css") || uri.endsWith("jpg") || uri.endsWith("JPG") || uri.endsWith("js")) {
            chain.doFilter(request, response);
            return;
        }
        if (session == null || session.getAttribute("USER") == null) {
            if (resource.equals("login") || resource.equals("showCake") || resource.equals("logout") || resource.equals("login.jsp")) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect("login.jsp");
            }
        } else {
            Account acc = (Account) session.getAttribute("USER");
            if (acc.getRole().equals("Admin")) {
                if (admin.contains(resource)) {
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect("showCake");
                }
            } else if (acc.getRole().equals("Member")) {
                if (member.contains(resource)) {
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect("showCake");
                }
            } else if (acc.getRole().equals("Guest")) {
                if (guest.contains(resource)) {
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect("showCake");
                }
            }
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
    
}
