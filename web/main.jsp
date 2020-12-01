<%-- 
    Document   : main.jsp
    Created on : Oct 10, 2020, 4:57:26 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main Page</title>
        <style>
            label.error{
                color: red;
                display: block;
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
            <div class="container-fluid my-2 m-0">
                <div class="row">
                    <div class="col-4" style="height: 80%;">
                        <div class="row justify-content-center">
                            <div class="col-8 my-5">
                                <form action="search" method="POST">
                                    <div class="input-group my-1">
                                        <div class="input-group-addon">
                                            <span class="input-group-text" id="basic-addon1">Search By Name</span>
                                        </div>
                                        <input type="text" class="form-control" name="txtSearch" value="${requestScope.LASTSEARCH}"/>
                                        <div class="input-group-btn">
                                            <button class="btn btn-outline-success">Search</button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="action" value="1" />
                                </form>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-8 my-5">
                                <form action="search" method="POST" id="searchByCategory">
                                    <div class="input-group">
                                        <input type="hidden" name="action" value="2" />
                                        <div class="input-group-prepend">
                                            <label class="input-group-text">Search by Category</label>
                                        </div>
                                        <select name="category" class="custom-select" onchange="this.form.submit()">
                                            <option value="none" selected disable hidden>Select an option</option>
                                            <c:forEach var="category" items="${sessionScope.CATEGORYLIST}">
                                                <option value="${category.categoryID}"<c:if  test="${requestScope.LASTCATEGORY eq category.categoryID}">
                                                        selected="true" </c:if>>${category.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row justify-content-center my-5">
                            <div class="col-8">
                                <form action="search" method="POST" id="searchByPrice">
                                    <input type="hidden" name="action" value="3" />
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span class="input-group-text" id="basic-addon1">From</span>
                                        </div>
                                        <div style="width: 100%;">
                                            <input type="text" class="form-control" name="fromPrice" value="${requestScope.LASTFROMPRICE}" id="fromPrice"/>
                                        </div>
                                    </div><br/>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span class="input-group-text" id="basic-addon1">To</span>
                                        </div>
                                        <div style="width: 100%;">
                                            <input type="text" class="form-control" name="toPrice" value="${requestScope.LASTTOPRICE}"/>
                                        </div>
                                    </div><br/>
                                    <div class="row justify-content-center">
                                        <button class="btn btn-outline-success align-self-center">Search</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="row col-8">
                        <c:if test="${requestScope.CAKELIST != null}">
                            <c:if test="${not empty requestScope.CAKELIST}" var="isNotEmpty">
                                <c:forEach items="${requestScope.CAKELIST}" var="cake">
                                    <div class="col-2 m-2">
                                        <div class="row">
                                            <span class="border border-success rounded p-2 shadow-sm">
                                                <img src="images/${cake.image}" class="img-fluid"/>
                                                <dl class="list-inline mb-0">
                                                    <dt class="list-inline-item">Name:</dt>
                                                    <dd class="list-inline-item">${cake.cakeName}</dd>
                                                    <dt class="list-inline-item">Description:</dt>
                                                    <dd class="list-inline-item">${cake.description}</dd>
                                                    <dt class="list-inline-item">Price:</dt>
                                                    <dd class="list-inline-item">${cake.price}VND</dd><br/>
                                                    <dt class="list-inline-item">MFG:</dt>
                                                    <dd class="list-inline-item">${cake.createDate}</dd>
                                                    <dt class="list-inline-item">EXP:</dt>
                                                    <dd class="list-inline-item">${cake.expirationDate}</dd>
                                                    <dt class="list-inline-item">Category:</dt>
                                                    <dd class="list-inline-item">${cake.categoryID.categoryName}</dd>
                                                </dl>
                                                <div class="col justify-content-center">
                                                    <c:if test="${sessionScope.USER.role=='Admin'}">
                                                        <div class="row justify-content-center">
                                                            <form action="showCakeDetail" method="POST">
                                                                <input type="hidden" name="cakeID" value="${cake.cakeID}"/>
                                                                <button class="btn btn-outline-success btn-sm">Update</button>
                                                            </form>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${sessionScope.USER.role =='Member' || isGuest}">
                                                        <div class="col">
                                                            <div class="row justify-content-center">
                                                                <form action="addToCart" method="POST">
                                                                    <input type="hidden" name="cakeID" value="${cake.cakeID}" />
                                                                    <button class="btn btn-outline-success btn-sm">Add to Cart</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <c:if test="${!isNotEmpty}">
                            <div class="col-4 text-center m-auto">
                                <label style="color: red;">No Record Found</label>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center my-4">
                <nav aria-label="...">
                    <ul class="pagination pagination-sm">
                        <c:forEach begin="1" end="${sessionScope.TOTALPAGES}" var="pageNo" step="1">
                            <c:if test="${requestScope.ACTION==null}">
                                <c:url var="page" value="showCake">
                                    <c:param name="pageNo" value="${pageNo}"></c:param>
                                </c:url>
                                <li class="page-item"><a class="page-link" href="${page}">${pageNo}</a></li>
                                </c:if>
                                <c:if test="${requestScope.ACTION == '1'}">
                                    <c:url value="search" var="page">
                                        <c:param name="action" value="${requestScope.ACTION}"></c:param>
                                        <c:param name="pageNo" value="${pageNo}"></c:param>
                                        <c:param name="txtSearch" value="${requestScope.LASTSEARCH}"></c:param>
                                    </c:url>
                                <li class="page-item"><a class="page-link" href="${page}">${pageNo}</a></li>
                                </c:if>
                                <c:if test="${requestScope.ACTION == '2'}">
                                    <c:url value="search" var="page">
                                        <c:param name="action" value="${requestScope.ACTION}"></c:param>
                                        <c:param name="pageNo" value="${pageNo}"></c:param>
                                        <c:param name="category" value="${requestScope.LASTCATEGORY}"></c:param>
                                    </c:url>
                                <li class="page-item"><a class="page-link" href="${page}">${pageNo}</a></li>
                                </c:if>
                                <c:if test="${requestScope.ACTION == '3'}">
                                    <c:url value="search" var="page">
                                        <c:param name="action" value="${requestScope.ACTION}"></c:param>
                                        <c:param name="pageNo" value="${pageNo}"></c:param>
                                        <c:param name="fromPrice" value="${requestScope.LASTFROMPRICE}"></c:param>
                                        <c:param name="toPrice" value="${requestScope.LASTTOPRICE}"></c:param>
                                    </c:url>
                                <li class="page-item"><a class="page-link" href="${page}">${pageNo}</a></li>
                                </c:if>
                            </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#searchByPrice").validate({
            rules: {
                fromPrice: {
                    required: true,
                    number: true,
                    min: 0
                },
                toPrice: {
                    required: true,
                    number: true,
                    min: function(){
                        return parseInt($('#fromPrice').val());
                    }
                }
            }
        });
    });
</script>
</html>
