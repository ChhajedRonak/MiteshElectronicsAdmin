<%-- 
    Document   : editSubCategory
    Created on : 1 Nov, 2018, 10:04:14 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
       <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <body>
         <jsp:include page="navigation.jsp"/>
    <% if ((session.getAttribute("isLogin")!=null)&&(session.getAttribute("isLogin").equals("true"))){%>
        <form action="EditSubCategory" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Edit Sub Category</h4></caption>
                <tr><td><label for="sub_category_id">Select Sub Category to edit</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectSubCategory">
                            select * from sub_category_master
                        </sql:query>
                        <select name="sub_category_id">
                            <c:forEach var="row" items="${selectSubCategory.rows}">
                                <option value="${row.sub_category_id}"><c:out value="${row.sub_category_name}"/></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr><td><label for="category_id">Select New Category</label></td>
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
                    <td><label for="new_name">Enter new Sub Category</label></td>
                    <td>
                        <input type="text" name="new_name">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update"/></td>
                </tr>
            </table>
        </form>
         <% }%>
    </body>
</html>
