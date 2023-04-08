package packageHotelManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;
import java.util.TreeMap;

public class HotelCustomersBilling {
	
	static Connection conn = Conn.createConnection();
	
	public void main() {
		HotelCustomersBilling obj1 = new HotelCustomersBilling();
		int totalBill = obj1.calulateTotalBill();
		System.out.println("\nTotal Bill of Customer is : " + totalBill);
	}
	
	public int calulateTotalBill() {
		
		int roomBill = calulateRoomBill();
		int serviceBill = calulateServiceBill();
		int penaltyCharges = calulatePenalty();
		
		return roomBill + serviceBill + penaltyCharges;
	}
	
	public int calulateRoomBill() {
		
		int roomBill = 0;
		PreparedStatement roomBillStmt = null;
		ResultSet rs = null;

		Scanner sc = new Scanner(System.in);
		
		System.out.println("\nEnter the room ID to find it's price :");
		int roomId = sc.nextInt();
		sc.nextLine();
		
		setCheckOutDate(roomId);
		int days = calcDays(roomId);

		try {
		    
		    String roomBillQuery = "SELECT room_price FROM room WHERE room_id = ?";
		    roomBillStmt = conn.prepareStatement(roomBillQuery);
		    roomBillStmt.setInt(1, roomId);
		    
		    rs = roomBillStmt.executeQuery();

		    if (rs.next()) {
		    	roomBill = rs.getInt("room_price") * days;
		    } 
		    else {
		        System.out.println("Room not found.");
		    }
		    
		    System.out.println("Room bill for room ID : " + roomId + " is " + roomBill);
		    
		    
		} 
		catch (SQLException e) {
		    e.printStackTrace();
		} 
		finally {
		    try {
		        if (rs != null) {
		            rs.close();
		        }
		        if (roomBillStmt != null) {
		        	roomBillStmt.close();
		        }
		        if (conn != null) {
		            conn.close();
		        }
		    } 
		    catch (SQLException e) {
		        e.printStackTrace();
		    }
		}
		return roomBill;
	}
	
	public static void setCheckOutDate(int roomId) {
        
		try {
        
			StringBuilder queryBuilder = new StringBuilder();
            queryBuilder.append("UPDATE RESERVATION ");
            queryBuilder.append("SET CHECK_OUT_TIME = ? ");
            queryBuilder.append("WHERE ROOM_ID = ? ");
            
            PreparedStatement preparedStatement = conn.prepareStatement(queryBuilder.toString());
            java.util.Date date = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());  
            
            preparedStatement.setDate(1, sqlDate);
            preparedStatement.setInt(2, roomId);
            preparedStatement.executeQuery();
        } 
		catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	public static int calcDays(int roomId) {
		
        double days = 0;
        
        try {
        
        	java.sql.Date checkInDate = null;
            java.sql.Date checkOutDate = null;
            
            String queryString = "SELECT CHECK_IN_TIME, CHECK_OUT_TIME FROM RESERVATION WHERE ROOM_ID = ?";
            
            PreparedStatement preparedStatement = conn.prepareStatement(queryString);
            
            preparedStatement.setInt(1, roomId);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                checkInDate = resultSet.getDate(1);
                checkOutDate = resultSet.getDate(2);
            }
            
            Calendar calCheckIn = Calendar.getInstance();
            Calendar calCheckOut = Calendar.getInstance();
            
            calCheckIn.setTime(checkInDate);
            calCheckOut.setTime(checkOutDate);
            
            long checkIn = calCheckIn.getTimeInMillis();
            long checkOut = calCheckOut.getTimeInMillis();
            
            long millisecs = checkOut - checkIn;
            
            double secs = (double)millisecs/1000;
            double mins = (double)secs/60;
            double hours = (double)mins/60;
            
            days = (double)hours/24;
        } 
        catch (SQLException e) {
        	e.printStackTrace();
        }
        return (int)Math.ceil(days);
    }
	
	public TreeMap<Integer, Integer> mapServiceIDwithServicePrice() {
		
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    TreeMap<Integer, Integer> serviceMap = new TreeMap<>();
	        
	    try {
	    	
	        String sql = "SELECT service_id, service_price FROM service";
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	        	int serviceId = rs.getInt("service_id");
	            int servicePrice = rs.getInt("service_price");
	            serviceMap.put(serviceId, servicePrice);
	        }

//	        for (Map.Entry<Integer, Integer> entry : serviceMap.entrySet()) {
//	        	System.out.println("Service ID: " + entry.getKey() + ", Service Price: " + entry.getValue());
//	        }

	    } 
	    catch (SQLException e) {
	    	System.out.println(e.getMessage());
	    } 
	    finally {
	    	try {
	    		if (rs != null) {
	    			rs.close();
	    		}
	            if (stmt != null) {
	            	stmt.close();
	            }
	            if (conn != null) {
	            	conn.close();
	            }
	    	} 
	    	catch (SQLException ex) {
	    		System.out.println(ex.getMessage());
	    	}
	    }
		return serviceMap;
	}

	
	public int calulateServiceBill() {
		
		int serviceBill = 0;
		
		PreparedStatement serviceBillStmt = null;
		ResultSet rs = null;

		Scanner sc = new Scanner(System.in);

		System.out.println("\nEnter the Hotel Customer ID to See his/her taken services :");
		int HotelCustomer_id = sc.nextInt();
		sc.nextLine();

		try {
		    
		    TreeMap<Integer, Integer> serviceMap = new TreeMap<>();
		    serviceMap = mapServiceIDwithServicePrice();
		    
		    String customersServiceBillQuery = "SELECT service_id FROM customersService WHERE HotelCustomer_id = ? ";
		    
		    serviceBillStmt = conn.prepareStatement(customersServiceBillQuery);
		    serviceBillStmt.setInt(1, HotelCustomer_id);
		    
		    rs = serviceBillStmt.executeQuery();
		    
		    ArrayList<Integer> serviceList = new ArrayList<>();
		    
		    while (rs.next()) {
		        int serviceID = rs.getInt("service_id");
		        serviceList.add(serviceID);
		    }
		    
		    
		    
		    for (int i = 0; i < serviceList.size(); i++) {
		        int serviceID = serviceList.get(i);
		        int servicePrice = serviceMap.get(serviceID);
		        serviceBill += servicePrice;
		    }
		    
		    System.out.println("Service Bill for customer " + HotelCustomer_id + " is " + serviceBill);
		    
		    
		} 
		catch (SQLException e) {
		    e.printStackTrace();
		} 
		finally {
		    try {
		        conn.close();
		        serviceBillStmt.close();
		        rs.close();
		    } 
		    catch (SQLException e) {
		        e.printStackTrace();
		    }
		}
		return serviceBill;
	}
	
	public int calulatePenalty() {
		
		System.out.println("Is Customer damaged any kind of hotel property ?");
		System.out.println("If YES : Enter penalty Charges");
		System.out.println("If NO : Enter 0 (zero)");

		Scanner sc = new Scanner(System.in);
		int penaltyCharges = sc.nextInt();
		sc.nextLine();
		
		return penaltyCharges;
	}
}
