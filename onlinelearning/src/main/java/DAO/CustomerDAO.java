package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import  Module.User;
import Module.Customer;
import dal.DBContext;

public class CustomerDAO extends DBContext {
    public ArrayList<Customer> getAll() {
        String sql = "select * from Customers";
        ArrayList<Customer> listCustomer = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("CustomerID"));
                c.setSocialRole(rs.getString("SocialRole"));
                c.setLevelOfEnglish(rs.getString("LevelOfEnglish"));
                c.setUser(uDAO.getByID(rs.getInt("UserID")));
                listCustomer.add(c) ;
            }
            return listCustomer ;
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return listCustomer;
    }

    public Customer getByID(int id) {
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("CustomerID"));
                c.setSocialRole(rs.getString("SocialRole"));
                c.setLevelOfEnglish(rs.getString("LevelOfEnglish"));

                // Lấy thông tin User từ bảng Users
                int userId = rs.getInt("UserID");
                UserDAO ud = new UserDAO();
                User user = ud.getByID(userId);
                c.setUser(user);

                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }
    
    public int GetIDCustomerByID(int iduser){
        int customerID = -1;
        String sql = "SELECT * FROM Customers WHERE UserID = ?";

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,iduser);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customerID = rs.getInt("CustomerID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return customerID;
    }

    public void insertUser1(Customer c) {
        String sql = "INSERT INTO Customers (SocialRole, LevelOfEnglish, UserID) VALUES (?, ?, ?)";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1,c.getSocialRole());
            st.setString(2,c.getLevelOfEnglish());
            st.setInt(3,c.getUser().getUserId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
    }
    
    public Customer getCustomerById(int customerId) {
        Customer customer = null;
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                customer = new Customer();

                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setSocialRole(rs.getString("SocialRole"));
                customer.setLevelOfEnglish(rs.getString("LevelOfEnglish"));

                // Lấy thông tin User từ bảng Users
                int userId = rs.getInt("UserID");
                UserDAO ud = new UserDAO();
                User user = ud.getUserByID(userId);
                customer.setUser(user);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving customer: " + e);
        } finally {
            closeResources();
        }

        return customer;  // Trả về đối tượng Customer hoặc null nếu không tìm thấy
    }
    

}
