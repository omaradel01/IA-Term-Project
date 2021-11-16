<%-- 
    Document   : AccountInformation
    Created on : Jan 7, 2021, 5:26:27 PM
    Author     : Omar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/all.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <title>Your Account Information</title>
    </head>
    <body>
        <%
            String UserDisplayName = request.getSession().getAttribute("session_UserDisplayName").toString();
            String FirstName = request.getSession().getAttribute("session_UserFirstName").toString();
            String LastName = request.getSession().getAttribute("session_UserLastName").toString();
            String username = request.getSession().getAttribute("session_username").toString();
            String email = request.getSession().getAttribute("session_email").toString();
            String password = request.getSession().getAttribute("session_passowrd").toString();
        %>
        <div class="container">
            <div class="main-body my-5">
                <div class="row gutters-sm">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="assets/user.png" alt="Admin" class="rounded-circle" width="150">
                                    <div class="mt-3">
                                        <h4><%=UserDisplayName%></h4>
                                        <ul class="nav nav-pills d-flex flex-column" id="pills-tab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <a class="nav-link active btn btn-login mx-2 " id="pills-home-tab"   data-bs-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">
                                                    General Information
                                                </a>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <a class="nav-link btn btn-login mx-2"  id="pills-profile-tab" data-bs-toggle="pill"  href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">
                                                    Change Account Info
                                                </a>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <a class="nav-link btn btn-login mx-2"  id="pills-contact-tab" data-bs-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">
                                                    Change Password
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                                <div class="card mb-3" >
                                    <div class="card-body" style="margin: 55px 0">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">First Name</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%=FirstName%>               
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">Last Name</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%=LastName%>                
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">Display Name</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%=UserDisplayName%>                    
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">Email Address</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%=email%>                    </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">Username</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%=username%>                    </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h6 class="mb-0">Password</h6>
                                            </div>
                                            <div class="col-sm-9 text-secondary">
                                                <%
                                                    for (int i = 0; i < password.length(); i++) {
                                                        out.print("*");
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                                <div class="card px-5 pt-5 pb-4" >
                                    <form action="ChangeInfo" autocomplete="off">
                                        <div class="row mb-0">
                                            <div class="form-group">
                                                <label>
                                                    Enter The New First Name
                                                </label>
                                                <input type="text" name="NewFirstName" class="form-control w-100 d-inline-block" value="" /> 
                                            </div> 
                                            <div class="form-group">
                                                <label>
                                                    Enter The New Last Name
                                                </label>
                                                <input type="text" name="NewLastName" class="form-control w-100 d-inline-block" value="" /> 
                                            </div>
                                            <div class="form-group">
                                                <label>
                                                    New Display Name
                                                </label>
                                                <input type="text" name="NewDisplayName"  class="form-control" />
                                            </div>
                                            <input type="submit" class="btn btn-login mb-3" value="Submit Changes" />     
                                        </div>
                                    </form>   
                                </div>
                            </div>
                            <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                                <form action="ChangePassword" onsubmit="return check_form()">
                                    <div class="card px-5 pt-5 pb-4" >
                                        <div class="row mb-0">
                                            <div class="form-group">
                                                <label for="FirstName">
                                                    Enter The Current Password
                                                </label>
                                                <input type="password" name="CurrentPassword" value="" id="CurrentPasswordInput" oninput="Check_Password()" required  class="form-control w-100 d-inline-block" value="" /> 
                                                <p style="color: red;" id="CurrentPasswordErrorMessage"></p>
                                            </div> 
                                            <div class="form-group">
                                                <label for="LastName">
                                                    Enter The New Password
                                                </label>
                                                <input type="password" name="NewPassword" value="" id="NewPassword" required  class="form-control w-100 d-inline-block" value="" /> 
                                            </div>
                                            <div class="form-group">
                                                <label for="email">
                                                    Confirm The New Password
                                                </label>
                                                <input type="password" name="ConfirmNewPassword" value="" id="ConfirmNewPassword" oninput="Confirm_Password()" required   class="form-control" />
                                                <p style="color: red;" id="ConfirmNewPasswordErrorMessage"></p>                            </div>
                                            <input type="submit" class="btn btn-login mb-3" value="Submit Changes" />     
                                        </div>
                                    </div>
                                </form> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
        <script>
                                    function Check_Password() {
                                        var pass = "<%=password%>";
                                        var CurrentPasswordInput = document.getElementById("CurrentPasswordInput").value;
                                        if (CurrentPasswordInput === "") {
                                            document.getElementById("CurrentPasswordErrorMessage").innerHTML = "";
                                        } else {
                                            var xmlhttp = new XMLHttpRequest();
                                            xmlhttp.open("GET", "CheckPassword?CurrentPassword=" + pass + "&CurrentPasswordInput=" + CurrentPasswordInput, true);
                                            xmlhttp.send();
                                            xmlhttp.onreadystatechange = function () {
                                                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                                                    var msg = xmlhttp.responseText;
                                                    if (msg.length > 0) {
                                                        document.getElementById("CurrentPasswordErrorMessage").innerHTML = msg;
                                                    } else {
                                                        document.getElementById("CurrentPasswordErrorMessage").innerHTML = "";
                                                    }
                                                }

                                            };
                                        }
                                    }
                                    function Confirm_Password() {
                                        var NewPassword = document.getElementById("NewPassword").value;
                                        var ConfirmNewPassword = document.getElementById("ConfirmNewPassword").value;
                                        var xmlhttp = new XMLHttpRequest();
                                        xmlhttp.open("GET", "CheckConfirmPassword?NewPassword=" + NewPassword + "&ConfirmNewPassword=" + ConfirmNewPassword, true);
                                        xmlhttp.send();
                                        xmlhttp.onreadystatechange = function () {
                                            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                                                var msg = xmlhttp.responseText;
                                                if (msg.length > 0) {
                                                    document.getElementById("ConfirmNewPasswordErrorMessage").innerHTML = msg;
                                                } else {
                                                    document.getElementById("ConfirmNewPasswordErrorMessage").innerHTML = "";
                                                }
                                            }

                                        };
                                    }
                                    function check_form() {
                                        if (document.getElementById("ConfirmNewPasswordErrorMessage").innerHTML !== "" ||
                                                document.getElementById("CurrentPasswordErrorMessage").innerHTML !== "") {
                                            alert("cannot change password");
                                            return false;
                                        }
                                    }
        </script>
    </body>
</html>
