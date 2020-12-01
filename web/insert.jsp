<%-- 
    Document   : insert
    Created on : Oct 11, 2020, 1:27:07 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Cake Page</title>
        <style>
            label.error{
                color: red;
            }
        </style>
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
                                <c:if test="${sessionScope.USER == null}" var="isGuest"> Guest </c:if>
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
                    <div class="card bg-light m-auto p-2" style="width: 80%; height: 90%;">
                        <div class="row justify-content-center page-header mt-2">
                            <h1>Create Cake</h1>
                        </div>
                        <form method="POST" action="createCake" id="createForm" 
                              enctype="multipart/form-data">
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Cake Name</span>
                                </div>
                                <input type="text" class="form-control" name="txtName" value=""/>
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Description</span>
                                </div>
                                <input type="text" class="form-control" name="txtDescription" value="" />
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Price</span>
                                </div>
                                <input type="number" class="form-control" name="txtPrice" value="" />
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Quantity</span>
                                </div>
                                <input type="number" class="form-control" name="txtQuantities" value=""/>
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Create date</span>
                                </div>
                                <input type="date" class="form-control" name="txtCreateDate" value="" id="createDate"/>
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Expire Date</span>
                                </div>
                                <input type="date" class="form-control" name="txtExpireDate" value=""/>
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-prepend">
                                    <label class="input-group-text">Category</label>
                                </div>
                                <select name="category" class="custom-select">
                                    <c:forEach var="category" items="${sessionScope.CATEGORYLIST}">
                                        <option value="${category.categoryID}">${category.categoryName}</option>
                                    </c:forEach>
                                </select><br/>
                            </div>
                            <div class="input-group my-3">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">File</span>
                                </div>
                                <input type="file" class="form-control" name="fileUp" value="" accept="image/*"/>
                            </div>
                            <div class="row justify-content-center">
                                <button class="btn btn-outline-success">Create</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#createForm").validate({
                rules: {
                    txtName: {
                        required: true
                    },
                    txtDescription: {
                        required: true
                    },
                    txtPrice: {
                        required: true,
                        min: 1000
                    },
                    txtQuantities: {
                        required: true,
                        min: 1
                    },
                    txtCreateDate: {
                        required: true
                    },
                    txtExpireDate: {
                        greaterThan: "#createDate",
                        required: true
                    }
                }
            });
        });
    </script>
</html>
