<%-- 
    Document   : ShowHotel
    Created on : Jan 12, 2021, 3:10:31 AM
    Author     : Omar
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <title>Hotel-HotelsHero</title>

    </head>


    <body>
        <style>
            .input-read
            {
                display: inline !important;
                border: none !important;
                width: 100px !important;
                text-align: end !important;
            }
        </style>
        <%
            int CityHotelID = Integer.parseInt(request.getParameter("ID"));
            request.getSession().setAttribute("session_CityHotelID", request.getParameter("ID"));
            int CityID = Integer.parseInt(request.getParameter("CITYID"));
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM city_hotel WHERE city_hotel.CityHotelID = " + CityHotelID);
            RS.first();
            Stmt = (Statement) Con.createStatement();
            ResultSet RSHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE hotel.HotelID = " + RS.getString("HotelID"));
            RSHotel.first();
            Stmt = (Statement) Con.createStatement();
            ResultSet rs = Stmt.executeQuery("SELECT city.CityName FROM city WHERE city.CityID = " + CityID);
            rs.first();
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
                            <a class="nav-link active" aria-current="page" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Reservations</a>
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
        <div class="container">
            <div class="row align-items-start my-4">
                <div class="col-md-2">
                    <h4 class="header-2">
                        Related Hotels
                    </h4>
                    &nbsp;
                    <!--
                    <%
                        //rs = Stmt.executeQuery("SELECT hotel.HotelName, hotel.PriceOfOneNight FROM hotel INNER JOIN city_hotel ON hotel.HotelID = " + CityHotelID);
                        //rs.first();
                    %>
                    -->
                </div>
                <div class="col-md-10 my-4">
                    <h3 class="header-3 my-4 text-center">
                        <%=RSHotel.getString("HotelName")%>
                    </h3>
                    <div class="slideshow-container mb-5">
                        <%
                            String HotelImagesPath = RSHotel.getString("HotelImages");
                            // D:\\CS-4 (First-term)\\Internet Applications\\Hotelreservation\\web\\
                            //D:\Omar\FCAI\Level 4\Internet Applications\Project\NetBeans Project\HotelReservation\web
                            File file = new File("D:\\HotelReservation\\web\\" + HotelImagesPath);
                            String[] images = file.list();
                            for (int i = 0; i < images.length; i++) {
                                String image = images[i];
                        %>
                        <div class="mySlides">
                            <div class="numbertext"><%=i + 1%> / <%=images.length%></div>
                            <img src="<%=HotelImagesPath + "\\" + image%>" class="animate__animated animate__fadeIn" style="width:100%; height: 450px;">
                            <div class="texts"></div>
                        </div>
                        <%
                            }
                        %>
                        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                        <a class="next" onclick="plusSlides(1)">&#10095;</a>
                    </div>
                    <div class="mb-5" style="text-align:center">
                        <%
                            for (int i = 0; i < images.length; i++) {
                        %>
                        <span class="dot" onclick="currentSlide(<%=i + 1%>)"></span>
                        <%
                            }
                        %>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h2 class="header-2">
                                Description
                            </h2>
                            <p class="text">
                                A hotel is an establishment that provides paid lodging on a short-term basis. Facilities provided inside a hotel room may range from a modest-quality mattress in a small room to large suites with bigger, higher-quality beds, a dresser, a refrigerator and other kitchen facilities, upholstered chairs, a flat screen television, and en-suite bathrooms. Small, lower-priced hotels may offer only the most basic guest services and facilities. Larger, higher-priced hotels may provide additional guests.
                            </p>
                        </div>
                        <div class="col-md-6">
                            <div class="desc-items-container">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="value main-color" style="margin-right: 45px;">City</span>
                                    <span><%=rs.getString("CityName")%></span>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="value main-color" style="margin-right: 45px;">Hotel Rating</span>
                                    <div>
                                        <%
                                            int a = Integer.parseInt(RSHotel.getString("HotelStars"));
                                            for (int i = 0; i < a; i++) {
                                        %>
                                        <span class="fas fa-star"></span>
                                        <%
                                            }
                                        %> 
                                    </div>

                                </div>


                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="value main-color" style="margin-right: 45px;">Price Per Night</span>
                                    <span><%=RS.getString("PriceOfOneNight")%> EGP</span>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="value main-color" style="margin-right: 45px;">Available Rooms</span>
                                    <span><%=RS.getString("AvailableRooms")%></span>
                                </div>
                                <%
                                    if (Integer.parseInt(RS.getString("AvailableRooms")) > 0) {

                                        request.getSession().setAttribute("session_SearchCityName", rs.getString("CityName"));
                                        request.getSession().setAttribute("session_HotelName", RSHotel.getString("HotelName"));
                                        request.getSession().setAttribute("session_PriceOfOneNight", RS.getString("PriceOfOneNight"));                            %>


                                <button type="button" class="btn btn-login w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Make a Reservation
                                </button>
                                <%
                                } else {
                                %>
                                <button disabled type="button" class="btn btn-login w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Make a Reservation
                                </button
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="row my-4">
                        <h2 class="header-2">
                            Location 
                        </h2>
                        <iframe src="<%=RS.getString("MapLocation")%>" width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
                    </div>
                </div>

                <a class="d-none" href="https://www.google.com/maps/search/<%=RSHotel.getString("HotelName")%>+<%=request.getSession().getAttribute("session_SearchCityName").toString()%>" target="_blank">
                    <img src="https://developers.google.com/maps/images/maps-icon.svg" style="width:40px;">
                </a>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <%
                String city = request.getSession().getAttribute("session_SearchCityName").toString();
                String HotelName = request.getSession().getAttribute("session_HotelName").toString();
                String CheckInDate = request.getSession().getAttribute("session_SearchCheckInDate").toString();
                String CheckOutDate = request.getSession().getAttribute("session_SearchCheckOutDate").toString();
                String NumberOfRooms = request.getSession().getAttribute("session_SearchNoOfRooms").toString();
                String NumberOfAdults = request.getSession().getAttribute("session_SearchNoOfAdults").toString();
                String NumberOfChildren = request.getSession().getAttribute("session_SearchNoOfChildren").toString();
                String PriceOfNight = request.getSession().getAttribute("session_PriceOfOneNight").toString();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
                Date check_in_date = formatter.parse(CheckInDate);
                Date check_out_date = formatter.parse(CheckOutDate);
                int days = (int) (check_out_date.getTime() - check_in_date.getTime()) / (1000 * 60 * 60 * 24);
            %>
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add New Reservation</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="MakeReservation">
                            <div class="container">
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Selected City</span>
                                    <span class="fw-bold">
                                        <%=city%>
                                    </span>
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Hotel Name</span>
                                    <input readonly value="<%=HotelName%>" name="HotelName" class="fw-bold input-read">
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Check-In Date</span>
                                    <input class="fw-bold input-read" type="text" name="CheckInDate" value="<%=CheckInDate%>" readonly="readonly" />                                   

                                </div>

                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Check-out Date</span>
                                    <input class="fw-bold input-read" type="text" name="CheckOutDate" value="<%=CheckOutDate%>" readonly="readonly" />
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Number of Rooms</span>
                                    <input class="fw-bold input-read" type="text" name="NumberOfRooms" value="<%=NumberOfRooms%>" readonly="readonly" />
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Number of Adults</span>
                                    <input class="fw-bold input-read" type="text" name="NumberOfAdults" value="<%=NumberOfAdults%>" readonly="readonly" />
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Number of Children</span>
                                    <input class="fw-bold input-read" type="text" name="NumberOfChildren" value="<%=NumberOfChildren%>" readonly="readonly" />
                                </div>
                                <div class="my-3 px-5">
                                    <label class="main-color">
                                        Reservation Type 
                                    </label>
                                    <select class="form-control form-select" oninput="MyFunction()" id="BoardType" name="BoardType">
                                        <%
                                            if (days > 0) {
                                        %>
                                        <option value="Bed and Breakfast - Single Room">Bed and Breakfast - Single Room</option>
                                        <option value="Bed and Breakfast - Double Room">Bed and Breakfast - Double Room</option>
                                        <option value="Bed and Breakfast - Triple Room">Bed and Breakfast - Triple Room</option>
                                        <option value="Half Board - Single Room">Half Board - Single Room</option>  
                                        <option value="Half Board - Double Room">Half Board - Double Room</option>
                                        <option value="Half Board - Triple Room">Half Board - Triple Room</option>
                                        <option value="Full Board - Single Room">Full Board - Single Room</option>
                                        <option value="Full Board - Double Room">Full Board - Double Room</option>
                                        <option value="Full Board - Triple Room">Full Board - Triple Room</option>
                                        <%
                                        } else {
                                        %>
                                        <option value="Day-Use">Day-Use</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="d-flex align-items-center justify-content-between px-5 my-3">
                                    <span class="main-color fw-bold">Total Price (EGP)</span>
                                    <%
                                        if (days == 0) {
                                    %>

                                    <input class="fw-bold input-read" readonly="readonly" type="text" value="<%=Double.parseDouble(PriceOfNight) * 0.5 * Integer.parseInt(NumberOfRooms)%>" name="Price" id="TotalPrice"/>
                                    <%
                                    } else {
                                    %>
                                    <input class="fw-bold input-read" readonly="readonly" type="text" value="<%=days * Double.parseDouble(PriceOfNight) * Integer.parseInt(NumberOfRooms)%>" name="Price" id="TotalPrice"/>                                
                                    <%
                                        }
                                    %>
                                </div>      
                                <input class="btn btn-login w-100" type="submit" value="Submit Reservation Form" onclick="Submit()"/>               
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>   
        <script>
                                    var slideIndex = 1;
                                    showSlides(slideIndex);

                                    // Next/previous controls
                                    function plusSlides(n) {
                                        showSlides(slideIndex += n);
                                    }

                                    // Thumbnail image controls
                                    function currentSlide(n) {
                                        showSlides(slideIndex = n);
                                    }

                                    function showSlides(n) {
                                        var i;
                                        var slides = document.getElementsByClassName("mySlides");
                                        var dots = document.getElementsByClassName("dot");
                                        if (n > slides.length) {
                                            slideIndex = 1;
                                        }
                                        if (n < 1) {
                                            slideIndex = slides.length;
                                        }
                                        for (i = 0; i < slides.length; i++) {
                                            slides[i].style.display = "none";
                                        }
                                        for (i = 0; i < dots.length; i++) {
                                            dots[i].className = dots[i].className.replace(" actives", "");
                                        }
                                        slides[slideIndex - 1].style.display = "block";
                                        dots[slideIndex - 1].className += " actives";
                                    }
                                    function MyFunction() {
                                        var x = parseFloat(<%=Double.parseDouble(PriceOfNight) * days * Integer.parseInt(NumberOfRooms)%>);
                                        var y = document.getElementById("BoardType").value;

                                        // Bed and Breakfast
                                        if (y === "Bed and Breakfast - Single Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = x;
                                        }
                                        if (y === "Bed and Breakfast - Double Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.25));
                                        }
                                        if (y === "Bed and Breakfast - Triple Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.5));
                                        }

                                        // Half Board
                                        if (y === "Half Board - Single Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = x + (x * 0.25);
                                        }
                                        if (y === "Half Board - Double Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.25) + (x * 0.25));
                                        }
                                        if (y === "Half Board - Triple Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.25) + (x * 0.5));
                                        }

                                        // Full Board
                                        if (y === "Full Board - Single Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = x + (x * 0.5);
                                        }
                                        if (y === "Full Board - Double Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.5) + (x * 0.25));
                                        }
                                        if (y === "Full Board - Triple Room") {
                                            //alert(y);
                                            document.getElementById("TotalPrice").value = (x + (x * 0.5) + (x * 0.5));
                                        }
                                    }
                                    function Submit() {
                                        alert("Your Reservation is recorded. It may take a couple of hours to be confirmed.\n\
           Check in My Reservations");
                                    }
        </script>
    </body>
</html>
