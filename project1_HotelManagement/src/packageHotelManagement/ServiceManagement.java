package packageHotelManagement;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ServiceManagement {
	
	static Connection connection = Conn.createConnection();
	
	public void main() {
		ServiceManagement obj1 = new ServiceManagement();
		
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter 1 to Get Details of All Services offered by Hotel");
		System.out.println("Enter 2 to Get Details of All Services taken by a specific customer");
		int key = sc.nextInt();
		sc.nextLine();
		
		switch (key) {
		case 1: {
			obj1.getAllServices();
			break;
		}
		case 2: {
			obj1.getCustomersServices();
			break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + key);
		}	
	}
	
	public void getAllServices() {
		TreeMap<String, Integer> serviceMap = new TreeMap<>();
		
		serviceMap = mapServiceNamewithServicePrice();
		
		System.out.println("===============================================");
		System.out.println("Service Name " + "    -->  	Service Price " );
		System.out.println("===============================================");
		for (Map.Entry<String, Integer> entry : serviceMap.entrySet()) {
        	System.out.println(entry.getKey() + "  -->  Rs " + entry.getValue());
        }
		System.out.println("===============================================");
	}
	
	public void getCustomersServices() {
		
		Scanner sc = new Scanner(System.in);

	    System.out.println("Enter Hotel Customer ID to see All Services taken by that Customer : ");
	    int hotelCustomerID = sc.nextInt();
	    sc.nextLine();
	    
	    TreeMap<Integer, String> serviceMap = new TreeMap<>();
	    serviceMap = mapServiceIDwithServiceName();
	    
	    ArrayList<Integer> serviceIdList = new ArrayList<Integer>();
	    serviceIdList = getserviceIdListOfCustomer(hotelCustomerID);
	    
	    System.out.println("Following services are taken by Customer : ");
	    int cnt = 1;
	    for (Integer i : serviceIdList) {
            System.out.println(cnt + ". " + serviceMap.get(i));
            cnt++;
        }   
	}
	
	public TreeMap<Integer, String> mapServiceIDwithServiceName() {
		
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    TreeMap<Integer, String> serviceMap = new TreeMap<>();
	        
	    try {
	    	
	        String sql = "SELECT service_id, service_name FROM service";
	        stmt = connection.prepareStatement(sql);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	        	int serviceId = rs.getInt("service_id");
	            String serviceName = rs.getString("service_name");
	            serviceMap.put(serviceId, serviceName);
	        }

//	        for (Map.Entry<Integer, String> entry : serviceMap.entrySet()) {
//	        	System.out.println("Service ID: " + entry.getKey() + ", Service Name: " + entry.getValue());
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
	            if (connection != null) {
	            	connection.close();
	            }
	    	} 
	    	catch (SQLException ex) {
	    		System.out.println(ex.getMessage());
	    	}
	    }
		return serviceMap;
	}

	
	public TreeMap<String, Integer> mapServiceNamewithServicePrice() {
		
	    Statement getAllServicesStmt = null;
	    ResultSet rs = null;
	    TreeMap<String, Integer> serviceMap = new TreeMap<>();
	        
	    try {
	    	
	        String sql = "SELECT service_name, service_price FROM service";
	        getAllServicesStmt = connection.createStatement();
	        rs = getAllServicesStmt.executeQuery(sql);

	        while (rs.next()) {
	        	String serviceName = rs.getString("service_name");
	            int servicePrice = rs.getInt("service_price");
	            serviceMap.put(serviceName, servicePrice);
	        }
	    } 
	    catch (SQLException e) {
	    	System.out.println(e.getMessage());
	    } 
	    finally {
	    	try {
	    		if (rs != null) {
	    			rs.close();
	    		}
	            if (getAllServicesStmt != null) {
	            	getAllServicesStmt.close();
	            }
	            if (connection != null) {
	            	connection.close();
	            }
	    	} 
	    	catch (SQLException ex) {
	    		System.out.println(ex.getMessage());
	    	}
	    }
	    
	    return serviceMap;
	}
	
	public ArrayList<Integer> getserviceIdListOfCustomer(int hotelCustomerID) {
		
	    PreparedStatement getCustomersServicesStmt = null;
	    ResultSet rs = null;
	    ArrayList<Integer> serviceIdList = new ArrayList<Integer>();
	    
	        
	    try {
	    	
	        String getCustomersServicesQuery = "SELECT service_id FROM customersService WHERE HotelCustomer_id = ? ";
	        
	        getCustomersServicesStmt = connection.prepareStatement(getCustomersServicesQuery);
	        getCustomersServicesStmt.setInt(1, hotelCustomerID);
	        
	        rs = getCustomersServicesStmt.executeQuery();

	        while (rs.next()) {
	        	int serviceId = rs.getInt("service_id");
	        	serviceIdList.add(serviceId);
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
	            if (getCustomersServicesStmt != null) {
	            	getCustomersServicesStmt.close();
	            }
	            if (connection != null) {
	            	connection.close();
	            }
	    	} 
	    	catch (SQLException ex) {
	    		System.out.println(ex.getMessage());
	    	}
	    }
		return serviceIdList;
	}
}


