<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Report</title>
</head>
<style>
	body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f2f2f2;
            font-size:20px;
        }
        .dropdown{
            position: relative;
            margin-left: 90%; 
            /* margin-right: 10px; */
            margin-top: 10px;
            display: inline-block;
            background-color: #f2f2f2;
        }

        .dropdown-content{
            display :none;
            position: absolute;
            background-color: #fff;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index:1;
        }
        .dropdown:hover .dropdown-content{
            display: block;
        }
        .dropdown-content a{
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            color: #333;
        }
        .dropdown-content a:hover{
            background-color: #f2f2f2;
        }
        a:hover{
			
			color:#3CAF50  
		}
		.item-content{
		display:flex;
		flex-wrap:wrap;
		justify-content:space-between;
		}
		.item{
		width:45%;
		margin:10px;
		padding:10px;
		background-color:#fff;
		border-radius:10px;
		box-shadow:0 0 10px rgba(0,0,0,0.2);
		text-align:center;
		font-size:20px;
		}
		.item image{
		width:100%;
		height:auto;}
		.update-button {
        background-color: #3CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px;
        border-radius: 5px;
        cursor: pointer;
        font-size:25px;
    }
.order-summary {
        background-color: #fff;
        border: 2px solid #3CAF50;
        border-radius: 5px;
        padding: 10px;
        font-size: 18px;
        text-align: center;
    }

    .place-order-button {
        background-color: #3CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 25px;
    }

    .place-order-button:hover {
        background-color: #2A7B3D;
    }
    input {
        font-size: 20px;
        border: 2px solid #3CAF50;
        padding: 10px;
        margin: 10px;
        border-radius: 5px;
        /*width: 80%;*/
    	}

     button {
        font-size: 24px;
        background-color: #3CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 20px;
        border-radius: 5px;
        cursor: pointer;
     }

     button:hover {
        background-color: #2A7B3D;
    }
</style>

<body>
<%@include file="Header.html" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.logging.*" %>
<%@	page import="jakarta.servlet.*" %>
<%!
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
}%>
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a href="sessionLogout">Logout</a>
	</div>
</div>


<%
String fromDateParam = request.getParameter("fromDate");
String toDateParam = request.getParameter("toDate");
int totalValue=0;
String UserName=(String)session.getAttribute("UserName");
if (fromDateParam != null && toDateParam != null && UserName!=null) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date fromDate = dateFormat.parse(fromDateParam+" 00:00:00");
    Date toDate = dateFormat.parse(toDateParam+" 23:59:59");
    
    Properties prop = getConnectionData();
    String url = prop.getProperty("db.url");
    String user = prop.getProperty("db.user");
    String psswd = prop.getProperty("db.passwd");
    
    try (Connection con = DriverManager.getConnection(url, user, psswd)) {
        PreparedStatement prp = con.prepareStatement("SELECT * FROM BuyerOrder WHERE SellerUserName=? AND OrderDate BETWEEN ? AND ?");
        prp.setString(1, UserName);
        prp.setTimestamp(2, new Timestamp(fromDate.getTime()));
        prp.setTimestamp(3, new Timestamp(toDate.getTime()));
	 		ResultSet rs= prp.executeQuery();
	 		%>
	 		<div class="item-content">
	 		<% 
	 		while(rs.next()){
	 			String SellerUserName=rs.getString("SellerUserName");
	 			String itemName = rs.getString("ItemName");
	 			int Quantity=rs.getInt("Quantity");
	 			int pricePerUnit=rs.getInt("PricePerUnit");
	 			int totalPrice=rs.getInt("TotalPrice");
                String unit=rs.getString("Unit");
	 			PreparedStatement prp1=con.prepareStatement("Select * from items where UserName=? and ItemName=?");
	 			prp1.setString(1,SellerUserName);
	 			prp1.setString(2,itemName);
	 			ResultSet rs1=prp1.executeQuery();
	 			if(rs1.next()){                
                byte[] image = rs1.getBytes("Image");
                totalValue=totalValue+totalPrice;
                String base64Image = new String(Base64.getEncoder().encode(image));
                
           
    %>
    <div class="item">
        <img src="data:image/jpeg;base64, <%= base64Image %>" /><br>
        <h2><%= itemName %></h2>
        <p>Date-time:<%=rs.getTimestamp("OrderDate") %></p>
		<p>Buyer Name=<%=rs.getString(1) %></p>       
        <p>Quantity: <%=Quantity %></p>
        <p>Unit:<%=unit %></p>
        <p>Price per Unit: <%= pricePerUnit %> Rs</p>
        <p>Total price:<%=totalPrice %> Rs</p>
 
    </div>
	 			
<% 
	 			}
	 			}
	 	}catch(Exception ex){
			ex.printStackTrace();
		}%>
<%} %>
</div>
<div class="order-summary">
    <h2>Sales Summary</h2>
    <p>Total Value : <%= totalValue %> Rs</p>
    <button class="place-order-button" onclick="window.location.href='SellerHomePage.jsp'">Go to home</button>
</div>
<%@include file="Footer.html" %>

</body>
</html>