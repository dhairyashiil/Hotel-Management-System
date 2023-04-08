package packageHotelManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class Feedback {
	
	static Connection conn = Conn.createConnection();
	
	public void takeFeedbackFromCustomer() {
		
		PreparedStatement insertStmt = null;
        Scanner sc = new Scanner(System.in);
        
        String insertSql = "INSERT INTO Customer_Feedback (feedback_id, HotelCustomer_id, feedback_date, "
        		+ "roomFeedback, facilityFeedback, servicesFeedback, feedback_comment) VALUES (?, ?, SYSDATE, ?, ?, ?, ?)";
        
        try {
            insertStmt = conn.prepareStatement(insertSql);
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        
        int feedback_id;
        int customer_id;
        int roomFeedback;
    	int facilityFeedback;
    	int servicesFeedback;
    	String feedback_comment;
		
		System.out.println("How many Customers Feedback you want to take ? ");
		int repetition = sc.nextInt();
		sc.nextLine();
		
		while(repetition > 0) {
			
			System.out.println("Enter Feedback ID ");
			feedback_id = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Enter Customer ID ");
			customer_id = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Feedback on our Rooms (Enter Number from 1(Bad) to 10(Good))");
			roomFeedback = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Feedback on our Facility (Enter Number from 1(Bad) to 10(Good))");
			facilityFeedback = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Feedback on our Services (Enter Number from 1(Bad) to 10(Good))");
			servicesFeedback = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Anything Else you want to give feedback on ? ");
			feedback_comment = sc.next();
			
			try {
            	insertStmt.setInt(1, feedback_id);
            	insertStmt.setInt(2, customer_id);
                insertStmt.setInt(3, roomFeedback);
                insertStmt.setInt(4, facilityFeedback);
                insertStmt.setInt(5, servicesFeedback);
                insertStmt.setString(6, feedback_comment);
                insertStmt.addBatch();
            } 
            catch (SQLException e) {
                e.printStackTrace();
            }
			repetition--;
		}
		
		try {
			insertStmt.executeBatch();
			System.out.println("\nInserted all the records in HotelCustomer Table.");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
        
	}	
}
