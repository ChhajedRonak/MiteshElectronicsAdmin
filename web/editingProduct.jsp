<%-- 
    Document   : editingProduct
    Created on : 16 Nov, 2018, 9:49:30 PM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editing Product</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    </head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
        <jsp:include page="navigation.jsp"/>
        <body style="margin-top: 100px;">

        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>

        <c:set var="product_id" value="${param.product_id}"/>
        <sql:query dataSource="${categoryDataSource}"
                   var="selectProduct">
            select * from product_master where product_id=${product_id};
        </sql:query>
        <c:forEach var="rowProduct" items="${selectProduct.rows}">

            <form action="EditProduct" method="post" enctype="multipart/form-data">
                <table align="center" cellpadding="10">
                    <caption><h4>Edit product</h4></caption>
                    <input type="hidden" name="product_id" value="${product_id}"/>
                    <tr><td><label for="category_id">Select Category</label></td>
                        <td>
                            <sql:query dataSource="${categoryDataSource}"
                                       var="selectCategory">
                                select * from category_master
                            </sql:query>
                            <select name="category_id" >
                                <c:forEach var="row" items="${selectCategory.rows}">
                                    <option value="${row.category_id}" <c:if test="${rowProduct.category_id == row.category_id}">selected</c:if> ><c:out value="${row.category_name}"/></option>
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
                                    <option value="${row.sub_category_id}" <c:if test="${rowProduct.sub_category_id == row.sub_category_id}">selected</c:if> ><c:out value="${row.sub_category_name}"/></option>
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
                                    <option value="${row.brand_id}" <c:if test="${rowProduct.brand_id == row.brand_id}">selected</c:if>><c:out value="${row.brand_name}"/></option>
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
                            <input type="text" name="product_name" required value="${rowProduct.product_name}">
                        </td>
                    </tr>
                    <tr>        
                        <td><label for="description">Description:</label></td>
                        <td>
                            <textarea name="description" cols="35" rows="5"  required>${rowProduct.description}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="price">Price</label>
                        </td>
                        <td>
                            <input type="number" name="price" required value="${rowProduct.price}">
                        </td>
                    </tr>
                    <tr>
                        <td><label for="image">Browse Image</label></td>
                        <td>
                            <input id="browse_image" type="file" name="image" >

                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <img src="${pageContext.servletContext.contextPath }/ImageServlet?id=${product_id}" height="200" id="imageview"/>
                                
                        </td>
                    </tr>
                    <tr>
                        <td><label for="quantity">Quantity in stock</label></td>
                        <td>
                            <input type="number" name="quantity" value="${rowProduct.in_stock}"> 
                        </td>                  
                    </tr>
                    <tr>
                        <td><label for="category_discount">Category Discount</label></td>
                        <td>
                            <input type="number" name="category_discount" value="${rowProduct.category_discount}">
                        </td>                  
                    </tr>
                    <tr>
                        <td><label for="brand_discount">Brand Discount</label></td>
                        <td>
                            <input type="number" name="brand_discount" value="${rowProduct.brand_discount}">
                        </td>                  
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Edit"/></td>
                    </tr>
                </table>
            </form>
        </c:forEach>
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
