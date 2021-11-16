<%-- 
    Document   : ViewAllHotels
    Created on : Jan 14, 2021, 6:59:59 PM
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
        <title>View Hotels - HotelsHero</title>
    </head>
    <body>
        <style>
            .hotel-wraps{
                text-align: center;
                box-shadow: 1px 1px 10px rgba(0,0,0,0.1);
                margin: 50px 0;
                padding: 20px
            }
            .hotel-wraps img
            {
                height: 240px !important;
                width: 350px !important
            }
            .hotel-wraps a 
            {
                text-decoration: none;
                color: black
            }
        </style>
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
            RS = Stmt.executeQuery("SELECT * FROM hotel");
        %>
        <br>
        <!--        <ul style="margin-left: 20px;" border="0">
                    Hotel Name
                 
                    <li style="margin-left: 30px;">
                        <a href="ViewHotel.jsp?HID=</a>
                    </li>
        <%--<%=RS.getString("HotelID")%>"><%=RS.getString("HotelName")%>--%>
                   
                </ul>-->

        <div class="container">
            <h2 class="header-2 text-center mt-4">
                List of All Hotels
            </h2>
            <div class="row">
                <%
                    while (RS.next()) {
                %>
                <div class="col-md-4">
                    <div class="hotel-wraps">
                        <img height="240" src ="<%=RS.getString("SingleImage")%>" class="img-fluid mb-2">
                        <h2 class="header-2 mb-2">
                            <%=RS.getString("HotelName")%>
                        </h2>
                        <%
                            int a = Integer.parseInt(RS.getString("HotelStars"));
                            for (int i = 0; i < a; i++) {
                        %>
                        <span class="fas fa-star"></span>
                        <%
                            }
                        %> 

                        <a class="btn btn-login w-100" href="ViewHotel.jsp?HID=<%=RS.getString("HotelID")%>">
                            More Info
                        </a>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <hr>
        <!-- Button trigger modal -->
        <div class="w-100 text-center">
            <button type="button" class="btn btn-login text-center" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Add New Hotel
            </button>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Add New Hotel</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="AddHotel">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Hotel Name</label>
                                                <input type="text" name="HotelName" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Hotel Stars</label>
                                                <select class="form-select" name="Stars">
                                                    <option selected>Open this select menu</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                </select>   
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Price Per Night</label>
                                                <input type="number" name="price" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Featured Image</label>
                                                <input name="HotelSingleImage" type="text" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Hotel Images</label>
                                                <input type="text" name="images" value="" class="form-control" />
                                            </div>
                                        </div>
                                        <input class="btn btn-login w-100" type="submit" value="Add New Hotel" />
                                        <!--                  <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Hotel Images</label>
                                                                <input type="file" name="newHotelImage" value="" class="form-control" />
                                                            </div>
                                                            </div>-->
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>   
        </div>

        <!--        <form action="AddHotel">
                    <table class="table">
                        <tr>
                            <td>Hotel Name:</td>
                            <td><input type="text" name="HotelName" class="form-control"></td>
                        </tr>
                        <tr>
                            <td>Hotel Stars</td>
                            <td>
                                <select class="form-select" name="Stars">
                                    <option selected>Open this select menu</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>   
                            </td>
                        </tr>
                        <tr>
                            <td>Hotel Images</td>
                            <td><input name="HotelImages" type="text" class="form-control"></td>
                        </tr>
                        <tr>
                            <td>Hotel Single Image</td>
                            <td><input name="HotelSingleImage" type="text" class="form-control"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input class="btn btn-login w-10" type="submit" value="Add a new Hotel" /></td>
                        </tr>
                    </table>
                </form>-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    </body>
</html>
