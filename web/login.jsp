<%-- 
    Document   : loginPage
    Created on : Oct 10, 2020, 4:09:04 PM
    Author     : Hau Huong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center align-content-center flex-column row" style="height: 100vh;">
                <div class="card bg-light m-auto" style="width: 80%; height: 45%;">
                    <div class="row justify-content-center page-header mt-4">
                        <h1>Login Page</h1>
                    </div>
                    <div class="card-body mb-3">
                        <form action="login" method="POST">
                            <div class="input-group my-2">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Username</span>
                                </div>
                                <input type="text" class="form-control" name="txtUsername" value="" required="true"/>
                            </div><br/>
                            <div class="input-group my-2">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon1">Password</span>
                                </div>
                                <input type="password" class="form-control" name="txtPassword" value="" required="true"/>
                            </div><br/>
                            <div class="row justify-content-center">
                                <button class="btn btn-outline-success" value="Login" name="login">Log in</button>
                            </div>
                        </form>
                        <div class="row justify-content-center mt-4">
                            <a href="showCake">Shopping without login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <c:if test="${not empty requestScope.FAILED}">
        <script>
            window.addEventListener("load", function () {
                alert("${requestScope.FAILED}");
            });
        </script>
    </c:if>
</html>
