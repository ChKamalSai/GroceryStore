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
@WebServlet("/Seller")
@MultipartConfig(
		fileSizeThreshold=1024*1024,
		maxFileSize=5*1024*1024,
		maxRequestSize=20*1024*1024)

public class sellerAddItems extends HttpServlet {
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
		String UserName=(String)session.getAttribute("UserName");
		String ItemName=request.getParameter("itemName");
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
		String Description=request.getParameter("description");
		int stock=Integer.parseInt(request.getParameter("stock"));
		int price=Integer.parseInt(request.getParameter("price"));
		String unit=request.getParameter("unit");
		Part image=request.getPart("image");
		InputStream in=image.getInputStream();
		PreparedStatement prp1=con.prepareStatement("select ItemName from items where UserName=? AND ItemName=?");
		prp1.setString(1,UserName);
		prp1.setString(2,ItemName);
		ResultSet rs=prp1.executeQuery();
		if(rs.next()){
		out.println("<script>alert('This item already exists, if you want to update this item, go back and select show Items/ update stock ')</script>");
		//Thread.sleep(5000);
		response.sendRedirect("AddItems.jsp");
		}else{
			PreparedStatement prp2=con.prepareStatement("Insert into items values(?,?,?,?,?,?,?)");
			prp2.setString(1,UserName);
			prp2.setString(2,ItemName);
			prp2.setString(4,Description);
			prp2.setInt(5,stock);
			prp2.setInt(6,price);
			prp2.setBlob(3,in);
			prp2.setString(7,unit);
		
			prp2.executeUpdate();
			out.println("<script>alert('Succesfully added')</script>");
			//Thread.sleep(5000);
			response.sendRedirect("SellerHomePage.jsp");
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}