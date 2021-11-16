<%-- 
    Document   : AdminHome
    Created on : Dec 30, 2020, 1:26:24 AM
    Author     : Omar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        <title>Home - HotelsHero</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand main-color fw-bold" href="#">Hotels Hero</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="AdminHome.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ViewAllHotels.jsp">View Hotels</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="viewUsers.jsp">All Clients</a>
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
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM reservation");
        %>


        <div class="container-fluid px-5 my-5">
            <h1 class="header-1 my-5 text-center">
                All Reservations 
            </h1>
            <div class="row">
                <%
                    //while (RS.next()) {
                %>
                <table class="table table-responsive table-bordered table-striped text-center">
                    <thead style="background-color: #fe0002; color: white">
                        <tr>
                            <th scope="col">#</th>
                            <th colspan="" scope="col">Client Name</th>
                            <th colspan="" scope="col">Hotel Name</th>
                            <th colspan="" scope="col">City</th>
                            <th scope="col">Check In Date</th>
                            <th scope="col">Check Out Date</th>
                            <th colspan="" scope="col">Total Price</th>
                            <th colspan="" scope="col">Reservation Type</th>
                            <th colspan="" scope="col">Confirmed Status</th>
                            <th colspan="" scope="col">Running Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            int count = 0;
                            /*
                            while (RS.next()) {
                                
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSCName = Stmt.executeQuery("SELECT * FROM users WHERE UserID = "
                                        + Integer.parseInt(RS.getString("UserID")));
                                RSCName.first();
                                String cname = RSCName.getString("UserName");
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = "
                                        + Integer.parseInt(RS.getString("HotelID")));
                                RHotel.first();
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSCity = Stmt.executeQuery("SELECT * FROM city WHERE CityID = " + Integer.parseInt(RS.getString("CityID")));
                                RSCity.first();
                             */
                            while (RS.next()) {
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSUser = Stmt.executeQuery("SELECT * FROM users WHERE UserID = " + Integer.parseInt(RS.getString("UserID")));
                                RSUser.first();

                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = " + Integer.parseInt(RS.getString("HotelID")));
                                RSHotel.first();

                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSCity = Stmt.executeQuery("SELECT * FROM city WHERE CityID = " + Integer.parseInt(RS.getString("CityID")));
                                RSCity.first();

                        %>
                        <tr>
                            <td>
                                <%=++count%>
                            </td>
                            <td class="fw-bold">
                                <%=RSUser.getString("UserName")%>
                            </td>
                            <td class="fw-bold">
                                <%=RSHotel.getString("HotelName")%>
                            </td>
                            <td class="fw-bold">
                                <%=RSCity.getString("CityName")%>
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
                            <td class="fw-bold">
                                <%=RS.getString("ReservationType")%>
                            </td>
                            <td class="fw-bold">
                                <%
                                    if (RS.getString("Confirmed").equals("1")) {
                                        out.println("Confirmed");
                                    } else {
                                        out.println("Needs Confirmation");
                                %>
                                <a href="ConfirmReservation.jsp?ReservationID=<%=RS.getString("ReservationID")%>">
                                    <input class="btn btn-login w-100" type="submit" value="confirm reservation" />
                                </a>
                                <%
                                    }
                                %>
                            </td>
                            <td class="fw-bold">
                                <%
                                    if (RS.getString("Running").equals("0")) {
                                        out.println("Not Running");
                                    } else {
                                        out.println("Running");
                                %>
                                <a href="CancelReservation.jsp?ReservationID=<%=RS.getString("ReservationID")%>">
                                    <input class="btn btn-login w-100" type="submit" value="cancel reservation" />
                                </a>
                                <%
                                    }
                                %>
                            </td>
                            <%
                                //}
                            %>
                        </tr>
                        <%                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
