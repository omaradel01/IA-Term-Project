<%-- 
    Document   : ClientHome
    Created on : Dec 30, 2020, 1:27:39 AM
    Author     : Omar
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
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
        <title>Home - HotelsHero</title>
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
                            String UserDisplayName = request.getSession().getAttribute("session_UserDisplayName").toString();
                        %>
                    </ul>
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
            RS = Stmt.executeQuery("SELECT * FROM CITY");
        %>              
        <section class="home">
            <div class="home-banner js-fullheight" style="background-image: url('assets/h-1.jpg');">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
                        <div class="col-md-12 text-right bannerheader">
                            <h2 class="header-22 mb-4 animate__animated animate__fadeInDown">Hotels Hero , Kings of Reservations</h2>
                            <h6 class="header-66 animate__animated animate__fadeInDown" data-wow-delay="400ms">
                                Best place to make reservation with the lowest prices in the middle east
                            </h6>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Hotel Search Form Area -->
            <div class="hotel-search-form-area animate__animated animate__fadeInDown">
                <div class="container-fluid">
                    <div class="hotel-search-form">
                        <form action="SearchResult.jsp" onsubmit="return ValidateForm()">
                            <div class="row justify-content-center align-items-Start">
                                <div class="col-lg-3">
                                    <div class="form-group mb-1">
                                        <label for="CityName">City Name</label>
                                        <select class="form-control form-select" name="CityName">
                                            <option value="">Click here to choose a city</option>
                                            <%
                                                Con = DriverManager.getConnection(url, user, pass);
                                                Stmt = (Statement) Con.createStatement();
                                                ResultSet RSCities = Stmt.executeQuery("Select * FROM city ORDER BY CityName");
                                                while (RSCities.next()) {
                                            %>
                                            <option value="<%=RSCities.getString("CityName")%>"><%=RSCities.getString("CityName")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="NoofRooms">Number Of Rooms</label>
                                        <input oninput="func()" id="NoOfRooms" required type="text" class="form-control" name="NoOfRooms" placeholder="Enter Number Of Rooms">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group mb-1">
                                        <label for="checkIn">CheckIn Date</label>
                                        <input oninput="ValidateDate()" required id="CheckInDate" type="date" class="form-control"name="CheckInDate">
                                        <p style="color: red; font-style: oblique;" id="DateValidator"></p>
                                    </div>
                                    <div class="form-group ">
                                        <label for="checkout">CheckOut Date</label>
                                        <input oninput="DateChecker()" required id="CheckOutDate" type="date" class="form-control" name="CheckOutDate">
                                        <p style="color: red; font-style: oblique;" id="DateChecker"></p>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group mb-1">
                                        <label for="checkIn">Number Of Adults</label>
                                        <input required class="form-control" name="NoOfAdults" type="number" min="1" id="NoOfAdults" placeholder="Enter Number of Adults">
                                    </div>
                                    <div class="form-group ">
                                        <label for="checkout">Number Of Children</label>
                                        <input required class="form-control" name="NoOfChildren" type="number" min="0" id="NoOfChildren" placeholder="Enter Number of Childs">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group mb-4">
                                        <input class="btn btn-login btn-block w-100" style="margin: 40px 40px 65px 0;" type="submit" value="Search here" />
                                    </div>
                                    <div class="form-group mt-3">
                                        <p class="text">
                                            Enjoy More Than 100+ Reservation with Great Offers
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <script>
            function ValidateDate() {
                var CheckInDate = document.getElementById("CheckInDate").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("GET", "ValidateCheckInDate?CheckInDate=" + CheckInDate, true);
                xmlhttp.send();
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                        var msg = xmlhttp.responseText;
                        if (msg.length > 0) {
                            document.getElementById("DateValidator").innerHTML = msg;
                        } else {
                            document.getElementById("DateValidator").innerHTML = "";
                        }
                    }

                };
                /*
                 var difference = Math.ceil((CheckInDate - today) / (1000 * 60 * 60 * 24));
                 if(difference <= 0){
                 document.getElementById("DateValidator").innerHTML = "Invalid Check in Date";
                 }
                 else{
                 document.getElementById("DateValidator").innerHTML = "";
                 }
                 */
            }
            function DateChecker() {
                var CheckInDate = new Date(document.getElementById("CheckInDate").value);
                var CheckOutDate = new Date(document.getElementById("CheckOutDate").value);
                var difference = (CheckOutDate - CheckInDate) / (1000 * 60 * 60 * 24);
                if (difference < 0) {
                    document.getElementById("DateChecker").innerHTML = "Check Out Date must be at least the same as Check In Date";
                } else {
                    document.getElementById("DateChecker").innerHTML = "";
                }
            }
            function func() {
                var adults = parseInt(document.getElementById("NoOfAdults").value);
                var children = parseInt(document.getElementById("NoOfChildren").value);
                var rooms = parseInt(document.getElementById("NoOfRooms").value);
                if (rooms > (adults + children)) {
                    alert("Number of rooms cannot exceed total of adults and children");
                    document.getElementById("NoOfRooms").value = adults + children;
                }
            }
            function ValidateForm() {
                if (document.getElementById("DateChecker").innerHTML !== "" || document.getElementById("DateValidator").innerHTML !== "") {
                    alert("Check your inputs");
                    return false;
                }
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
