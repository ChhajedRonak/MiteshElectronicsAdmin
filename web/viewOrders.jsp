<%--
    Document   : viewOrders
    Created on : 13 Jun, 2019, 4:34:11 PM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
    </head>
    <link href="CSS/miteshStyle.css" rel="stylesheet" type="text/css"/>
    <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <script>
        function confirmDelivery(o_id) {
            var result = confirm("Do you want to mark this order as delivered ? ");
            if (result === true) {
                window.location.href = "Delivered?oid=" + o_id;
            } else {
                document.getElementById(checkDeliver).checked = false;
            }
        }

    </script>
    <body>
        <jsp:include page="navigation.jsp"/>
        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>

        <sql:setDataSource var="viewOrderDataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/mitesh_electronics?useSSL=false"
                           scope="page"
                           user="root"
                           password="root"/>





        <form align="center" style="margin-left: 300px;" action="#">
            <div style="margin-left: -30px;padding-top:20px;vertical-align: top;">
                <input type="radio" id="radio_D" name="status" onclick="window.location.href = 'viewOrders.jsp?status=D'" value="D">
                <label for="radio_D">Delivered </label>
                <input type="radio" id="radio_N" name="status" onclick="window.location.href = 'viewOrders.jsp?status=N'" value="N">
                <label for="radio_N">Not Delivered </label>
                <input type="radio" id="radio_A" name="status" onclick="window.location.href = 'viewOrders.jsp?status=All'" value="All">
                <label for="radio_A">All Orders </label>
            </div>

            <c:set var="o_status" value="<%=request.getParameter("status")%>" scope="page"/>
            <c:choose >
                <c:when test="${o_status == 'All'}" >
                    <!--Order Master SQL Query-->
                    <sql:query dataSource="${viewOrderDataSource}"
                               var="selectOrderMaster">
                        select o.order_id, o.date_time,o.is_delivered, c.first_name,c.last_name,c.contact_no,c.address_line1,c.address_line_2,c.address_line_3,c.pincode from order_master o inner join customer_master c on o.customer_id = c.customer_id;
                    </sql:query>

                    <br><h4 style="font-size: 20px;margin-left: -30px;">All Orders</h4>
                    <c:forEach var="row" items="${selectOrderMaster.rows}">
                        <fieldset align="left" style="margin-bottom:20px;width:90%;">
                            <legend><b>Order ID:${row.order_id}</b></legend>
                            <table align='left' width="100%" cellpadding="4"cellspacing="0" border="0">
                                <tr>
                                    <td colspan="3"><b>Date of Order:</b> <fmt:formatDate  value="${row.date_time}" type="both" pattern="d/M/y h:m:s a" dateStyle="short" timeStyle="medium" /></td>
                                    <td align="right" style="font-family: arial;font-size: 20px;font-weight: bolder;" >
                                        <c:choose>
                                            <c:when test="${row.is_delivered == 'D'}">
                                                <input type="checkbox" checked="true" disabled="true" id="checkDeliver" ><a style="color: #00b100;" id="btn_deliver">Delivered</a>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" style="cursor:pointer" id="checkDeliver"  onclick="confirmDelivery(${row.order_id})"><a onclick="confirmDelivery(${row.order_id})" style="color: #00b100;cursor: pointer;" id="btn_deliver">is Delivered?</a>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3"><b>Name:</b> <c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/> </td>
                                    <td align="right" colspan="1"><b>Contact No:</b> <u>+91-<c:out value="${row.contact_no}"/></u></td>
                                </tr>
                                <tr style="border-bottom:1px solid #0556ac;">
                                    <td colspan="3"><b>Address:</b> ${row.address_line1}, &nbsp; ${row.address_line_2}, &nbsp; ${row.address_line_3} </td>
                                    <td align="right" ><b>PIN Code:</b>${row.pincode} <br></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center" style="font-family: arial; font-size: 17px;color:darkblue;  "><b>Order Details</b></td>
                                </tr>
                                <!--Order Detail SQL Query-->
                                <sql:query var="selectOrderDetail" dataSource="${viewOrderDataSource}" >
                                    select p.product_id,p.product_name, p.image_name, o.quantity,o.price from product_master p inner join order_detail o on p.product_id = o.product_id where o.order_id =${row.order_id};
                                </sql:query>
                                <c:set var="order_total" value="0"/>

                                <c:forEach items="${selectOrderDetail.rows}" var="row_od">
                                    <tr style="border-bottom-style:solid;">
                                        <td align="center"><img style="height:130px" src="${pageContext.servletContext.contextPath}/ImageServlet?id=${row_od.product_id}" alt="${row_od.image_name}"/></td>
                                        <td valign="top"><b>${row_od.product_name}<br>₹${row_od.price}</b></td>
                                        <td valign="top"><b>Quantity: ${row_od.quantity}</b></td>
                                        <td valign="top" align="center"><b>Total Amount: ₹${row_od.quantity * row_od.price}</b></td>
                                    </tr>
                                    <c:set var="order_total" value="${order_total+(row_od.quantity * row_od.price)}"/>
                                </c:forEach>
                                <tr >
                                    <td colspan="3"></td>
                                    <td align="center"><b>Order Total: ₹${order_total}</b></td>
                                </tr>
                            </table>
                        </fieldset>
                    </c:forEach>
                </c:when>
                <c:when test="${o_status eq 'D'}">

                    <!--Order Master SQL Query-->
                    <sql:query dataSource="${viewOrderDataSource}"
                               var="selectOrderMaster">
                        select o.order_id, o.date_time, c.first_name,c.last_name,c.contact_no,c.address_line1,c.address_line_2,c.address_line_3,c.pincode from order_master o inner join customer_master c on o.customer_id = c.customer_id where is_delivered='D';
                    </sql:query>

                    <br><h4 style="font-size: 20px;margin-left: -30px;">Orders Delivered</h4>
                    <c:forEach var="row" items="${selectOrderMaster.rows}">
                        <fieldset align="left" style="margin-bottom:20px;width:90%;">
                            <legend><b>Order ID:${row.order_id}</b></legend>
                            <table align='left' width="100%" cellpadding="4"cellspacing="0" border="0">
                                <tr>
                                    <td colspan="3"><b>Date of Order:</b> <fmt:formatDate  value="${row.date_time}" type="both" pattern="d/M/y h:m:s a" dateStyle="short" timeStyle="medium" /></td>
                                    <td align="right" style="font-family: arial;font-size: 20px;font-weight: bolder;" >
                                        <input type="checkbox" checked="true" disabled="true" id="checkDeliver" ><a style="color: #00b100;" id="btn_deliver">Delivered</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3"><b>Name:</b> <c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/> </td>
                                    <td align="right" colspan="1"><b>Contact No:</b> <u>+91-<c:out value="${row.contact_no}"/></u></td>
                                </tr>
                                <tr style="border-bottom:1px solid #0556ac;">
                                    <td colspan="3"><b>Address:</b> ${row.address_line1}, &nbsp; ${row.address_line_2}, &nbsp; ${row.address_line_3} </td>
                                    <td align="right" ><b>PIN Code:</b>${row.pincode} <br></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center" style="font-family: arial; font-size: 17px;color:darkblue;  "><b>Order Details</b></td>
                                </tr>
                                <!--Order Detail SQL Query-->
                                <sql:query var="selectOrderDetail" dataSource="${viewOrderDataSource}" >
                                    select p.product_id,p.product_name, p.image_name, o.quantity,o.price from product_master p inner join order_detail o on p.product_id = o.product_id where o.order_id =${row.order_id};
                                </sql:query>
                                <c:set var="order_total" value="0"/>

                                <c:forEach items="${selectOrderDetail.rows}" var="row_od">
                                    <tr style="border-bottom-style:solid;">
                                        <td align="center"><img style="height:130px" src="${pageContext.servletContext.contextPath}/ImageServlet?id=${row_od.product_id}" alt="${row_od.image_name}"/></td>
                                        <td valign="top"><b>${row_od.product_name}<br>₹${row_od.price}</b></td>
                                        <td valign="top"><b>Quantity: ${row_od.quantity}</b></td>
                                        <td valign="top" align="center"><b>Total Amount: ₹${row_od.quantity * row_od.price}</b></td>
                                    </tr>
                                    <c:set var="order_total" value="${order_total+(row_od.quantity * row_od.price)}"/>
                                </c:forEach>
                                <tr >
                                    <td colspan="3"></td>
                                    <td align="center"><b>Order Total: ₹${order_total}</b></td>
                                </tr>
                            </table>
                        </fieldset>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!--Order Master SQL Query-->
                    <sql:query dataSource="${viewOrderDataSource}"
                               var="selectOrderMaster">
                        select o.order_id, o.date_time, c.first_name,c.last_name,c.contact_no,c.address_line1,c.address_line_2,c.address_line_3,c.pincode from order_master o inner join customer_master c on o.customer_id = c.customer_id where is_delivered='N';
                    </sql:query>

                    <br><h4 style="font-size: 20px;margin-left: -30px;">Orders Pending</h4>
                    <c:forEach var="row" items="${selectOrderMaster.rows}">
                        <fieldset align="left" style="margin-bottom:20px;width:90%;">
                            <legend><b>Order ID:${row.order_id}</b></legend>
                            <table align='left' width="100%" cellpadding="4"cellspacing="0" border="0">
                                <tr>
                                    <td colspan="3"><b>Date of Order:</b> <fmt:formatDate  value="${row.date_time}" type="both" pattern="d/M/y h:m:s a" dateStyle="short" timeStyle="medium" /></td>
                                    <td align="right" style="font-family: arial;font-size: 20px;font-weight: bolder;" ><input type="checkbox" style="cursor:pointer" id="checkDeliver"  onclick="confirmDelivery(${row.order_id})"><a onclick="confirmDelivery(${row.order_id})" style="color: #00b100;cursor: pointer;" id="btn_deliver">is Delivered?</a></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><b>Name:</b> <c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/> </td>
                                    <td align="right" colspan="1"><b>Contact No:</b> <u>+91-<c:out value="${row.contact_no}"/></u></td>
                                </tr>
                                <tr style="border-bottom:1px solid #0556ac;">
                                    <td colspan="3"><b>Address:</b> ${row.address_line1}, &nbsp; ${row.address_line_2}, &nbsp; ${row.address_line_3} </td>
                                    <td align="right" ><b>PIN Code:</b>${row.pincode} <br></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center" style="font-family: arial; font-size: 17px;color:darkblue;  "><b>Order Details</b></td>
                                </tr>
                                <!--Order Detail SQL Query-->
                                <sql:query var="selectOrderDetail" dataSource="${viewOrderDataSource}" >
                                    select p.product_id,p.product_name, p.image_name, o.quantity,o.price from product_master p inner join order_detail o on p.product_id = o.product_id where o.order_id =${row.order_id};
                                </sql:query>
                                <c:set var="order_total" value="0"/>

                                <c:forEach items="${selectOrderDetail.rows}" var="row_od">
                                    <tr style="border-bottom-style:solid;">
                                        <td align="center"><img style="height:130px" src="${pageContext.servletContext.contextPath}/ImageServlet?id=${row_od.product_id}" alt="${row_od.image_name}"/></td>
                                        <td valign="top"><b>${row_od.product_name}<br>₹${row_od.price}</b></td>
                                        <td valign="top"><b>Quantity: ${row_od.quantity}</b></td>
                                        <td valign="top" align="center"><b>Total Amount: ₹${row_od.quantity * row_od.price}</b></td>
                                    </tr>
                                    <c:set var="order_total" value="${order_total+(row_od.quantity * row_od.price)}"/>
                                </c:forEach>
                                <tr >
                                    <td colspan="3"></td>
                                    <td align="center"><b>Order Total: ₹${order_total}</b></td>
                                </tr>
                            </table>
                        </fieldset>
                    </c:forEach>
                </c:otherwise>

            </c:choose>

        </form>

        <% }%>
    </body>
</html>
