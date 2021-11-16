/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Omar
 */
@WebServlet(urlPatterns = {"/ValidateLogin"})
public class ValidateLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, ClassNotFoundException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String username_or_email = request.getParameter("username_or_email");
            String password = request.getParameter("password");
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            Stmt = (Statement) Con.createStatement();
            ResultSet resultSet = Stmt.executeQuery("SELECT * FROM reservation");
            while (resultSet.next()) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date date1 = new Date();
                String CheckOutDate = resultSet.getString("CheckOutDate");
                Date date3 = formatter.parse(CheckOutDate);
                int DaysDiff = (int) ((date1.getTime() - date3.getTime()) / (1000 * 60 * 60 * 24));
                if (DaysDiff >= 0 && resultSet.getString("Running").equals("1")) {
                    Stmt = (Statement) Con.createStatement();
                    Stmt.executeUpdate("UPDATE reservation SET Running = " + 0 + " WHERE ReservationID = "
                            + Integer.parseInt(resultSet.getString("ReservationID")));
                    Stmt = (Statement) Con.createStatement();
                    ResultSet RSCityHotel = Stmt.executeQuery("SELECT * FROM city_hotel WHERE CityID = "
                            + resultSet.getString("CityID") + " AND HotelID = " + resultSet.getString("HotelID"));
                    RSCityHotel.first();
                    Stmt.executeUpdate("UPDATE city_hotel SET AvailableRooms = "
                            + (Integer.parseInt(RSCityHotel.getString("AvailableRooms")) + Integer.parseInt(resultSet.getString("NumberOfRooms")))
                            + " WHERE CityHotelID = " + Integer.parseInt(RSCityHotel.getString("CityHotelID")));
                    continue;
                }
                
                String CheckInDate = resultSet.getString("CheckInDate");
                Date date2 = formatter.parse(CheckInDate);
                DaysDiff = (int) ((date2.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));
                if (DaysDiff <= 0 && resultSet.getString("Confirmed").equals("1") && resultSet.getString("Canceled").equals("0")
                        && resultSet.getString("Running").equals("0")) {
                    Stmt = (Statement) Con.createStatement();
                    Stmt.executeUpdate("UPDATE reservation SET Running = " + 1 + " WHERE ReservationID = "
                            + Integer.parseInt(resultSet.getString("ReservationID")));
                    Stmt = (Statement) Con.createStatement();
                    ResultSet RSCityHotel = Stmt.executeQuery("SELECT * FROM city_hotel WHERE CityID = "
                            + resultSet.getString("CityID") + " AND HotelID = " + resultSet.getString("HotelID"));
                    RSCityHotel.first();
                    Stmt = (Statement) Con.createStatement();
                    Stmt.executeUpdate("UPDATE city_hotel SET AvailableRooms = "
                            + (Integer.parseInt(RSCityHotel.getString("AvailableRooms")) - Integer.parseInt(resultSet.getString("NumberOfRooms")))
                            + " WHERE CityHotelID = " + Integer.parseInt(RSCityHotel.getString("CityHotelID")));
                }
                
            }

            Stmt = (Statement) Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM users");
            boolean valide = false, is_admin = false;
            String UserDisplayName = "", FirstName = "", LastName = "", email = "", username = "", IsAdmin = "0", ID = "";
            while (RS.next()) {
                if (RS.getString("UserPassword").equals(password)
                        && (RS.getString("UserName").equals(username_or_email)
                        || RS.getString("UserEmail").equals(username_or_email))) {
                    valide = true;
                    if (RS.getString("is_admin").equals("1")) {
                        is_admin = true;
                        IsAdmin = "1";
                    }
                    email = RS.getString("UserEmail");
                    username = RS.getString("UserName");
                    UserDisplayName = RS.getString("UserDisplayName");
                    FirstName = RS.getString("UserFirstName");
                    LastName = RS.getString("UserLastName");
                    ID = RS.getString("UserID");
                    break;
                }
            }
            if (valide && is_admin) {
                HttpSession session = request.getSession(true);
                session.setAttribute("session_username_or_email", username_or_email);
                session.setAttribute("session_UserDisplayName", UserDisplayName);
                session.setAttribute("session_UserFirstName", FirstName);
                session.setAttribute("session_UserLastName", LastName);
                session.setAttribute("session_username", username);
                session.setAttribute("session_email", email);
                session.setAttribute("session_passowrd", password);
                session.setAttribute("session_IsAdmin", IsAdmin);
                session.setAttribute("session_UserID", ID);
                response.sendRedirect("AdminHome.jsp");
            } else if (valide && !is_admin) {
                HttpSession session = request.getSession(true);
                session.setAttribute("session_username_or_email", username_or_email);
                session.setAttribute("session_UserDisplayName", UserDisplayName);
                session.setAttribute("session_UserFirstName", FirstName);
                session.setAttribute("session_UserLastName", LastName);
                session.setAttribute("session_username", username);
                session.setAttribute("session_email", email);
                session.setAttribute("session_passowrd", password);
                session.setAttribute("session_IsAdmin", IsAdmin);
                session.setAttribute("session_UserID", ID);
                response.sendRedirect("ClientHome.jsp");
            } else {
                out.println("<!DOCTYPE html>\n"
                        + "<!--\n"
                        + "To change this license header, choose License Headers in Project Properties.\n"
                        + "To change this template file, choose Tools | Templates\n"
                        + "and open the template in the editor.\n"
                        + "-->\n"
                        + "<html>\n"
                        + "    <head>\n"
                        + "        <script>\n"
                        + "            function validateForm() {\n"
                        + "                var x = document.forms[\"LoginForm\"][\"username_or_email\"].value;\n"
                        + "                var y = document.forms[\"LoginForm\"][\"password\"].value;\n"
                        + "                if (x === \"\" && y === \"\") {\n"
                        + "                    alert(\"username or email and password must be filled out\");\n"
                        + "                    return false;\n"
                        + "                }\n"
                        + "                if (x === \"\") {\n"
                        + "                    alert(\"username or email must be filled out\");\n"
                        + "                    return false;\n"
                        + "                }\n"
                        + "                if (y === \"\") {\n"
                        + "                    alert(\"password must be filled out\");\n"
                        + "                    return false;\n"
                        + "                }\n"
                        + "            }\n"
                        + "        </script>\n"
                        + "        <title>Hotel Reservation</title>\n"
                        + "        <meta charset=\"UTF-8\">\n"
                        + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "        <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\n"
                        + "        <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">\n"
                        + "        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\"/>\n"
                        + "        <link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap\" rel=\"stylesheet\">\n"
                        + "        <link rel=\"stylesheet\" href=\"css/all.min.css\">\n"
                        + "        <link rel=\"stylesheet\" href=\"css/styles.css\">\n"
                        + "\n"
                        + "    </head> \n"
                        + "    <body>\n"
                        + "        <div class=\"banner-login\">\n"
                        + "            <div class=\"container\">\n"
                        + "                <div class=\"row align-items-center\">\n"
                        + "                    <div class=\"form-login\">\n"
                        + "                        <div class=\"col-md-12\">\n"
                        + "                            <span class=\"login-form-logo\">\n"
                        + "                                <i class=\"fas fa-user\"></i>\n"
                        + "                            </span>\n"
                        + "                            <h1 class=\"header-1 text-center main-color\">Log In</h1>\n"
                        + "                            <form action=\"ValidateLogin\" name=\"LoginForm\" onsubmit=\"return validateForm()\" autocomplete=\"off\">\n"
                        + "                                <div class=\"form-group\">\n"
                        + "                                    <label for=\"username_or_email\">\n"
                        + "                                        Enter your Username or Email\n"
                        + "                                    </label>\n"
                        + "                                    <input type=\"text\" name=\"username_or_email\" class=\"form-control\" value=\"\" /> \n"
                        + "                                </div>\n"
                        + "                                <div class=\"form-group\">\n"
                        + "                                    <label for=\"password\">\n"
                        + "                                        Enter your Password\n"
                        + "                                    </label>\n"
                        + "                                    <input type=\"password\" name=\"password\" class=\"form-control\" value=\"\" /> \n"
                        + "                                </div>\n"
                        + "                                <input type=\"submit\" value=\"Login\" class=\"btn btn-block w-100 btn-login\" />\n"
                        + "                            </form>\n"
                        + "                        </div>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "<script>\n"
                        + "alert(\"wrong username or email or password!!\");\n"
                        + "window.location.href = \"Login.html\";\n"
                        + "</script>\n"
                        + "    </body>\n"
                        + "</html>\n"
                        + "");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ValidateLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ValidateLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ValidateLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ValidateLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
