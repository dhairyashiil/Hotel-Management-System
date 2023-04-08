package packageHotelManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Branch {
	
    private String branchName;
    private String branchLocation;
    private int capacity;
    private int availableCapacity;
    static String branchId = HotelManagement.branch_id;
    // static Connection connection = HotelManagement.createConnection();
    static Connection connection = Conn.createConnection();
    Statement stmt=null;
    PreparedStatement pstmt = null;
    
    public void branchMangement() {
		System.out.println("1.DETAILS OF BRANCH: ");
		System.out.println("2.AVAILABLE CAPACITY: ");
		Scanner sc = new Scanner(System.in);
		int choice=sc.nextInt();
		switch (choice) {
		case 1:
			getBranchDetails();
			break;
		case 2:
			setAvailableCapacity();
			System.out.println("Available capacity of branch with ID = "+HotelManagement.branch_id+" is = "+getAvailableCapacity());
			break;
		default:
			break;
		}
    }
    
    public void getBranchDetails() {     
        try {
        	
            String query = "SELECT * FROM branch WHERE branch_id = ?";
            
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, branchId);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                setBranchName(resultSet.getString(2));
                setBranchLocation(resultSet.getString(3));
                setCapacity(resultSet.getInt(5));
                setAvailableCapacity();
            }
        } 
        catch (SQLException e) {     
        	e.printStackTrace();
        }
        displayBranchDetails();
    }
    
    public void displayBranchDetails() {
        System.out.println("Branch Details");
        System.out.println("Branch Name: " + getBranchName());
        System.out.println("Branch ID: " + branchId);
        System.out.println("Branch Location: " + getBranchLocation());
        System.out.println("Branch Capacity: " + getCapacity());
        System.out.println("Branch Available Capacity: " + getAvailableCapacity());
    }
    
    public String getBranchName() {
        return branchName;
    }
    
    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }
    
    public String getBranchLocation() {
        return branchLocation;
    }
    
    public void setBranchLocation(String branchLocation) {
    	this.branchLocation = branchLocation;
    }
    
    public int getCapacity() {
        return capacity;
    }
    
    public void setCapacity(int capacity) {
    	this.capacity = capacity;
    }
    
    public int getAvailableCapacity() {
        return availableCapacity;
    }
    
    public void setAvailableCapacity() {
    
       String query2="SELECT COUNT(BOOKING_CHECK) FROM ROOM WHERE BOOKING_CHECK='No' AND BRANCH_ID = ?";
     
       try {
    	   pstmt = connection.prepareStatement(query2);
    	   pstmt.setString(1, branchId);
    	   
    	   ResultSet resultSet = pstmt.executeQuery();
			
    	   if(resultSet.next()) {
    		   availableCapacity=resultSet.getInt(1);
    		   //System.out.println(availableCapacity);
    	   }
       } 
       catch (SQLException e) {
			e.printStackTrace();
		}
    }
}
