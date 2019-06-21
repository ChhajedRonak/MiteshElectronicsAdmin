<%--
    Document   : login
    Created on : 1 Nov, 2018, 1:55:40 AM
    Author     : HP PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mitesh Electronics</title>
    </head>
    <style>
        header {
            position:fixed;
            height: 100px;
            width: 100%;
            left:0;
            right:0;
            top:0;
            background-image: linear-gradient(#020005, #090979,#00d4ff);
            margin:0;
            clear:both;
            z-index:10;
            padding-top:10px;
            padding-bottom: 10px;
            padding-left:5px;
        }

        header img{
            background:transparent;
            float:left;
            visibility:visible;
            height:100px;
            width:100px;
        }
        header #name {
            font: 40px "Arial";
            display: inline;
            float:left;
            color: white;
            margin-left:10px;
            margin-top: 20px;
        }
    </style>
    <link href="CSS/miteshStyle.css" rel="stylesheet" type="text/css"/>
    <body>
        <% if ((session.getAttribute("isLogin") != null) && (session.getAttribute("isLogin").equals("true"))) {%>
        <jsp:forward page="navigation.jsp"/>
        <%} else {%>

        <header id="head">
            <img src="logo.png"/>
            <h1 id="name"><strong>MITESH MOBILE & ELECTRONICS</strong></h1>
            <!--                <div id="headcart">
                                <h4 ><a href="" id="loginclick">Login</a></h4>
                            </div>-->

        </header>

        <form action="Login" method="post" style="margin-top:150px;">
            <table align="center" cellpadding="10">
                <caption><h4>Admin Login</h4></caption>
                <tr><td><label for="username">Username:</label></td>
                    <td><input type="text" name="username" required/></td>
                </tr>
                <tr><td><label for="password">Password:</label></td>
                    <td><input type="password" name="password" required/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="LOGIN"/></td>
                </tr>
            </table>
        </form>
        <%}%>
    </body>
</html>
