<%-- 
    Document   : addSubCategory
    Created on : 1 Nov, 2018, 9:43:08 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Sub Category</title>
    </head>
    <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <body>
          <jsp:include page="navigation.jsp"/>
         <sql:setDataSource var="categoryDataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/mitesh_electronics?useSSL=false"
                           scope="page"
                           user="root"
                           password="root"/>
       
        <% if ((session.getAttribute("isLogin")!=null)&&(session.getAttribute("isLogin").equals("true"))){%>
        <form action="AddSubCategory" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Add Sub Category</h4></caption>          
                <tr>
                    <td>
                      <label for="category_id">Select Category</label>
                    </td>
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
                <tr><td><label for="sub_category">Sub Category:</label></td>
                    <td><input type="text" name="sub_category" required/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Add"/></td>
                </tr>
            </table>
        </form>
        <% }%>
    </body>
</html>
