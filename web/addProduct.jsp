<%--
    Document   : addProduct
    Created on : 1 Nov, 2018, 12:16:24 PM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Product</title>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>

        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>
        <form action="AddProduct" method="post" enctype="multipart/form-data">
            <table align="center" cellpadding="10">
                <caption><h4>Add new product</h4></caption>

                <tr><td><label for="category_id">Select Category</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectCategory">
                            select * from category_master
                        </sql:query>
                        <select name="category_id" >
                            <c:forEach var="row" items="${selectCategory.rows}">
                                <option value="${row.category_id}"><c:out value="${row.category_name}"/></option>
                            </c:forEach>
                        </select>
                        &nbsp; or &nbsp;  <a href="addCategory.jsp">Add a new category</a>

                    </td>
                </tr>
                <tr><td><label for="category_id">Select Sub Category</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectCategory">
                            select * from sub_category_master
                        </sql:query>
                        <select name="sub_category_id">
                            <c:forEach var="row" items="${selectCategory.rows}">
                                <option value="${row.sub_category_id}"><c:out value="${row.sub_category_name}"/></option>
                            </c:forEach>
                        </select>
                        &nbsp; or &nbsp; <a href="addSubCategory.jsp">Add a new sub category</a>
                    </td>
                </tr>

                <tr><td><label for="brand_id">Select Brand</label></td>
                    <td>
                        <sql:query dataSource="${categoryDataSource}"
                                   var="selectBrand">
                            select * from brand_master
                        </sql:query>
                        <select name="brand_id" required>
                            <c:forEach var="row" items="${selectBrand.rows}">
                                <option value="${row.brand_id}"><c:out value="${row.brand_name}"/></option>
                            </c:forEach>
                        </select>
                        &nbsp; or &nbsp; <a href="addBrand.jsp">Add a new brand</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="product_name">Product Name</label>
                    </td>
                    <td>
                        <input type="text" name="product_name" required>
                    </td>
                </tr>
                <tr>
                    <td><label for="description">Description:</label></td>
                    <td>
                        <textarea name="description" required ></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="price">Price</label>
                    </td>
                    <td>
                        <input type="number" name="price" required>
                    </td>
                </tr>
                <tr>
                    <td><label for="image">Select Image</label></td>
                    <td>
                        <input type="file" id="browse_image" name="image">
                    </td>

                </tr>
                <tr>
                    <td>

                    </td>
                    <td>
                        <img src="" height="200" id="imageview"/>
                    </td>
                </tr>
                <tr>
                    <td><label for="quantity">Enter quantity in stock</label></td>
                    <td>
                        <input type="number" name="quantity">
                    </td>
                </tr>
                <tr>
                    <td><label for="discount">Enter Discount</label></td>
                    <td>
                        <input type="number" name="discount">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Add"/></td>
                </tr>
            </table>
        </form>
        <% }%>
        <script type="text/javascript">
            document.getElementById("browse_image").onchange = function () {
                var reader = new FileReader();

                reader.onload = function (e) {
                    // get loaded data and render thumbnail.
                    document.getElementById("imageview").src = e.target.result;
                };

                // read the image file as a data URL.
                reader.readAsDataURL(this.files[0]);
            };
        </script>
    </body>
</html>
