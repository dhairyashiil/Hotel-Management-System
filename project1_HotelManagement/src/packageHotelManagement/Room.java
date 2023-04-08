package packageHotelManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Room {
	
	 int roomNumber;
	 String roomType;
	 int price;
	 String cleaningStatus;
	 String bookingStatus;
	 String branchId ;
	 
	 static int value;
	 static PreparedStatement stmt = null;
	 // static Connection connection = HotelManagement.createConnection();
	 static Connection connection = Conn.createConnection();
	 static ArrayList<Room> RoomList = new ArrayList<>();
	 
	 public Room() {}
	 
	 public Room(int roomNumber, String roomType, String cleaningStatus, String bookingStatus, int price, String branchId) {		 
			this.roomNumber=roomNumber;
			this.roomType=roomType;
			this.cleaningStatus=cleaningStatus;
			this.bookingStatus=bookingStatus;
			this.price=price;
			this.branchId=branchId;
		}
	 
	 public void addRoom() {
		 
			Scanner sc = new Scanner(System.in);
		
			System.out.println("Enter room number");
			int roomNumber = sc.nextInt();
			sc.nextLine();
			
			System.out.println("Enter room type");
			String roomType = sc.next();
			
			System.out.println("Cleaning status");
			String cleaningStatus = sc.next();
			
			System.out.println("Booking status");
			String bookingStatus = sc.next();
			System.out.println("Enter price");
			int price = sc.nextInt();
			sc.nextLine();
	
			String query = "insert into room values(?,?,?,?,?,?)";
			try {
				stmt=connection.prepareStatement(query);
				stmt.setInt(1, roomNumber);
				stmt.setString(2, roomType);
				stmt.setString(3, cleaningStatus);
				stmt.setString(4, bookingStatus);
				stmt.setInt(5, price);
				stmt.setString(6, HotelManagement.branch_id);
				int count = stmt.executeUpdate();
				System.out.println(count+" Rows updated\n");
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	 
		public void getRoom() {
			Scanner sc = new Scanner(System.in);
			//ArrayList<Room> RoomList = new ArrayList<>();
			System.out.println("1.SHOW ONLY AVAILABLE ROOMS");
			System.out.println("2.SHOW ALL ROOMS");
			System.out.println("3.SHOW ONLY OCCUPIED ROOMS");
			int choice = sc.nextInt();
			sc.nextLine();
			
			String query="";
			if(choice==1) {
				 query="select * from room where branch_id=? AND booking_check='NO'";
			}
			else if(choice==2){
				query="select * from room where branch_id=?";	
			}
			else if(choice==3){
				 query="select * from room where branch_id=? AND booking_check='Yes'";
			}
			else {
				System.out.println("Invalid choice");
			}
			try {
				System.out.println(query);
				stmt=connection.prepareStatement(query);
				stmt.setString(1, HotelManagement.branch_id);
				ResultSet rs=stmt.executeQuery();
		
				while(rs.next()){
					
					int roomNumber = rs.getInt("room_id");
		            String roomType = rs.getString("room_type");
		            String cleaningStatus = rs.getString("cleaning_check");
		            String bookingStatus = rs.getString("booking_check");
		            int price= rs.getInt("room_price");
		            String branchId = rs.getString("branch_id");
		            Room obj = new Room(roomNumber, roomType, cleaningStatus, bookingStatus, price, branchId);
		            RoomList.add(obj);
				}
				// Display specific/all discount of that room
				
		        
		        System.out.println("LIST OF ALL ROOMS");
				for(Room room:RoomList) {
					System.out.println();
					System.out.println("Room Number: "+room.roomNumber);
	                System.out.println("Room Type: "+room.roomType);
	                System.out.println("Room Cleaning Status: "+room.cleaningStatus);
	                System.out.println("Room Booking Status: "+room.bookingStatus);
	                System.out.println("Room Price: "+room.price);
	                System.out.println("Room Branch ID: "+room.branchId);
				}	
				
				discount();
				
				System.out.println("DO YOU WANT TO SEE FACILITIES OF ROOMS");
				String choiceString=sc.nextLine();
				if(choiceString.equalsIgnoreCase("yes")) {
					facilities();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public void facilities() {
			Facility obj = new Facility();
			obj.getDetailsOfFacilities();
		}
		
	public void discount() {
		
		Discount objDiscount = null;
		
		objDiscount = new Discount();
		value = objDiscount.returnDiscount();
			
	    System.out.println("Current Discount on All Room is : " + value+"%");

	    for(Room r:RoomList) {
	    	//System.out.println("INSIDE FOR LOOP");
            // System.out.println("Room Price: "+room.price);
            
            int discount_value = (r.price*value)/100;
            r.price = r.price-discount_value;
            
            // System.out.println("Room Price After Appling Discount: "+r.price);
		}
	}
	
	public HashMap<String, Integer> mapRoomTypeWithPrice() {
		
		HashMap<String, Integer> typeAndPriceHashMap = new HashMap<String, Integer>();
		
		String selectQuery = "SELECT * FROM RoomTypePrice";
		
		Statement selectStmt = null;
		ResultSet rs = null;
		
		try {
			selectStmt = connection.createStatement();
			
			rs = selectStmt.executeQuery(selectQuery);
			
			String type ;
			int price ;
			
			while(rs.next()) {
				type = rs.getString("room_type");
				price = rs.getInt("room_price");
				
				typeAndPriceHashMap.put(type, price);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				selectStmt.close();
				rs.close();
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return typeAndPriceHashMap;
	}
		
	public void roomManagement() {
		System.out.println("1.ADD ROOM IN BRANCH: "+HotelManagement.branch_id);
		System.out.println("2.ROOMS IN BRANCH: "+HotelManagement.branch_id);
		System.out.println("3.DETAILS OF FACILITIES PROVIDE WITH ROOM");
		Scanner sc = new Scanner(System.in);
		int choice=sc.nextInt();
		sc.nextLine();
		
		
		switch (choice) {
		case 1:
			addRoom();
			break;
		case 2:
			getRoom();
			break;
		case 3:
			facilities();
			break;
		default:
			break;
		}
	}
	
	public static void main(String[] args) {
		Room objRoom = new Room();
		HashMap<String, Integer> typeAndPriceHashMap = objRoom.mapRoomTypeWithPrice();
		
		System.out.println(typeAndPriceHashMap);
	}
}
