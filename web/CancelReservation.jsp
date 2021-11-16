<%-- 
    Document   : CancelReservation
    Created on : Jan 15, 2021, 3:26:48 AM
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
            ResultSet RSReservation = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();

            String ReservationID = request.getParameter("ReservationID");
            RSReservation = Stmt.executeQuery("SELECT * FROM reservation WHERE ReservationID = " + Integer.parseInt(ReservationID));
            RSReservation.first();

            Stmt = (Statement) Con.createStatement();
            ResultSet RSCityHotel = Stmt.executeQuery("SELECT * FROM city_hotel WHERE CityID = "
                    + RSReservation.getString("CityID") + " AND HotelID = " + RSReservation.getString("HotelID"));
            RSCityHotel.first();
            
            Stmt = (Statement) Con.createStatement();
            Stmt.executeUpdate("UPDATE reservation SET Canceled = " + 1 + " WHERE ReservationID = "
                    + Integer.parseInt(RSReservation.getString("ReservationID")));

            if (RSReservation.getString("Running").equals("1")) {
                Stmt = (Statement) Con.createStatement();
                Stmt.executeUpdate("UPDATE reservation SET Running = " + 0 + " WHERE ReservationID = "
                        + Integer.parseInt(RSReservation.getString("ReservationID")));

                Stmt = (Statement) Con.createStatement();
                Stmt.executeUpdate("UPDATE city_hotel SET AvailableRooms = "
                        + (Integer.parseInt(RSCityHotel.getString("AvailableRooms")) + Integer.parseInt(RSReservation.getString("NumberOfRooms")))
                        + " WHERE CityHotelID = " + Integer.parseInt(RSCityHotel.getString("CityHotelID")));
            }
            Stmt = (Statement) Con.createStatement();
            ResultSet RSUser = Stmt.executeQuery("SELECT * FROM users WHERE UserID = " + Integer.parseInt(RSReservation.getString("UserID")));
            RSUser.first();
            //new Mail().send_cancelation_email(RSUser.getString("UserName"), RSUser.getString("UserEmail"), RSReservation);
            if (request.getSession().getAttribute("session_IsAdmin").equals("0")) {
                response.sendRedirect("MyReservations.jsp");
            } else {
                response.sendRedirect("AdminHome.jsp");
            }
        %>
    </body>
</html>
