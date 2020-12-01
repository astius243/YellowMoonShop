<%-- 
    Document   : order
    Created on : Oct 13, 2020, 8:53:34 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail Page</title>
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
            <div class="mt-5">
                <div class="d-flex justify-content-center align-content-center flex-column row" style="height: 75vh;">
                    <div class="card bg-light m-auto p-2" style="width: 80%; height: 85%;">
                        <dl class="list-inline">
                            <dt class="list-inline-item">Name:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.fullname}</dd><br/>
                            <dt class="list-inline-item">Phone:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.phone}</dd><br/>
                            <dt class="list-inline-item">Shipping Address:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.shippingAddress}</dd><br/>
                            <dt class="list-inline-item">Payment Method:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.paymentMethod}</dd><br/>
                            <dt class="list-inline-item">Payment Status:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.paymentStatus}</dd><br/>
                            <dt class="list-inline-item">Date:</dt>
                            <dd class="list-inline-item">${requestScope.ORDER.date}</dd><br/>
                        </dl>
                        <c:if test="${requestScope.DETAILS!=null}" var="isNotNull">
                            <c:if test="${not empty requestScope.DETAILS}" >
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.DETAILS}" var="detail" varStatus="count">
                                            <tr>
                                                <th scope="row">${count.count}</th>
                                                <td>${detail.cakeID.cakeName}</td>
                                                <td>${detail.price}</td>
                                                <td>${detail.quantities}</td>
                                                <td>${detail.quantities * detail.price}</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="4" style="text-align: right;">Total</td>
                                            <td>${requestScope.ORDER.total}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
