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
import java.util.Properties;
@WebServlet("/addToCart")
public class AddToCart extends HttpServlet {
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
		String SellerName=request.getParameter("sellerName");
		String ItemName=request.getParameter("itemName");
		int Quantity=Integer.parseInt(request.getParameter("Quantity"));
		PreparedStatement prp1=con.prepareStatement("select * from cart where BuyerUserName=? and SellerUserName=? and ItemName=?");
		prp1.setString(1,BuyerName);
		prp1.setString(2,SellerName);
		prp1.setString(3, ItemName);
		ResultSet rs=prp1.executeQuery();
		if(rs.next()) {
			int previousQuantity=rs.getInt(4);
			PreparedStatement prp=con.prepareStatement("select * from items where UserName=? and ItemName=? ");
			prp.setString(1,SellerName);
			prp.setString(2, ItemName);
			ResultSet rs1=prp.executeQuery();
			if(rs1.next()) {
			int Stock=rs1.getInt("Stock");
			int modifyQuantity=previousQuantity+Quantity;
			if(Stock>=modifyQuantity) {
			PreparedStatement prp3=con.prepareStatement("update cart set Quantity=? where BuyerUserName=? and SellerUserName=? and ItemName=? ");
			prp3.setInt(1, modifyQuantity);
			prp3.setString(2,BuyerName);
			prp3.setString(3,SellerName);
			prp3.setString(4, ItemName);
			prp3.executeUpdate();
			out.println("<script>alert('Successfully added to cart')</script>");
			response.sendRedirect("Cart.jsp");
			}
			else {
				out.println("<script>alert('Your Request is more than the existing stock')</script>");
			}
			}}
		else {
			PreparedStatement prp3=con.prepareStatement("Insert into cart values(?,?,?,?)");
			prp3.setString(1,BuyerName);
			prp3.setString(2,SellerName);
			prp3.setString(3, ItemName);
			prp3.setInt(4, Quantity);
			prp3.executeUpdate();
			out.println("<script>alert('Successfully added to cart')</script>");
			response.sendRedirect("Cart.jsp");
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doGet(request,response);
	}
	
}
