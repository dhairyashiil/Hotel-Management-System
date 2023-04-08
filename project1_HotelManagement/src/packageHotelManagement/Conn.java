package packageHotelManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Conn {
	
    public static Connection createConnection(){
    	
        Connection conn=null;
        Properties props = new Properties();
        
        try (FileInputStream inputFile = new FileInputStream("C:\\Users\\Dhairyashil Shinde\\eclipse-workspace\\project1_HotelManagement\\properties.txt")) {
            props.load(inputFile);
        } 
        catch (IOException e) {
            System.out.println("Error while connecting to the database: " + e.getMessage());
        }
        
        String url = props.getProperty("DB_URL");
        String user = props.getProperty("USER");
        String password = props.getProperty("PASS");
        
        try {
             conn = DriverManager.getConnection(url, user, password);  
        } catch (SQLException e) {
            System.out.println("Error while connecting to the database: " + e.getMessage());
        }
        
        return conn;
    }
}