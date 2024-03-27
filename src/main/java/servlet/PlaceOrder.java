package servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
@WebServlet("/placeOrder")
public class PlaceOrder extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static Properties getConnectionData() {

	    Properties props = new Properties();

	    //String fileName = "src/main/resources/db.properties";
	    String fileName = "/home/kamal/eclipse-workspace/Store/src/main/webapp/db.properties";

	    try (FileInputStream in = new FileInputStream(fileName)) {
	        props.load(in);
	    } catch (IOException ex) {
	       // Logger lgr = Logger.getLogger(Q7.class.getName());
	        //lgr.log(Level.SEVERE, ex.getMessage(), ex);
	    	ex.printStackTrace();
	    }

	    return props;
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter out= response.getWriter();
		 Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String psswd=prop.getProperty("db.passwd");
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
			try(Connection con=DriverManager.getConnection(url,user,psswd)){
				String BuyerName=(String)session.getAttribute("Name");
					PreparedStatement prp1=con.prepareStatement("select * from cart where BuyerUserName=?");
					prp1.setString(1,BuyerName);
					PreparedStatement prp2=con.prepareStatement("insert into BuyerOrder(BuyerUserName,SellerUserName,ItemName,Quantity,Unit,PricePerUnit) values(?,?,?,?,?,?)");
					PreparedStatement prp3=con.prepareStatement("delete from cart where BuyerUserName=? and SellerUserName=? and ItemName=?");
					prp3.setString(1,BuyerName);
					PreparedStatement prp4=con.prepareStatement("select * from items where UserName=? and ItemName=?");
					ResultSet rs=prp1.executeQuery();
					PreparedStatement prp5=con.prepareStatement("Update items set Stock=? where UserName=? and ItemName=? ");
					synchronized(session) {
						try {
							con.setAutoCommit(false);
							while(rs.next()) {
								String SellerUserName=rs.getString(2);
								String ItemName=rs.getString(3);
								int Quantity=rs.getInt(4);
								prp4.setString(1, SellerUserName);
								prp4.setString(2, ItemName);
								ResultSet rs1=prp4.executeQuery();
								if(rs1.next()) {
								String unit=rs1.getString(7);
								int pricePerUnit=rs1.getInt(6);
							prp2.setString(1, BuyerName);
							prp2.setString(2, SellerUserName);
							prp2.setString(3, ItemName);
							prp2.setInt(4, Quantity);
							prp2.setString(5, unit);
							prp2.setInt(6, pricePerUnit);
							
							prp2.executeUpdate();
							prp3.setString(2, SellerUserName);
							prp3.setString(3, ItemName);
							
							prp3.executeUpdate();
							
							int a= rs1.getInt("Stock")-Quantity;
							prp5.setInt(1,a);
							prp5.setString(2, SellerUserName);
							prp5.setString(3, ItemName);
							prp5.executeUpdate();
								}
							}
							con.commit();
							response.sendRedirect("DisplayOrders.jsp");
						}catch(SQLException e) {
							e.printStackTrace();
	            			con.rollback();	
						}
						
					}
			}catch(Exception ex) {
			ex.printStackTrace();	
			}
			}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
	
}
