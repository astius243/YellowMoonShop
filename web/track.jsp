<%-- 
    Document   : track
    Created on : Oct 13, 2020, 7:54:06 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tracking Order Page</title>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container-fluid p-0 mr-0 ml-0">
            <nav class="navbar navbar-expand navbar-light bg-light m-0">
                <a class="navbar-brand" href="showCake">Yellow Moon Shop</a>
                <div class="col align-self-end">
                    <ul class="navbar-nav justify-content-end">
                        <li class="nav-item dropdown dropleft">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <c:if test="${sessionScope.USER.role == 'Guest'}" var="isGuest">Guest</c:if>
                                <c:if test="${!isGuest}">${sessionScope.USER.name}</c:if>
                                </a>
                            <c:if test="${sessionScope.USER.role != 'Admin' || isGuest}" var="notAdmin">
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <c:if test="${sessionScope.USER.role == 'Member'}">
                                        <a class="dropdown-item" href="trackOrder">Track Order</a>
                                    </c:if>
                                    <a class="dropdown-item" href="viewCart.jsp">View Your Cart</a>
                                    <a class="dropdown-item" href="logout">Log Out</a>
                                </div>
                            </c:if>
                            <c:if test="${!notAdmin}">
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="insert.jsp">Create a new Cake</a>
                                    <a class="dropdown-item" href="logout">Log out</a>
                                </div>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="row my-2 justify-content-center"> 
                <div class="col-8">
                    <form action="searchOrder" method="POST">
                        <div class="input-group my-1">
                            <div class="input-group-addon">
                                <span class="input-group-text" id="basic-addon1">Search By Order ID</span>
                            </div>
                            <input type="text" class="form-control" name="txtSearchID" value="${requestScope.LASTSEARCH}"/>
                            <div class="input-group-btn">
                                <button class="btn btn-outline-success">Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="container-fluid my-2 m-0">
                <div class="row justify-content-center">
                    <c:if test="${requestScope.LASTSEARCH == null}">
                        <c:if test="${requestScope.LISTORDERS != null}" var="isNotNull">
                            <c:if test="${not empty requestScope.LISTORDERS}">
                                <table class="table text-center rounded">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Total</th>
                                            <th scope="col">Date</th>
                                            <th scope="col">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <c:forEach var="order" items="${requestScope.LISTORDERS}">
                                        <form action="showOrderDetail" method="POST">
                                            <th scope="row">${order.orderID}</th>
                                            <td>${order.fullname}</td>
                                            <td>${order.total}</td>
                                            <td>${order.date}</td>
                                            <input type="hidden" name="orderID" value="${order.orderID}" />
                                            <td>
                                                <button class="btn btn-outline-success">Show Detail</button>
                                            </td>
                                        </form>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:if>
                        <c:if test="${!isNotNull}">
                            <div class="col-4 justify-content-center text-center" style="color: red;">
                                No Order to track
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${requestScope.LASTSEARCH != null}">
                        <c:if test="${requestScope.ORDER != null}" var="order">
                            <table class="table text-center rounded">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Total</th>
                                        <th scope="col">Date</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                <form action="showOrderDetail" method="POST">
                                    <th scope="row">${requestScope.ORDER.orderID}</th>
                                    <td>${requestScope.ORDER.fullname}</td>
                                    <td>${requestScope.ORDER.total}</td>
                                    <td>${requestScope.ORDER.date}</td>
                                    <input type="hidden" name="orderID" value="${requestScope.ORDER.orderID}" />
                                    <td>
                                        <button class="btn btn-outline-success">Show Detail</button>
                                    </td>
                                </form>
                                </tr>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${!order}">
                            <div class="col-4 justify-content-center text-center" style="color: red;">
                                Order not Found
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
