package newpackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class Mail {

    public void send_email(String toEmail, String password) throws AddressException, MessagingException {
        String fromEmail = "hotelshero.reservation@gmail.com";
        String pass = "omar17091999";

        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.socketFactory.port", "587");
        pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(pr, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, pass);
            }
        });

        Message mess = new MimeMessage(session);
        mess.setFrom(new InternetAddress(fromEmail));
        mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        mess.setSubject("Your Hotels Hero Account Password");
        mess.setText("Thank you for registering in our Website. Your Passowrd is " + password
                + ". You can then change it in your account settings.");

        Transport.send(mess);
    }

    public void send_cancelation_email(String username, String toEmail, ResultSet RSReservation) throws AddressException, MessagingException, ClassNotFoundException, SQLException {
        String fromEmail = "hotelshero.reservation@gmail.com";
        String pass = "omar17091999";
        
        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.socketFactory.port", "587");
        pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(pr, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, pass);
            }
        });

        String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
        String user = "root";
        String password = "17091999";
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RSCity = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        RSCity = Stmt.executeQuery("SELECT * FROM city WHERE CityID = " + Integer.parseInt(RSReservation.getString("CityID")));
        RSCity.first();
        
        Stmt = Con.createStatement();
        ResultSet RSHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = " + Integer.parseInt(RSReservation.getString("HotelID")));
        RSHotel.first();
        
        Message mess = new MimeMessage(session);
        mess.setFrom(new InternetAddress(fromEmail));
        mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        mess.setSubject("Reservation Cancellation Email");
        mess.setText("Dear " + username + "\n" + "This is an email to inform you about the cancelation of a reservation." + 
                "\nReservation Details:\n" + 
                "Hotel Name: " +  RSHotel.getString("HotelName") + "\nCity: " + RSCity.getString("CityName") + 
                "\nCheck in Date: " + RSReservation.getString("CheckInDate") + "\nCheck out Date: " + RSReservation.getString("CheckOutDate") + 
                "\nNumber of rooms: " + RSReservation.getString("NumberOfRooms") + "\nNumber of Adults: " + RSReservation.getString("NumberOfAdults") + 
                "\nNumber of children: " + RSReservation.getString("NumberOfChildren") + 
                "\nPrice: " + RSReservation.getString("TotalPrice") + ".");
        Transport.send(mess);
    }
    
    public void send_confirmation_email(String username, String toEmail, ResultSet RSReservation) throws AddressException, MessagingException, ClassNotFoundException, SQLException {
        String fromEmail = "hotelshero.reservation@gmail.com";
        String pass = "omar17091999";

        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.socketFactory.port", "587");
        pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        Session session = Session.getInstance(pr, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, pass);
            }
        });
        
        String url = "jdbc:mysql://localhost:3306/hotel_reservation_system";
        String user = "root";
        String password = "17091999";
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RSCity = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        RSCity = Stmt.executeQuery("SELECT * FROM city WHERE CityID = " + Integer.parseInt(RSReservation.getString("CityID")));
        RSCity.first();
        
        Stmt = Con.createStatement();
        ResultSet RSHotel = Stmt.executeQuery("SELECT * FROM hotel WHERE HotelID = " + Integer.parseInt(RSReservation.getString("HotelID")));
        RSHotel.first();
        
        Message mess = new MimeMessage(session);
        mess.setFrom(new InternetAddress(fromEmail));
        mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        mess.setSubject("Reservation Confirmation Email");
        mess.setText("Dear " + username + "\n" + "This is an email to inform you about the confirmation of a reservation." + 
                "\nReservation Details:\n" + 
                "Hotel Name: " +  RSHotel.getString("HotelName") + "\nCity: " + RSCity.getString("CityName") + 
                "\nCheck in Date: " + RSReservation.getString("CheckInDate") + "\nCheck out Date: " + RSReservation.getString("CheckOutDate") + 
                "\nNumber of rooms: " + RSReservation.getString("NumberOfRooms") + "\nNumber of Adults: " + RSReservation.getString("NumberOfAdults") + 
                "\nNumber of children: " + RSReservation.getString("NumberOfChildren") + 
                "\nPrice: " + RSReservation.getString("TotalPrice") + ".");
        Transport.send(mess);
    }

    public static void main(String args[]) throws MessagingException {

    }
}
