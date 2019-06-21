<%--
    Document   : navigation
    Created on : 1 Nov, 2018, 2:53:08 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
    </head>
    <link href="CSS/miteshStyle.css" rel="stylesheet" type="text/css"/>
    <style>
        body{
            width: 100%;
        }
        header {
            position:fixed;
            height: 85px;
            width: 100%;
            left:0;
            right:0;
            top:0;
            background-image: linear-gradient(#020005, #090979,#00d4ff);
            margin:0;
            clear:both;
            z-index:10;
            padding-top:10px;
            padding-bottom: 10px;
            padding-left:5px;
        }

        header img{
            background:transparent;
            float:left;
            visibility:visible;
            height:80px;
            width:80px;
        }
        header #name {
            font: 30px "Arial";
            display: inline;
            float:left;
            color: white;
            margin-left:10px;
            margin-top: 20px;
        }
        #head h4{
            float:right;
            text-decoration: none;
            color:white;
            vertical-align: middle;
            margin-top: 32px;
            font-family: "Arial"
        }
        #head h4 a{
            text-decoration: none;
            color:white;
            margin-right: 15px;
            vertical-align: middle;
            padding-right: 20px;
        }
    </style>
    <body>
        <!--<h2 align="center">MITESH ELECTRONICS</h2>-->

        <header id="head">
            <img src="logo.png"/>
            <h1 id="name"><strong>MITESH MOBILE & ELECTRONICS</strong></h1>


            <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>

            <h4><a href="${pageContext.servletContext.contextPath}/Logout">Logout</a></h4>
        </header>
        <sql:setDataSource var="categoryDataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/mitesh_electronics?useSSL=false"
                           scope="session"
                           user="root"
                           password="root"/>

        <nav>
            <!--            <caption><h4>Select Operations</h4></caption>-->
            <ul style="list-style-type: none">
                <a href="addCategory.jsp"><li>Add Category</li></a>
                <a href="editCategory.jsp"><li>Edit Category</li></a>
                <a href="deleteCategory.jsp"><li>Delete Category</li></a>
                <a href="addSubCategory.jsp"><li>Add Sub Category</li></a>
                <a href="editSubCategory.jsp"><li>Edit Sub Category</li></a>
                <a href="deleteSubCategory.jsp"><li>Delete Sub Category</li></a>
                <a href="addBrand.jsp"><li>Add Brand</li></a>
                <a href="editBrand.jsp"><li>Edit Brand</li></a>
                <a href="deleteBrand.jsp"><li>Delete Brand</li></a>
                <a href="addProduct.jsp"><li>Add Product</li></a>
                <a href="editProduct.jsp"><li>Edit Product</li></a>
                <a href="deleteProduct.jsp"><li>Delete Product</li></a>
                <a href="viewOrders.jsp?status=N"><li>View Orders</li></a>
            </ul>
        </nav>
        <form action="">

        </form>
        <% } else {%>
    </header>
    <div align="center" style="width:100%;">

        <h2 style="margin-top:170px; width: 100%;"  align="center">You have to <a href="login.jsp" >login</a> first</h2>
    </div>
    <%}%>

</body>
</html>
