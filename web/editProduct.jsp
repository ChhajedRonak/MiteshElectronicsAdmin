<%-- 
    Document   : editProduct
    Created on : 1 Nov, 2018, 4:13:10 PM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>

        <sql:setDataSource var="categoryDataSource"
                           driver="com.mysql.cj.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/mitesh_electronics?useSSL=false"
                           scope="page"
                           user="root"
                           password="root"/>

        <form action="editingProduct.jsp" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Edit Product</h4></caption>


                <tr><td><label for="product">Select Product</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectProduct">
                            select product_master.product_id, product_master.product_name,product_master.product_imagel, brand_master.brand_name from product_master inner join brand_master on product_master.brand_id= brand_master.brand_id;
                        </sql:query>

                        <select name="product_id">
                            <c:forEach var="row" items="${selectProduct.rows}">
                                <option value="${row.product_id}"><c:out value="${row.brand_name}"/>&nbsp;<c:out value="${row.product_name}"/></option>
                                
                            </c:forEach>

                        </select>

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
