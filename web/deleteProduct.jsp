<%-- 
    Document   : deleteProduct
    Created on : 1 Nov, 2018, 3:13:57 PM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Product</title>
    </head>
    <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <body>
        <jsp:include page="navigation.jsp"/>
 <% if ((session.getAttribute("isLogin")!=null)&&(session.getAttribute("isLogin").equals("true"))){%>
       

        <form action="DeleteProduct" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Delete Product</h4></caption>
                <tr><td><label for="product">Select Product Name</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectProduct">
                            select * from product_master
                        </sql:query>
                        <select name="product">
                            <c:forEach var="row" items="${selectProduct.rows}">
                                <option value="${row.product_id}"><c:out value="${row.product_name}"/></option>
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
