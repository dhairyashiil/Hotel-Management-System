package packageHotelManagement;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Scanner;

public class Reservation {
	
	    static private int reservationId;
	    private Date checkInTime;
	    private Date checkOutTime;
	    private int deposit;
	    int roomId;
	    int customerId;

	    static private int reservationCount=0;
	    static Connection conn = Conn.createConnection();
	    static String branchId = HotelManagement.branch_id;
	    static Scanner scanObj = new Scanner(System.in);

	    public Reservation() {}
	    
	    public Reservation(int roomId, int customerId, int reservationId, Date checkIn, Date checkOut, String branchId) {
			this.roomId=roomId;
			this.customerId=customerId;
			this.reservationId=reservationId;
			this.checkInTime=checkIn;
			this.checkOutTime=checkOut;
		}
	    
		public static void bookReservation() {
			
			Room objRoom = new Room();
			objRoom.getRoom();
			
			Reservation objReservation = new Reservation();
	        
			reservationCount();
	        
			objReservation.setReservationId(objReservation.getReservationCount());
	        
			int roomID, customerID;
	        System.out.println("Booking Reservation: ");
	        System.out.println("Enter following Data: ");
	        
	        System.out.println("Enter Room ID: ");
	        roomID = scanObj.nextInt();
	        scanObj.nextLine();
	        
	        System.out.println("Enter Customer ID: ");
	        customerID = scanObj.nextInt();
	        scanObj.nextLine();
	        
	        java.util.Date date = new java.util.Date();
	        java.sql.Date sqlDate = new java.sql.Date(date.getTime());  
	        StringBuilder queryBuilder = new StringBuilder();
	        queryBuilder.append("INSERT INTO RESERVATION ( ");
	        queryBuilder.append("RESERVATION_ID, BRANCH_ID, ROOM_ID, HotelCustomer_id, CHECK_IN ) ");
	        queryBuilder.append("VALUES( ?, ?, ?, ?, ?) ");
	        
	        try {
	            PreparedStatement preparedStatement = conn.prepareStatement(queryBuilder.toString());
	            preparedStatement.setInt(1, objReservation.getReservationId());
	            preparedStatement.setString(2, branchId);
	            preparedStatement.setInt(3, roomID);
	            preparedStatement.setInt(4, customerID);
	            preparedStatement.setDate(5, sqlDate);
	            preparedStatement.executeUpdate();
	            
	        } 
	        catch (SQLException e) {
	            e.printStackTrace();
	        }
	        changeRoomStatus(roomID, "YES");
	        
	        Customer objCustomer = new Customer(); 
	        objCustomer.insertCustomerData(roomID, customerID);
	    }
		
	    public static void cancelReservation() {
	        int roomNumber;
	        System.out.println("Cancel Reservation: ");
	        System.out.println("Enter Room Number: ");
	        roomNumber = scanObj.nextInt();
	        scanObj.nextLine();
	        String queryString = "DELETE FROM RESERVATION WHERE ROOM_ID = ? ";
	        try {
	            PreparedStatement preparedStatement = conn.prepareStatement(queryString);
	            preparedStatement.setInt(1, roomNumber);
	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        changeRoomStatus(roomNumber, "NO");
	    }
	    public static void changeRoomStatus(int roomId, String status) {
	        StringBuilder queryBuilder = new StringBuilder();
	        queryBuilder.append("UPDATE ROOM ");
	        queryBuilder.append("SET BOOKING_CHECK = ? ");
	        queryBuilder.append("WHERE ROOM_ID = ? ");
	        try {
	            PreparedStatement preparedStatement = conn.prepareStatement(queryBuilder.toString());
	            preparedStatement.setString(1, status);
	            preparedStatement.setInt(2, roomId);
	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    public static void reservationCount() {
	    	
	    	Reservation objReservation = new Reservation();
	    	
	        try {
	            PreparedStatement preparedStatement = conn.prepareStatement("SELECT MAX(RESERVATION_ID) FROM RESERVATION");
	            ResultSet resultSet = preparedStatement.executeQuery();
	            while (resultSet.next()) {
	            	objReservation.setReservationCount(resultSet.getInt(1));
	            }
	        } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }
	    
	    private static void getReservation() {
	    
	    	Scanner sc = new Scanner(System.in);
	    	
	        System.out.println("You want all reservation details or someone specific ? ");
	        System.out.println("Enter 1 : for all customers");
	        System.out.println("Enter 2 : for specific customer");
	        int key = sc.nextInt();
	        sc.nextLine();
	        
	        switch (key) {
	        case 1: {
	            String selectAllSql = "SELECT * FROM Reservation";
	            Statement selectAllCustomersStmt = null;
	            ResultSet rs = null;
	            ArrayList<Reservation> reservationList = new ArrayList<>();

	            try {
	                selectAllCustomersStmt = conn.createStatement();
	                rs = selectAllCustomersStmt.executeQuery(selectAllSql);
	                while (rs.next()) {
	                    int roomId = rs.getInt("room_id");
	                    int customerId = rs.getInt("HotelCustomer_id");
	                    int reservationId = rs.getInt("reservation_id");
	                    Date checkIn=rs.getDate("check_in");
	                    Date checkOut=rs.getDate("check_out");
	                    String branchId = rs.getString("branch_id");
	                    
	                    Reservation obj1 = new Reservation(roomId,customerId,reservationId,checkIn,checkOut, branchId);
	                    
	                    reservationList.add(obj1);
	                }
	                for (Reservation r : reservationList) {
	                    System.out.println("\nReservation ID: " + r.reservationId);
	                    System.out.println("Room ID: " + r.roomId);
	                    System.out.println("Customer ID: " + r.customerId);
	                    System.out.println("Check-In Date: " + r.checkInTime);
	                    System.out.println("Check-Out Date: " + r.checkOutTime);
	                    System.out.println("Branch-ID: " + branchId);
	                }
	            } 
	            catch (SQLException e) {
	                e.printStackTrace();
	            } 
	            finally {
	                try {
	                    rs.close();
	                    selectAllCustomersStmt.close();
	                    conn.close();
	                } 
	                catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	            break;
	        }
	        case 2: {
	        	ArrayList<Reservation> reservationList = new ArrayList<>();
	            String selectSpecificSql = "SELECT * FROM Reservation WHERE HotelCustomer_id = ?";
	            PreparedStatement selectCustomerWithIDStmt = null;
	            ResultSet rs = null;
	            
	            try {
	                selectCustomerWithIDStmt = conn.prepareStatement(selectSpecificSql);
	                System.out.println("Enter the Hotel Customer Id : ");
	                sc.nextLine();
	                String specificID = sc.nextLine();
	                selectCustomerWithIDStmt.setString(1, specificID);
	                rs = selectCustomerWithIDStmt.executeQuery();
	                while (rs.next()) {
	                	int roomId = rs.getInt("room_id");
	                    int customerId = rs.getInt("HotelCustomer_id");
	                    int reservationId = rs.getInt("reservation_id");
	                    Date checkIn=rs.getDate("check_in");
	                    Date checkOut=rs.getDate("check_out");
	                    String branchId = rs.getString("branch_id");
	                    Reservation obj1 = new Reservation(roomId,customerId,reservationId,checkIn,checkOut, branchId);
	                    reservationList.add(obj1);
	                }
	                for (Reservation r : reservationList) {
	                    System.out.println("\nReservation ID: " + r.reservationId);
	                    System.out.println("Room ID: " + r.roomId);
	                    System.out.println("Customer ID: " + r.customerId);
	                    System.out.println("Check-In Date: " + r.checkInTime);
	                    System.out.println("Check-Out Date: " + r.checkOutTime);
	                    System.out.println("Branch-ID: " + branchId);
	                }
	            } 
	            catch (SQLException e) {
	                e.printStackTrace();
	            } 
	            finally {
	                try {
	                    rs.close();
	                    selectCustomerWithIDStmt.close();
	                    conn.close();
	                } 
	                catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	            break;
	        }
	        default:
	            throw new IllegalArgumentException("Unexpected value: " + key);
	        }
	    }	
			
		
	    public void reservationManagement() {
	    	System.out.println("1.BOOK RESERVATION");
			System.out.println("2.CANCEL RESERVATION");
			System.out.println("3.DETAILS OF RESERVATION");
			
			Scanner sc = new Scanner(System.in);
			int choice=sc.nextInt();
			sc.nextLine();
			
			switch (choice) {
			case 1:
				bookReservation();
				break;
			case 2:
				cancelReservation();
				break;
			case 3:
				getReservation();
				break;
			default:
				System.out.println("INVALID CHOICE");
				break;
			}
	    }

	    public static int getReservationId() {
	    	return reservationId;
	    }
	    
	    public static void setReservationId(int reservationId) {
	    	Reservation.reservationId = reservationId;
	    }
	    
	    public static int getReservationCount() {
	    	return reservationCount;
	    }
	    
	    public static void setReservationCount(int reservationCount) {
	    	Reservation.reservationCount = reservationCount + 1;
	    }
}
