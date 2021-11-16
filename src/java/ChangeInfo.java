/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Omar
 */
@WebServlet(urlPatterns = {"/ChangeInfo"})
public class ChangeInfo extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String NewDisplayName = request.getParameter("NewDisplayName");
            String NewFirstName = request.getParameter("NewFirstName");
            String NewLastName = request.getParameter("NewLastName");
            String username = request.getSession().getAttribute("session_username").toString();
            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);
            if(NewDisplayName.length() > 0){
                Stmt = Con.createStatement();
                Stmt.executeUpdate("UPDATE users set UserDisplayName = '" + NewDisplayName + "' where UserName = '" + username + "';");
                request.getSession().setAttribute("session_UserDisplayName", NewDisplayName);
            }
            if(NewFirstName.length() > 0){
                Stmt = Con.createStatement();
                Stmt.executeUpdate("UPDATE users set UserDisplayName = '" + NewFirstName + "' where UserName = '" + username + "';");
                request.getSession().setAttribute("session_UserFirstName", NewFirstName);
            }
            if(NewLastName.length() > 0){
                Stmt = Con.createStatement();
                Stmt.executeUpdate("UPDATE users set UserDisplayName = '" + NewLastName + "' where UserName = '" + username + "';");
                request.getSession().setAttribute("session_UserLastName", NewLastName);
            }
            if(request.getSession().getAttribute("session_IsAdmin").toString().equals("1")){
                response.sendRedirect("AdminHome.jsp");
            }
            else{
                response.sendRedirect("ClientHome.jsp");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ChangeInfo.class.getName()).log(Level.SEVERE, null, ex);
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
