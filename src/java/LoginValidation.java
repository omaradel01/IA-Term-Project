/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Omar
 */
@WebServlet(urlPatterns = {"/LoginValidation"})
public class LoginValidation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
                // Error
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
