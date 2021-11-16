<%-- 
    Document   : SearchResult
    Created on : Jan 12, 2021, 1:30:24 AM
    Author     : Omar
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Search Results</title>
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
                            <a class="nav-link active" aria-current="page" href="ClientHome.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MyReservations.jsp">Reservations</a>
                        </li>

                        <%
                            String UserDisplayName = request.getSession().getAttribute("session_UserFirstName").toString();
                        %>
                    </ul>
                    <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
        <section class="Search Results">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        Filters
                    </div>
                    <div class="col-md-9">
                        <%
                            String CityName = request.getParameter("CityName");
                            String CheckInDate = request.getParameter("CheckInDate");
                            String CheckOutDate = request.getParameter("CheckOutDate");
                            String NoOfAdults = request.getParameter("NoOfAdults");
                            String NoOfChildren = request.getParameter("NoOfChildren");
                            String NoOfRooms = request.getParameter("NoOfRooms");

                            request.getSession().setAttribute("session_SearchCityName", CityName);
                            request.getSession().setAttribute("session_SearchCheckInDate", CheckInDate);
                            request.getSession().setAttribute("session_SearchCheckOutDate", CheckOutDate);
                            request.getSession().setAttribute("session_SearchNoOfAdults", NoOfAdults);
                            request.getSession().setAttribute("session_SearchNoOfChildren", NoOfChildren);
                            request.getSession().setAttribute("session_SearchNoOfRooms", NoOfRooms);

                            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
                            String user = "root";
                            String pass = "17091999";
                            Connection Con = null;
                            Statement Stmt = null;
                            ResultSet RS = null;
                            Class.forName("com.mysql.jdbc.Driver");
                            Con = DriverManager.getConnection(url, user, pass);
                            Stmt = (Statement) Con.createStatement();
                            if (CityName.equals("") || CityName == null) {
                                RS = Stmt.executeQuery("SELECT city.CityID, city_hotel.CityHotelID, city_hotel.Distance, hotel.HotelStars, city.CityName, hotel.HotelName, city_hotel.PriceOfOneNight, city_hotel.AvailableRooms, hotel.SingleImage, hotel.HotelImages from city, hotel, city_hotel where hotel.HotelID in "
                                        + "(SELECT city_hotel.HotelID from city_hotel where city_hotel.CityID in (SELECT city.CityID from city)) "
                                        + "and city_hotel.HotelID = hotel.HotelID and city_hotel.CityID in (SELECT city.CityID from city) and city.CityID = city_hotel.CityID "
                                        + "ORDER BY city.CityID;");
                                while (RS.next()) {
                        %>
                        <div class="hotel-wrap my-4">

                            <div class="row align-items-start">
                                <div class="col-md-4">
                                    <div class="hotel-img">
                                        <img class="img-fluid" src="<%=RS.getString("SingleImage")%>">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <h1 class="header-3 mb-2">
                                        <%=RS.getString("HotelName")%>
                                    </h1>
                                    <%
                                        int a = Integer.parseInt(RS.getString("HotelStars"));
                                        for (int i = 0; i < a; i++) {
                                    %>
                                    <span class="fas fa-star"></span>
                                    <%
                                        }
                                    %> 
                                    <span class="hotelPrice mr-2 d-block">
                                        <%=RS.getString("CityName")%>

                                    </span>
                                    <span class="hotelDistance mr-2 d-block">
                                        <%=RS.getString("Distance")%>KM away
                                    </span>
                                </div>
                                <div class="col-md-4" style="margin-top:5px">
                                    <%
                                        if (CityName.equals("") || CityName == null) {
                                    %>
                                    <h3 class="header-3 main-color">
                                        <%=RS.getString("PriceOfOneNight")%> EGP/day
                                    </h3>
                                    <small class="d-block" style="color:#b1b1b1">VAT Included</small>
                                    <%
                                        }
                                    %>
                                    <a href="ShowHotel.jsp?ID=<%=RS.getString("CityHotelID")%>&CITYID=<%=RS.getString("CityID")%>"class="btn btn-login">
                                        More Info
                                    </a>
                                </div>
                            </div>
                        </div>
                        <%
                                }

                            } else {
                                ResultSet RSCity = Stmt.executeQuery("SELECT * FROM city where CityName = '" + CityName + "'");
                                RSCity.first();
                                Stmt = (Statement) Con.createStatement();
                                ResultSet rs = Stmt.executeQuery("SELECT city_hotel.CityHotelID, city_hotel.Distance, hotel.HotelStars, hotel.SingleImage, city_hotel.CityHotelID, hotel.HotelName, city_hotel.PriceOfOneNight,"
                                        + " city_hotel.AvailableRooms, hotel.HotelImages from hotel, city_hotel where hotel.HotelID in (SELECT city_hotel.HotelID from city_hotel "
                                        + "where city_hotel.CityID = (SELECT city.CityID from city where city.CityName = '" + CityName + "')) and city_hotel.HotelID = hotel.HotelID and "
                                        + "city_hotel.CityID = (SELECT city.CityID from city where city.CityName = '" + CityName + "');");
                                while (rs.next()) {
                        %>
                        <div class="hotel-wrap my-4">

                            <div class="row align-items-start">
                                <div class="col-md-4">
                                    <div class="hotel-img">
                                        <img class="img-fluid" src="<%=rs.getString("SingleImage")%>">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <h1 class="header-3 mb-2">
                                        <%=rs.getString("HotelName")%>
                                    </h1>
                                    <%
                                        int a = Integer.parseInt(rs.getString("HotelStars"));
                                        for (int i = 0; i < a; i++) {
                                    %>
                                    <span class="fas fa-star"></span>
                                    <%
                                        }
                                    %> 
                                    <span class="hotelPrice mr-2 d-block">
                                        <%=RSCity.getString("CityName")%>

                                    </span>
                                    <span class="hotelDistance mr-2 d-block">
                                        <%=rs.getString("Distance")%>KM away
                                    </span>
                                </div>
                                <div class="col-md-4" style="margin-top:5px">
                                    <%
                                        if (CityName.equals("") || CityName == null) {
                                    %>
                                    <h3 class="header-3 main-color">
                                        <%=rs.getString("PriceOfOneNight")%> EGP/day
                                    </h3>
                                    <small class="d-block" style="color:#b1b1b1">VAT Included</small>
                                    <%
                                        }
                                    %>
                                    <a href="ShowHotel.jsp?ID=<%=rs.getString("CityHotelID")%>&CITYID=<%=RSCity.getString("CityID")%>"class="btn btn-login">
                                        More Info
                                    </a>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
