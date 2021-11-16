<%-- 
    Document   : ClientHome
    Created on : Dec 30, 2020, 1:27:39 AM
    Author     : Omar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Client Home Page</title>
    </head>
    <body>
        <%
            String UserDisplayName = request.getSession().getAttribute("session_UserDisplayName").toString();
        %>
        <h1>Hello <%=UserDisplayName%>!</h1>
        <br>
        <form action="AccountInformation.jsp">
            <input type="submit" value="Account Information" />
        </form>
        <form action="Search.jsp">
            <input type="submit" value="search" />
        </form>
        <form action="index.html">
            <input type="submit" value="Sign out" />
        </form>
    </body>
</html>
