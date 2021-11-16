/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
@WebServlet(urlPatterns = {"/MakeReservation"})
public class MakeReservation extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
            String user = "root";
            String pass = "17091999";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, pass);

            Stmt = (Statement) Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM city_hotel WHERE city_hotel.CityHotelID = "
                    + Integer.parseInt(request.getSession().getAttribute("session_CityHotelID").toString()));
            RS.first();

            Stmt = (Statement) Con.createStatement();
            Stmt.executeUpdate("INSERT INTO reservation(UserID, HotelID, CityID, ReservationType, CheckInDate, CheckOutDate, TotalPrice, "
                    + "NumberOfRooms, NumberOfAdults, NumberOfChildren, Confirmed, Running, Canceled) VALUES("
                    + Integer.parseInt(request.getSession().getAttribute("session_UserID").toString()) + ", "
                    + Integer.parseInt(RS.getString("HotelID")) + ", "
                    + Integer.parseInt(RS.getString("CityID")) + ", "
                    + "'" + request.getParameter("BoardType") + "', "
                    + "'" + request.getParameter("CheckInDate") + "', "
                    + "'" + request.getParameter("CheckOutDate") + "', "
                    + "'" + Float.parseFloat(request.getParameter("Price")) + "', "
                    + Integer.parseInt(request.getParameter("NumberOfRooms")) + ", "
                    + Integer.parseInt(request.getParameter("NumberOfAdults")) + ", "
                    + Integer.parseInt(request.getParameter("NumberOfChildren")) + ", "
                    + 0 + ", " + 0 + ", " + 0
                    + ")");
            response.sendRedirect("ClientHome.jsp");
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
            Logger.getLogger(MakeReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MakeReservation.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(MakeReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MakeReservation.class.getName()).log(Level.SEVERE, null, ex);
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
