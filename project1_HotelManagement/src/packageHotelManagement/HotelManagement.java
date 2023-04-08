package packageHotelManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class HotelManagement {

	public static String branch_id;
	static Connection conn = Conn.createConnection();
    static PreparedStatement stmt = null;
//    static Scanner sc = new Scanner(System.in);
    
    public void login() {
        System.out.println("Please Login first");
        Scanner sc = new Scanner(System.in);
        String[] arr = new String[2];
        System.out.print("USERNAME: ");
        String username = sc.next();
        System.out.print("PASSWORD: ");
        String password = sc.next();
        String query = "select * from HOTELLOGIN where username=? AND password=?";
	     try {
	        stmt = conn.prepareStatement(query);
	        stmt.setString(1, username);
	        stmt.setString(2, password);
	        ResultSet rs = stmt.executeQuery(); 
	        if(rs.next()) {
	            System.out.println("Correct Credentails");
	            arr=username.split("@");
	            branch_id = arr[1];
	            System.out.println("\nBranch_id = "+branch_id+"\n");
	        }
	        else {
	            System.out.println("incorrect Credentails");
	            System.exit(0);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }  
    }
    
    public static void main(String[] args) {
        
        System.out.println("===============WELCOME==================");
        System.out.println("========HOTEL MANAGEMENT SYSTEM=========");
        
        HotelManagement objHotelManagement = new HotelManagement(); 
        objHotelManagement.login();
        
        while(true) {
	        System.out.println("***********Menu List***************");
	        System.out.println("1.Branch Management");
	        System.out.println("2.Room Management");
	        System.out.println("3.Customer Management ");
	        System.out.println("4.Staff Management");
	        System.out.println("5.RESERVATION");
	        System.out.println("6.SERVICE MANAGEMENT");
	        System.out.println("7.Customer Billing");
	        System.out.println("8.EXIT");
	        
	        Scanner sc = new Scanner(System.in);
	
	        int choice = sc.nextInt();
	        sc.nextLine();
	        
	        switch(choice) {
	        case 1:
	            Branch objBranch = new Branch();
	            objBranch.branchMangement();
	            break;
	        case 2:
	            Room objRoom = new Room();
	            objRoom.roomManagement();
	            break;
	        case 3:
	            Customer objCustomer = new Customer();
	            objCustomer.customerManagement();
	            break;
	        case 4:
	            Employee objEmployee = new Employee();
	            objEmployee.employeeManagement();
	            break;
	        case 5:
	            Reservation objReservation = new Reservation();
	            objReservation.reservationManagement();
	            break;
	        case 6:
	        	ServiceManagement objServiceManagement = new ServiceManagement();
	        	objServiceManagement.main();
	            break;
	        case 7:
	        	HotelCustomersBilling objHotelCustomersBilling = new HotelCustomersBilling();
	        	objHotelCustomersBilling.main();
	            break;
	        case 8:
	            System.exit(0);
	            break;
	        default:
	            System.out.println("INVALID CHOICE");
	        }
	    }
    }
}