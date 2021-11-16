<%-- 
    Document   : ViewHotel
    Created on : Jan 14, 2021, 7:32:52 PM
    Author     : Omar
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        <title>View Hotel</title>
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
                            <a class="nav-link" aria-current="page" href="AdminHome.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ViewAllHotels.jsp">View Hotels</a>
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
                                    </a>
                                </li>
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
            ResultSet RSHotel = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            RSHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = " + Integer.parseInt(request.getParameter("HID")));
            Stmt = (Statement) Con.createStatement();
            ResultSet RSCityHotel = Stmt.executeQuery("SELECT * FROM city_hotel WHERE HotelID = " + Integer.parseInt(request.getParameter("HID")));
            RSHotel.first();
            request.getSession().setAttribute("session_HotelID", request.getParameter("HID"));
        %>
        <h3 class="header-3 text-center my-5"><%=RSHotel.getString("HotelName")%></h3>

        <div class="container-fluid px-5 my-5">
            <button type="button" class="btn btn-login text-center" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Add New Branch
            </button>
            <div class="row">
                <table class="table table-responsive table-bordered table-striped text-center ">
                    <thead style="background-color: #fe0002; color: white">
                        <tr>
                            <th scope="col">City</th>
                            <th scope="col">Distance</th>
                            <th scope="col">Price per night</th>
                            <th scope="col">Available Rooms</th>
                            <th scope="col">Map Location</th>
                            <!--<th>Add New Branch</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (RSCityHotel.next()) {
                                Stmt = (Statement) Con.createStatement();
                                ResultSet RSCity = Stmt.executeQuery("SELECT * FROM city WHERE CityID = "
                                        + Integer.parseInt(RSCityHotel.getString("CityID")));
                                RSCity.first();
                        %>
                        <tr>
                            <td class="fw-bold">
                                <%=RSCity.getString("CityName")%></td>
                            <td class="fw-bold"><%=RSCityHotel.getString("Distance")%></td>
                            <td class="fw-bold"><%=RSCityHotel.getString("PriceOfOneNight")%></td>
                            <td class="fw-bold"><%=RSCityHotel.getString("AvailableRooms")%></td>
                            <td class="fw-bold"><iframe src="<%=RSCityHotel.getString("MapLocation")%>" width=100% height="150" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add New Branch</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="UpdateBranch">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Add Branch City</label>
                                            <input type="text" name="branchCity" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Price of one night</label>
                                            <input type="text" name="Price" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Branch Location</label>
                                            <input type="text" name="branchLocation" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Distance</label>
                                            <input type="text" name="distance" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <input class="btn btn-login w-100" type="submit" value="Confirm New Branch" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
