<%-- 
    Document   : MyReservations
    Created on : Jan 14, 2021, 3:57:36 PM
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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/all.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <title>Reservation - HotelsHero</title>
    </head>
    <body>
        <%
            //new Mail().send_email("mkassas1998@gmail.com", "12345");
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand main-color fw-bold" href="#">Hotels Hero</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="ClientHome.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="MyReservation.jsp">Reservations</a>
                        </li>
                    </ul>
                    <%
                        String UserDisplayName = request.getSession().getAttribute("session_UserDisplayName").toString();
                    %>
                    <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <img class="img-fluid" src="assets/user.png" width="24" height="24">
                                <%=UserDisplayName%>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">
                                        <form action="AccountInformation.jsp">
                                            <input class="btn btn-login w-100 m-0" type="submit" value="Account Information" />
                                        </form>
                                    </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">
                                        <form action="index.html">
                                            <input class="btn btn-login w-100 m-0" type="submit" value="Sign out" />
                                        </form>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <%
//            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
//            String user = "root";
//            String pass = "17091999";
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM reservation WHERE UserID = "
                    + Integer.parseInt(request.getSession().getAttribute("session_UserID").toString()));
        %>
        <div class="container-fluid px-5 my-5">
            <div class="row">
                <table class="table table-responsive table-bordered table-striped text-center">
                    <thead style="background-color: #fe0002; color: white">
                        <tr>
                            <th scope="col">#</th>
                            <th colspan="" scope="col">Hotel Name</th>
                            <th scope="col">City</th>
                            <th scope="col">Reservation Type</th>
                            <th scope="col">Check In Date</th>
                            <th scope="col">check Out Date</th>
                            <th scope="col">Price</th>
                            <th scope="col">Running Status</th>
                            <th scope="col">Confirmation Status</th>
                            <th scope="col">Cancellation status</th>
                            <th scope="col">Apply Cancel</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 0;
                            while (RS.next()) {
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSHotelName = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = "
                                        + Integer.parseInt(RS.getString("HotelID")));
                                RSHotelName.first();
                                String HotelName = RSHotelName.getString("HotelName");
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSCityName = Stmt.executeQuery("SELECT * FROM city WHERE CityID = "
                                        + Integer.parseInt(RS.getString("CityID")));
                                RSCityName.first();
                                String CityName = RSCityName.getString("CityName");
                        %>
                        <tr>
                            <td>
                                <%=++count%>
                            </td>
                            <td class="fw-bold">
                                <%=RSHotelName.getString("HotelName")%>
                            </td>
                            <td class="fw-bold">
                                <%=RSCityName.getString("CityName")%> 
                            </td>

                            <td class="fw-bold">
                                <%=RS.getString("ReservationType")%>
                            </td>
                            <td class="fw-bold">
                                <%=RS.getString("CheckInDate")%>
                            </td>
                            <td class="fw-bold">
                                <%=RS.getString("CheckOutDate")%>
                            </td>

                            <td class="fw-bold">
                                <%=RS.getString("TotalPrice")%>
                            </td>
                            <%
                                if (RS.getString("Running").equals("1")) {
                            %>
                            <td>Running</td>
                            <%
                            } else {
                            %>
                            <td>Not Running</td>
                            <%
                                }
                                if (RS.getString("Confirmed").equals("0")) {
                            %>
                            <td class="alert alert-Warning">
                                Pending
                            </td>
                            <%
                            } else {
                            %>
                            <td class="">
                                Approved
                            </td>
                            <%
                                }
                                if (RS.getString("Canceled").equals("0")) {
                            %>
                            <td class="alert alert-Warning">
                                Not Canceled
                            </td>
                            <td>
                                <a class="btn btn-login w-100" href="CancelReservation.jsp?ReservationID=<%=RS.getString("ReservationID")%>">
                                    Cancel Reservation
                                </a>
                            </td>
                            <%
                            } else {
                            %>
                            <td class="">
                                Canceled
                            </td>
                            <td></td>
                            <%
                                }
                            %>

                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>  
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>   
    </body>
</html>
