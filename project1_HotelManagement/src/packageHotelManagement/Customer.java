package packageHotelManagement;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;


public class Customer {
	int id;
    String name;
    int roomId;
    int deposit;
    String address;
    
    static String branchId = HotelManagement.branch_id;
    static Connection conn = Conn.createConnection();
   
    public Customer() {}
    
    public Customer(int id,String name,int roomId,String branchId,int deposit,String address) {
    	this.id=id;
    	this.name=name;
    	this.roomId=roomId;
    	this.deposit=deposit;
    	this.address=address;
    }
    
    public void updateCustomer() {
    	
    	Scanner sc = new Scanner(System.in);
        
    	System.out.println("What do you want to update?");
        System.out.println("Enter 1: to update Name");
        System.out.println("Enter 2: to update Room ID");
        System.out.println("Enter 3: to update Deposit Amount");
        System.out.println("Enter 4: to update Address");
        
        int key = sc.nextInt();
        sc.nextLine();
        
        String updateSpecificSql = "";
        
        PreparedStatement updateCustomerStmt = null;
        
        switch (key) {
        
            case 1: {
                updateSpecificSql = "UPDATE HotelCustomer SET HotelCustomer_name = ? WHERE HotelCustomer_id = ?";
                try {
                    updateCustomerStmt = conn.prepareStatement(updateSpecificSql);
                    System.out.println("For which customer id do you want to update the name?");
                    int specificID = sc.nextInt();
                    sc.nextLine();
                    
                    System.out.println("Enter new name for customer with ID: " + specificID);
                    String updateName = sc.nextLine();
                    
                    updateCustomerStmt.setString(1, updateName);
                    updateCustomerStmt.setInt(2, specificID);
                    int rowsUpdated = updateCustomerStmt.executeUpdate();
                    System.out.println(rowsUpdated + " row(s) updated.");
                } 
                catch (SQLException e) {
                    e.printStackTrace();
                } 
                finally {
                    try {
                        conn.close();
                        updateCustomerStmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                break;
            }
            
            case 2: {
            	updateSpecificSql = "UPDATE HotelCustomer SET room_id = ? WHERE HotelCustomer_id = ?";
                try {
                    updateCustomerStmt = conn.prepareStatement(updateSpecificSql);
                    System.out.println("For which customer id do you want to update the Room ID?");
                    int specificID = sc.nextInt();
                    sc.nextLine();
                    
                    System.out.println("Enter new room ID for customer with ID: " + specificID);
                    int updateRoomID = sc.nextInt();
                    sc.nextLine();
                    
                    updateCustomerStmt.setInt(1, updateRoomID);
                    updateCustomerStmt.setInt(2, specificID);
                    int rowsUpdated = updateCustomerStmt.executeUpdate();
                    System.out.println(rowsUpdated + " row(s) updated.");
                } 
                catch (SQLException e) {
                    e.printStackTrace();
                } 
                finally {
                    try {
                        conn.close();
                        updateCustomerStmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                break;
            }
            
            case 3: {
            	updateSpecificSql = "UPDATE HotelCustomer SET HotelCustomer_deposit = ? WHERE HotelCustomer_id = ?";
                try {
                    updateCustomerStmt = conn.prepareStatement(updateSpecificSql);
                    System.out.println("For which customer id do you want to update the Deposit?");
                    int specificID = sc.nextInt();
                    sc.nextLine();
                    
                    System.out.println("Enter new Deposit Amount for customer with ID: " + specificID);
                    int updateDeposit = sc.nextInt();
                    sc.nextLine();
                    
                    updateCustomerStmt.setInt(1, updateDeposit);
                    updateCustomerStmt.setInt(2, specificID);
                    int rowsUpdated = updateCustomerStmt.executeUpdate();
                    System.out.println(rowsUpdated + " row(s) updated.");
                } 
                catch (SQLException e) {
                    e.printStackTrace();
                } 
                finally {
                    try {
                        conn.close();
                        updateCustomerStmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                break;
            }
            
            case 4: {
            	updateSpecificSql = "UPDATE HotelCustomer SET HotelCustomer_Address = ? WHERE HotelCustomer_id = ?";
                try {
                    updateCustomerStmt = conn.prepareStatement(updateSpecificSql);
                    System.out.println("For which customer id do you want to update the name?");
                    int specificID = sc.nextInt();
                    sc.nextLine();
                    
                    System.out.println("Enter new address for customer with ID: " + specificID);
                    String updateAddress = sc.nextLine();
                    updateCustomerStmt.setString(1, updateAddress);
                    updateCustomerStmt.setInt(2, specificID);
                    int rowsUpdated = updateCustomerStmt.executeUpdate();
                    System.out.println(rowsUpdated + " row(s) updated.");
                } 
                catch (SQLException e) {
                    e.printStackTrace();
                } 
                finally {
                    try {
                        conn.close();
                        updateCustomerStmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                break;
            }
            
            default:
                throw new IllegalArgumentException("Unexpected value: " + key);
        }
    }
    
    public void insertCustomerData() {
        
        PreparedStatement insertStmt = null;
        Scanner sc = new Scanner(System.in);
        int repetition = 0;
        System.out.println("How many customers data do you want to insert?");
        repetition = sc.nextInt();
        sc.nextLine();
        // Remove quotes around the parameter placeholders in the INSERT statement        
        
        String insertSql = "INSERT INTO HotelCustomer VALUES (?, ?, ?, ?, ?, ?)";
        try {
            insertStmt = conn.prepareStatement(insertSql);
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        
        int hotelCustomer_id;
        String hotelCustomer_name;
        int room_id;
        String branch_id;
        int hotelCustomer_deposit;
        String hotelCustomer_Address;
        
        while(repetition > 0) {
            System.out.println("\nEnter the ID of customer:");
            hotelCustomer_id = sc.nextInt();
            // Consume the newline character left by the previous call to nextInt()            
            sc.nextLine();
            
            System.out.println("Enter the Name of customer:");
            hotelCustomer_name = sc.nextLine();

            System.out.println("Enter the Room ID of customer:");
            room_id = sc.nextInt();
            sc.nextLine();
            
            branch_id = branchId;

            System.out.println("Enter the Deposit Customer Paid:");
            hotelCustomer_deposit = sc.nextInt();
            sc.nextLine();
            
            System.out.println("Enter the Address of customer:");
            hotelCustomer_Address = sc.nextLine();
            
            try {
                // Set the parameter values for the prepared statement                
            	
            	insertStmt.setInt(1, hotelCustomer_id);
                insertStmt.setString(2, hotelCustomer_name);
                insertStmt.setInt(3, room_id);
                insertStmt.setString(4, branchId);
                insertStmt.setInt(5, hotelCustomer_deposit);
                insertStmt.setString(6, hotelCustomer_Address);
                insertStmt.addBatch();
            } 
            catch (SQLException e) {
                e.printStackTrace();
            }
            repetition--;
        }
        try {
            // Execute the batch of insert statements            
        	
        	insertStmt.executeBatch();
            System.out.println("\nInserted all the records in HotelCustomer Table.");
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
        	sc.close();
            try {
                insertStmt.close();
                conn.close();
            } 
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public void insertCustomerData(int roomIdFromReservation, int hotelCustomerIdFromReservation) {
        
        PreparedStatement insertStmt = null;
        Scanner sc = new Scanner(System.in);

        String insertSql = "INSERT INTO HotelCustomer VALUES (?, ?, ?, ?, ?, ?)";
        try {
            insertStmt = conn.prepareStatement(insertSql);
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        
        int hotelCustomer_id = hotelCustomerIdFromReservation;
        int room_id = roomIdFromReservation;
        
        String hotelCustomer_name;
        int hotelCustomer_deposit;
        String hotelCustomer_Address;
        
        
        System.out.println("Enter the Name of customer:");
        hotelCustomer_name = sc.nextLine();

        System.out.println("Enter the Deposit Customer Paid:");
        hotelCustomer_deposit = sc.nextInt();
        sc.nextLine();
        
        System.out.println("Enter the Address of customer:");
        hotelCustomer_Address = sc.nextLine();
            
        try {
        	// Set the parameter values for the prepared statement                
            	
            insertStmt.setInt(1, hotelCustomer_id);
            insertStmt.setString(2, hotelCustomer_name);
            insertStmt.setInt(3, room_id);
            insertStmt.setString(4, branchId);
            insertStmt.setInt(5, hotelCustomer_deposit);
            insertStmt.setString(6, hotelCustomer_Address);
                
            int numRowsInserted = insertStmt.executeUpdate();
            System.out.println(numRowsInserted + " rows inserted");
            
        } 
        catch (SQLException e) {
        	e.printStackTrace();
        }

        try {
            // Execute the batch of insert statements            
        	
        	insertStmt.executeBatch();
            System.out.println("Inserted all the records in HotelCustomer Table.");
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                insertStmt.close();
            } 
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
	}
    
    public void getCustomer(){
        Scanner sc = new Scanner(System.in);
        System.out.println("You want all Customer details or someone specific ? ");
        System.out.println("Enter 1 : for all customers");
        System.out.println("Enter 2 : for specific customer");
        int key = sc.nextInt();
        sc.nextLine();
        
        switch (key) {
        case 1: {
            String selectAllSql = "SELECT * FROM HotelCustomer";
            Statement selectAllCustomersStmt = null;
            ResultSet rs = null;
            ArrayList<Customer> customerList = new ArrayList<>();
            
            try {
                selectAllCustomersStmt = conn.createStatement();
                rs = selectAllCustomersStmt.executeQuery(selectAllSql);
                while (rs.next()) {
                	
                    String name = rs.getString("HotelCustomer_name");
                    int roomId = rs.getInt("room_id");
                    int id = rs.getInt("HotelCustomer_id");
                    String branchId = rs.getString("branch_id");
                    int deposit = rs.getInt("HotelCustomer_deposit");
                    String address = rs.getString("HotelCustomer_Address");
                    
                    Customer obj1 = new Customer(id, name, roomId, branchId, deposit, address);
                    customerList.add(obj1);
                }
                for (Customer c : customerList) {
                    System.out.println("\nHotel Customer ID: " + c.id);
                    System.out.println("Hotel Customer Name: " + c.name);
                    System.out.println("Hotel Customer Room ID: " + c.roomId);
                    System.out.println("Hotel Customer BranchID: " + branchId);
                    System.out.println("Hotel Customer Deposit: " + c.deposit);
                    System.out.println("Hotel Customer Address: " + c.address);
                }
            } 
            catch (SQLException e) {
                e.printStackTrace();
            } 
            finally {
                try {
                    rs.close();
                    selectAllCustomersStmt.close();
//                    conn.close();
                } 
                catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            break;
        }
        
        case 2: {
            String selectSpecificSql = "SELECT * FROM HotelCustomer WHERE HotelCustomer_id = ?";
            PreparedStatement selectCustomerWithIDStmt = null;
            ArrayList<Customer> customerList = new ArrayList<>();
            ResultSet rs = null;
            
            try {
                selectCustomerWithIDStmt = conn.prepareStatement(selectSpecificSql);
                System.out.println("Enter the Hotel Customer Id : ");
                sc.nextLine();
                String specificID = sc.nextLine();
                selectCustomerWithIDStmt.setString(1, specificID);
                rs = selectCustomerWithIDStmt.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("HotelCustomer_id");
                    String name = rs.getString("HotelCustomer_name");
                    int roomId = rs.getInt("room_id");
                    String branchId = rs.getString("branch_id");
                    int deposit = rs.getInt("HotelCustomer_deposit");
                    String address = rs.getString("HotelCustomer_Address");
                    Customer obj1 = new Customer(id, name, roomId, branchId, deposit, address);
                    customerList.add(obj1);
                }
                for (Customer c : customerList) {
                    System.out.println("\nHotel Customer ID: " + c.id);
                    System.out.println("Hotel Customer Name: " + c.name);
                    System.out.println("Hotel Customer Room ID: " + c.roomId);
                    System.out.println("Hotel Customer BranchID: " + branchId);
                    System.out.println("Hotel Customer Deposit: " + c.deposit);
                    System.out.println("Hotel Customer Address: " + c.address);
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
    
    public void deleteCustomerAfter1_5Year() {
    	
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, -1);
        calendar.add(Calendar.MONTH, -6);
        Date date1_5YearsAgo = (Date) calendar.getTime();

        String sql = "DELETE FROM HotelCustomer WHERE HotelCustomer_id IN (SELECT HotelCustomer_id FROM reservation WHERE check_out <= ?)";
        PreparedStatement pstmt = null;
        
		try {
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setDate(1, new java.sql.Date(date1_5YearsAgo.getTime()));

	        int rowsAffected = pstmt.executeUpdate();
	        System.out.println(rowsAffected + " rows deleted.");
	        
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
    
    public void customerManagement() {
		System.out.println("1.ADD CUSTOMER");
		System.out.println("2.UPDATE CUSTOMER DETAILS");
		System.out.println("3.GET DETAILS OF CUSTOMER");
		Scanner sc = new Scanner(System.in);
		int choice=sc.nextInt();
		sc.nextLine();
		
		switch (choice) {
		case 1:
			insertCustomerData();
			break;
		case 2:
			updateCustomer();
			break;
		case 3:
			getCustomer();
			break;
		default:
			break;
		}
	}
}
