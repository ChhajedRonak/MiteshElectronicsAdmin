<%-- 
    Document   : editBrand
    Created on : 1 Nov, 2018, 11:17:34 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Brand</title>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>

    <sql:setDataSource var="categoryDataSource"
                       driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/mitesh_electronics?useSSL=false"
                       scope="page"
                       user="root"
                       password="root"/>

    <form action="EditBrand" method="post">
        <table align="center" cellpadding="10">
            <caption><h4>Edit Brand</h4></caption>
            <tr><td><label for="brand">Select Category</label></td>
                <td>
            <sql:query dataSource="${categoryDataSource}"
                       var="selectBrand">
                select * from brand_master;
            </sql:query>
            <select name="brand_id">
                <c:forEach var="row" items="${selectBrand.rows}">
                    <option value="${row.brand_id}"><c:out value="${row.brand_name}"/></option>
                </c:forEach>

            </select>

            </td>
            </tr>
            <tr>
                <td><label for="new_name">Enter new name</label></td>
                <td>
                    <input type="text" name="new_name">
                </td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Edit"/></td>
            </tr>
        </table>
    </form>
    <% }%>
</body>
</html>
