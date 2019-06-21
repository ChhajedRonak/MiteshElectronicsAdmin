<%--
    Document   : addBrand
    Created on : 1 Nov, 2018, 11:10:20 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Brand</title>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>

        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>
        <form action="AddBrand" method="post">
            <table align="center" cellpadding="10">
                <caption><h4>Add Brand</h4></caption>
                <tr><td><label for="brand">Brand Name: </label></td>
                    <td><input type="text" name="brand" required/></td>
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
