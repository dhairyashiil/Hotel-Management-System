package packageHotelManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Discount {
    String type;
    int value;

    static Connection conn = Conn.createConnection();
    
    public Discount() {}
    
    public Discount(String type,int value) {
        this.type=type;
        this.value=value;
    }
    
    public static void addDiscount() {
    
    	PreparedStatement insertStmt = null;
        Scanner sc = new Scanner(System.in);
        int repetition = 0;
        
        System.out.println("How many discount data do you want to insert?");
        repetition = sc.nextInt();
        sc.nextLine();
        
        // Remove quotes around the parameter placeholders in the INSERT statement          
        String insertSql = "INSERT INTO Discount VALUES (?, ?)";
        
        try {
            insertStmt = conn.prepareStatement(insertSql);
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        
        String discount_type;
        int discount_value;
        
        while(repetition > 0) {
            System.out.println("\nEnter Discount type:");
            discount_type = sc.next();
            // Consume the newline character left by the previous call to nextInt()               
            
            sc.nextLine();
            System.out.println("Enter discount Value:");
            discount_value = sc.nextInt();
            sc.nextLine();
            
            try {
                // Set the parameter values for the prepared statement                          
            	insertStmt.setString(1, discount_type);
                insertStmt.setInt(2, discount_value);
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
            System.out.println("\nInserted all the records in Discount Table.");
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
    
    public void updateDiscount() {
        String updateSpecificSql = "UPDATE Discount SET value = ? WHERE type = ?";
        try {
            PreparedStatement updateDiscountStmt = conn.prepareStatement(updateSpecificSql);
            Scanner sc = new Scanner(System.in);
            
            System.out.println("For which type do you want to update the value?");
            String  type= sc.next();
            sc.nextLine();
            
            System.out.println("Enter new value for discount type= "+type );
            int value = sc.nextInt();
            sc.nextLine();
            
            updateDiscountStmt.setInt(1, value);
            updateDiscountStmt.setString(2, type);
            int rowsUpdated = updateDiscountStmt.executeUpdate();
            System.out.println(rowsUpdated + " row(s) updated.");
        } 
        catch (SQLException e) {
            e.printStackTrace();
        } 
        finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public void getDiscount() {
         Scanner sc = new Scanner(System.in);
         String selectAllSql = "SELECT * FROM Discount";
         Statement selectAllCustomersStmt = null;
         ResultSet rs = null;
         ArrayList<Discount> discountList = new ArrayList<>();
         try {
        	 selectAllCustomersStmt = conn.createStatement();
             rs = selectAllCustomersStmt.executeQuery(selectAllSql);
             while (rs.next()) {
            	 String type = rs.getString("Discount_type");
                 int value = rs.getInt("Discount_value");
                 Discount obj1 = new Discount(type, value);
                 discountList.add(obj1);
             }
             for (Discount d : discountList) {
            	 System.out.println("Discount Type: "+d.type);
                 System.out.println("Discount value"+d.value);
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
    }
    
    public int returnDiscount() {
        LocalDate currentDate = LocalDate.now();
        Month currentMonth = currentDate.getMonth();
        // System.out.println(currentMonth);        
        int currentMonthValue = currentMonth.getValue();
        // System.out.println(currentMonthValue);        
        String query1="";
        
        if(checkOnOffSeason(currentMonthValue)) {
             query1 = "select discount_value from discount where discount_type='off_season'"; 
        }
        else {
             query1 = "select discount_value from discount where discount_type='on_season'";
        }
        int value = 0;
          ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(query1);
           while (rs.next()) {
               value = rs.getInt("discount_value");
           }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return value;
    }
    
    public static boolean checkOnOffSeason(int currentMonthValue ) {
        Set<Integer> offSeason = new HashSet<>();
        Set<Integer> onSeason = new HashSet<>();
        offSeason.add(1); offSeason.add(2); offSeason.add(3);
        offSeason.add(4); offSeason.add(7); offSeason.add(8);
        offSeason.add(9); offSeason.add(10);
        onSeason.add(5); onSeason.add(6); onSeason.add(11); onSeason.add(12);
        if(offSeason.contains(currentMonthValue)) {
            return true;
        }
        else { 
            return false;
        }
    }
    
    public void discountMenu() {
        System.out.println("1.ADD DISCOUNT");
        System.out.println("2.UPDATE DISCOUNT");
        System.out.println("3.GET DETAILS OF ALL DISCOUNT");
        Scanner sc = new Scanner(System.in);
        int choice=sc.nextInt();
        sc.nextLine();
        
        switch (choice) {
        case 1:
            addDiscount();
            break;
        case 2:
            updateDiscount();
            break;
        case 3:
            getDiscount();
            break;
        default:
            break;
        }
    }
}