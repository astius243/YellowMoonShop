<%-- 
    Document   : viewCart
    Created on : Oct 12, 2020, 9:31:27 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
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
                                <c:if test="${sessionScope.USER == null || sessionScope.USER.role == 'Guest'}" var="isGuest"> Guest </c:if>
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
                        <c:if test="${sessionScope.CART!=null}" var="isNotNull">
                            <c:if test="${sessionScope.CART.cart.size()>0}" var="isNotEmpty">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
                                            <th scope="col">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.CART.cart}" var="entry" varStatus="count">
                                        <form action="updateCart" method="POST" id="updateForm">
                                            <tr>
                                                <td>${count.count}</td>
                                                <td>${entry.value.cakeID.cakeName}</td>
                                                <td>${entry.value.cakeID.price}</td>
                                                <td><input type="number" name="txtQuantities" value="${entry.value.quantities}" min="${1}" max="${entry.value.cakeID.quantities}"/> </td>
                                                <td>${entry.value.cakeID.price * entry.value.quantities}</td>
                                                <td>
                                                    <input type="hidden" name="cakeID" value="${entry.value.cakeID.cakeID}" />
                                                    <button class="btn btn-outline-success" name="action" value="Update">Update</button>
                                                    <button class="btn btn-outline-success" name="action" value="Remove" id="removeCake">Remove</button>
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="4" class="text-right">Total</td>
                                        <td>${sessionScope.CART.total}</td>
                                        <td><button class="btn btn-outline-success"onclick="openForm()">Confirm</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if test="${!isNotEmpty}">
                                <div class="row justify-content-center m-auto">
                                    <div class="col-12 text-center">
                                        <label style="color: red;">Your cart is empty</label>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${!isNotNull}">
                            <div class="row justify-content-center m-auto">
                                <div class="col-12 text-center">
                                    <label style="color: red;">Your cart is empty</label>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-popup" id="myForm">
            <form action="submitCart" class="form-container">
                <h1>Input information</h1>

                <label for="email"><b>Full Name</b></label>
                <input type="text" placeholder="Enter Name" name="txtFullname" required>

                <label for="psw"><b>Phone</b></label>
                <input type="text" placeholder="Enter Phone" name="txtPhone" required>

                <label for="email"><b>Shipping Address</b></label>
                <input type="text" placeholder="Enter Name" name="txtAddress" required>

                <input type="hidden" name="total" value="${sessionScope.CART.total}" />

                <button type="submit" class="btn">Submit</button>
            </form>
        </div>
    </body>
    <script>
        function openForm() {
            document.getElementById("myForm").style.display = "block";
        }
        $(document).ready(function () {
            $("#removeCake").click(function (event) {
                if (!confirm("Do you want to delete this cake")) {
                    event.preventDefault();
                }
            });
        });
    </script>
</html>
