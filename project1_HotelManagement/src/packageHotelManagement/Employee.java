package packageHotelManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Employee {
	private String name;
    private int id;
    private int salary;
    private int age;
    private String role;

    static String branchId = HotelManagement.branch_id;
    static Connection conn = Conn.createConnection();

    Scanner scanObj = new Scanner(System.in);
    
    public Employee() {}
    
    public void addEmployee() {
    	
    	int repetition = 0;
	    
    	System.out.println("How many employees data do you want to insert?");
	    repetition = scanObj.nextInt();
	    PreparedStatement preparedStatement=null;
	    
	    while(repetition > 0) {
	        System.out.println("Enter following Data: ");
	        scanObj.nextLine();
	    
	        System.out.println("Enter Name: ");
	        setName(scanObj.nextLine());
	        
	        System.out.println("Enter Age: ");
	        setAge(scanObj.nextInt());
	        
	        System.out.println("Enter Salary: ");
	        setSalary(scanObj.nextInt());
	        
	        System.out.println("Enter ID: ");
	        setId(scanObj.nextInt());
	
	        scanObj.nextLine();
	        System.out.println("Enter Role: ");
	        setRole(scanObj.nextLine());
	
	        
	        String queryString = "INSERT INTO HotelEmployee VALUES(?, ?, ?, ?, ?, ?)";
	        try {
	            preparedStatement = conn.prepareStatement(queryString);
	            preparedStatement.setInt(1, getId());
	            preparedStatement.setString(2, getName());
	            preparedStatement.setInt(3, getAge());
	            preparedStatement.setInt(4, getSalary());
	            preparedStatement.setString(5, branchId);
	            preparedStatement.setString(6, getRole());
	            
	            preparedStatement.addBatch();
	        } 
	        catch (SQLException e) {         
	        	e.printStackTrace();
	        }
	        
	        repetition--;
	        
	    }
	    try {
			preparedStatement.executeBatch();
			System.out.println("\nInserted all the records in Customer Table.");
		} 
	    catch (SQLException e) {
			e.printStackTrace();
		}	    
    }
    
    public void getEmployee() {
        System.out.println("Show Employee Data: ");
        System.out.println("Enter the Employee ID: ");
        setId(scanObj.nextInt());
        scanObj.nextLine();
        
        try {
            String queryString = "SELECT * FROM HotelEmployee WHERE HotelEmployee_id = ? ";
            PreparedStatement preparedStatement = conn.prepareStatement(queryString);
            preparedStatement.setInt(1, getId());
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                System.out.println("Employee Data: ");
                System.out.println("ID: " + resultSet.getInt(1));
                System.out.println("Name: " + resultSet.getString(2));
                System.out.println("Role: " + resultSet.getString(6));
                System.out.println("Age: " + resultSet.getInt(3));
                System.out.println("Salary: " + resultSet.getInt(4));
            }
        } 
        catch (SQLException e) {   
        	e.printStackTrace();
        }
    }
    
    public void updateEmployee() {
        int columnChoice;
        System.out.println("To Update Employee Data, Enter the Employee ID: ");
        setId(scanObj.nextInt());
        scanObj.nextLine();
        System.out.println("Menu: ");
        System.out.println("1 for Name");
        System.out.println("2 for Role");
        System.out.println("3 for Age");
        System.out.println("4 for Salary");
        columnChoice = scanObj.nextInt();
        scanObj.nextLine();
        PreparedStatement preparedStatement = null;
        try {
            StringBuilder querybBuilder = new StringBuilder();
            switch (columnChoice) {
            case 1:
                querybBuilder.append("UPDATE HotelEmployee ");
                querybBuilder.append("SET HotelEmployee_name = ? ");
                querybBuilder.append("WHERE HotelEmployee_id = ? ");
                
                preparedStatement = conn.prepareStatement(querybBuilder.toString());
                
                System.out.println("Enter new Name: ");
                setName(scanObj.nextLine());
                
                preparedStatement.setString(1, getName());
                preparedStatement.setInt(2, getId());
                break;
            case 2:
                querybBuilder.append("UPDATE HotelEmployee ");
                querybBuilder.append("SET HotelEmployee_role = ? ");
                querybBuilder.append("WHERE HotelEmployee_id = ? ");
                
                preparedStatement = conn.prepareStatement(querybBuilder.toString());
                
                System.out.println("Enter new Role: ");
                
                setRole(scanObj.nextLine());
                preparedStatement.setString(1, getRole());
                preparedStatement.setInt(2, getId());
                break;
            case 3:
                querybBuilder.append("UPDATE HotelEmployee ");
                querybBuilder.append("SET HotelEmployee_age = ? ");
                querybBuilder.append("WHERE HotelEmployee_id = ? ");
                
                preparedStatement = conn.prepareStatement(querybBuilder.toString());
                System.out.println("Enter new Age: ");
                setAge(scanObj.nextInt());
                //scanObj.nextInt();
                scanObj.nextLine();
                preparedStatement.setInt(1, getAge());
                preparedStatement.setInt(2, getId());
                break;
            case 4:
                querybBuilder.append("UPDATE HotelEmployee ");
                querybBuilder.append("SET HotelEmployee_salary = ? ");
                querybBuilder.append("WHERE HotelEmployee_id = ? ");
                preparedStatement = conn.prepareStatement(querybBuilder.toString());
                System.out.println("Enter new Salary: ");
                setSalary(scanObj.nextInt());
                scanObj.nextLine();
                preparedStatement.setInt(1, getSalary());
                preparedStatement.setInt(2, getId());
                break;       
            default:
                break;
            }
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO: handle exception           
        	e.printStackTrace();
        }
    }
    
    public void deleteEmployee() {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Employee ID to delete all records of that employee : ");
        int Employee_id = sc.nextInt();
        sc.nextLine();
        
        PreparedStatement deleteEmpStmt = null;
        
        try {
            String deleteEmpQuery = "DELETE FROM HotelEmployee WHERE HotelEmployee_id = ? ";
            deleteEmpStmt = conn.prepareStatement(deleteEmpQuery);
            deleteEmpStmt.setInt(1, Employee_id);
            int rowsUpdated = deleteEmpStmt.executeUpdate();
            System.out.println(rowsUpdated + " row(s) updated.");
        } 
        catch (SQLException e) {
            System.out.println(e.getMessage());
        } 
        finally {
            try {
                if (deleteEmpStmt != null) {
                    deleteEmpStmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } 
            catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
    }
    
    public void employeeManagement() {
		System.out.println("1.ADD EMPLOYEE");
		System.out.println("2.UPDATE EMPLOYEE DETAILS");
		System.out.println("3.GET DETAILS OF EMPLOYEE");
     	System.out.println("4.DELETE DETAILS OF EMPLOYEE");
		Scanner sc = new Scanner(System.in);
		int choice=sc.nextInt();
		sc.nextLine();
		
		switch (choice) {
		case 1:
			addEmployee();
			break;
		case 2:
			updateEmployee();
			break;
		case 3:
			getEmployee();
			break;
		case 4:
			deleteEmployee();
			break;
		default:
			break;
		}
	}
    public String getName() {
        return name;
    }
    public void setName(String name) {
    	this.name = name;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
    	this.id = id;
    }
    public int getSalary() {
        return salary;
    }
    public void setSalary(int salary) {
    	this.salary = salary;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
    	this.role = role;
    }
}
