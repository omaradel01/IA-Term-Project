<%-- 
    Document   : ConfirmReservation
    Created on : Jan 15, 2021, 6:38:56 AM
    Author     : Omar
--%>
<%@page import="newpackage.Mail"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            Stmt.executeUpdate("UPDATE reservation SET Confirmed = " + 1 + " WHERE ReservationID = " + 
                    Integer.parseInt(request.getParameter("ReservationID")));
            
            Stmt = (Statement) Con.createStatement();
            ResultSet RSReservation = Stmt.executeQuery("SELECT * FROM reservation WHERE ReservationID = " + 
                    Integer.parseInt(request.getParameter("ReservationID")));
            RSReservation.first();
            Stmt = (Statement) Con.createStatement();
            ResultSet RSUser = Stmt.executeQuery("SELECT * FROM users WHERE UserID = " + Integer.parseInt(RSReservation.getString("UserID")));
            RSUser.first();
            //new Mail().send_confirmation_email(RSUser.getString("UserName"), RSUser.getString("UserEmail"), RSReservation);
            response.sendRedirect("AdminHome.jsp");
        %>
    </body>
</html>
