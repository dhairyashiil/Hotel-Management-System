package packageHotelManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Scanner;

public class Facility {
	int id;
    String name;
    String roomType;
    
    static Connection conn = Conn.createConnection();
    
    public Facility() {}
    
    public Facility(int id, String name) {
        this.id=id;
        this.name=name;
    }
    
    public Facility(int id, String name, String roomType) {
        this.id=id;
        this.name=name;
        this.roomType=roomType;
    }
    
    public static void main(String[] args) {
    	Facility obj1 = new Facility();
    	obj1.getDetailsOfFacilities();
	}
    
    public  void getDetailsOfFacilities() {
    	
    	Connection conn = null;
        Statement SelectFacilityStmt = null;
        ResultSet rs = null;
        ArrayList<Facility> FacilityList = new ArrayList<>();
        
        System.out.println("1.SHOW ONLY SPECIFIC ROOM TYPE FACILITY");
        System.out.println("2.SHOW ALL FACILITIES");
        Scanner sc = new Scanner(System.in);
        
        int choice = sc.nextInt();
        sc.nextLine();
        
        String query = "";
        
        if(choice == 1) {
        	
        	System.out.println("For Specific Type");
        	System.out.println("Enter 1 for Standard type room");
        	System.out.println("Enter 2 for Luxury type room");
        	System.out.println("Enter 3 for LuxuryGOLD type room");
        	
        	int choice2 = sc.nextInt();
            sc.nextLine();
            
            if(choice2 == 1) {
            	System.out.println("Facilities Customer will get in Standard Room : ");
            	query="SELECT * FROM facility where room_type = 'Standard'";
            }
            else if(choice2 == 2) {
            	System.out.println("Facilities Customer will get in Luxury Room : ");
            	query="SELECT * FROM facility where room_type = 'Standard' OR room_type = 'Luxury'";
            }
            else if(choice2 == 3) {
            	System.out.println("Facilities Customer will get in LuxuryGOLD Room : ");
            	query="SELECT * FROM facility";
            }
            else {
            	System.out.println("Invalid choice");
            }
        }
        else if(choice == 2){
        	query="SELECT * FROM FACILITY";
        }
        else {
            System.out.println("Invalid choice");
        }
        
        try {
        	
            SelectFacilityStmt = conn.createStatement();
            
            rs = SelectFacilityStmt.executeQuery(query);
            
            while (rs.next()) {
            	
            	int id = rs.getInt("facility_id");
                String facility_name = rs.getString("facility_name");
//                String room_type = rs.getString("room_type");
                
                Facility obj = new Facility(id, facility_name);
//                Facility obj = new Facility(id, facility_name, room_type);
                
                FacilityList.add(obj);
            }
            for(Facility facility:FacilityList) {
                System.out.println("\nFacility ID: "+facility.id);
                System.out.println("Facility Name: "+facility.name);
//                System.out.println("Room Type: "+facility.roomType);
        }  
        } 
        catch (SQLException e) {
            e.printStackTrace();
        } 
        finally {
            try {
                rs.close();
                SelectFacilityStmt.close();
                conn.close();
            } 
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
