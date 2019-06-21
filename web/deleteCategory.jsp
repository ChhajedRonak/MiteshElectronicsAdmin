<%-- 
    Document   : deleteCategory
    Created on : 1 Nov, 2018, 4:38:25 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Category </title>
    </head>
    <body>
     <jsp:include page="navigation.jsp"/>
 <% if ((session.getAttribute("isLogin")!=null)&&(session.getAttribute("isLogin").equals("true"))){%>
       

        <form action="DeleteCategory" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Delete Category</h4></caption>
                <tr><td><label for="category_id">Select Category</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectCategory">
                            select * from category_master
                        </sql:query>
                        <select name="category_id">
                            <c:forEach var="row" items="${selectCategory.rows}">
                                <option value="${row.category_id}"><c:out value="${row.category_name}"/></option>
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
