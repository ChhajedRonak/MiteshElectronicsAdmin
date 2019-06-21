<%-- 
    Document   : deleteBrand
    Created on : 1 Nov, 2018, 11:42:44 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Brand</title>
    </head>
    <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <body>  
        <jsp:include page="navigation.jsp"/>
        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>


        <form action="DeleteBrand" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Delete Brand</h4></caption>
                <tr><td><label for="brand_id">Select Category</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectBrand">
                            select * from brand_master
                        </sql:query>
                        <select name="brand_id">
                            <c:forEach var="row" items="${selectBrand.rows}">
                                <option value="${row.brand_id}"><c:out value="${row.brand_name}"/></option>
                            </c:forEach>

                        </select>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Delete"/></td>
                </tr>
            </table>
        </form>
        <% }%>
    </body>
</html>
