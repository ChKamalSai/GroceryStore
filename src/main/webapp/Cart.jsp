<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
</head>
<style>
	body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f2f2f2;
        }
        .container{
        display:flex;}
        .dropdown{
            position: relative;
          	margin-right:80px;
            margin-top: 20px;
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
		.searchbar{
		margin:20px 0;
		padding:10px;
		/*border:2px solid #3CAF50;*/
		border-radius:5px;
		width:100%;
		font-size:18px;
		}
		.cart{
			position: relative;
          	margin-right:80px;
            margin-top: 20px;
            display: inline-block;
            background-color: #f2f2f2;
		}
		.cart .text-overlay {
        position: absolute;
        top: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 5px;
        display: none;
    	}

    	.cart:hover .text-overlay {
        display: block;
    	}
		input[type=text]{
		font-size:20px;
		border:2px solid #3CAF50;
		padding:10px;
		border-radius:5px;
		background-color:#fff;
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
    .update-button:hover {
        background-color: #2A7B3D;
    }
    input{
		font-size:20px;
		border:2px solid #3CAF50;
		padding:10px;
		margin:10px;
		border-radius:5px;
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
</style>
<body>
<%@include file="Header.html" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
}
 %>
 <div class="container">
<div class="searchbar">
<input type="text" id="searchInput" placeholder="Search for items.." oninput="searchItems()"></div>
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("Name") %></a>
	<a href="sessionLogout">Logout</a>
	</div>
</div>


</div>
<% int totalValue=0;
String UserName=(String)session.getAttribute("Name");
if(UserName!=null){
	 Properties prop=getConnectionData();
	 String url=prop.getProperty("db.url");
	 String user=prop.getProperty("db.user");
	 String psswd=prop.getProperty("db.passwd");
	 Class.forName("com.mysql.jdbc.Driver");
	 	try(Connection con=DriverManager.getConnection(url,user,psswd)){
	 		PreparedStatement prp=con.prepareStatement("Select * from cart where BuyerUserName=?");
	 		prp.setString(1,UserName);
	 		ResultSet rs= prp.executeQuery();
	 		%>
	 		<div class="item-content">
	 		<% 
	 		while(rs.next()){
	 			String SellerUserName=rs.getString("SellerUserName");
	 			String itemName = rs.getString("ItemName");
	 			int Quantity=rs.getInt("Quantity");
	 			PreparedStatement prp1=con.prepareStatement("Select * from items where UserName=? and ItemName=?");
	 			prp1.setString(1,SellerUserName);
	 			prp1.setString(2,itemName);
	 			ResultSet rs1=prp1.executeQuery();
	 			if(rs1.next()){
                int pricePerUnit = rs1.getInt("Price");
                int totalPrice=Quantity*pricePerUnit;
                String unit=rs1.getString("Unit");
                byte[] image = rs1.getBytes("Image");
                totalValue=totalValue+totalPrice;
                String base64Image = new String(Base64.getEncoder().encode(image));
                
           
    %>
    <div class="item">
    <form action="deleteInCart" method="post">
        <img src="data:image/jpeg;base64, <%= base64Image %>" /><br>
        <h2><%= itemName %></h2>
        <input type="hidden" name="SellerUserName" value=<%=SellerUserName%>>
        <input type="hidden" name="ItemName" value=<%=itemName%>>
        <p><%=Quantity %></p>
        <p>Unit:<%=unit %></p>
        <p>Price per Unit: <%= pricePerUnit %> Rs</p>
        <p>Total price:<%=totalPrice %> Rs</p>
        <button type="submit" class="update-button">Delete</button>
        </form>
    </div>
	 			
<% 
	 			}	}
	 	}catch(Exception ex){
			ex.printStackTrace();
		}
} %>
</div>
<div class="order-summary">
    <h2>Order Summary</h2>
    <p>Total Value of Cart: <%= totalValue %> Rs</p>
    <button class="place-order-button" id="placeOrderButton" onclick="window.location.href='placeOrder'">Place Order</button>
</div>
<%@include file="Footer.html" %>
<script>
function searchItems(){
	var input = document.getElementById("searchInput");
    var filter = input.value.toLowerCase();
    var items = document.getElementsByClassName("item");

    for (var i = 0; i < items.length; i++) {
        var itemName = items[i].getElementsByTagName("h2")[0].textContent.toLowerCase();

        if (itemName.includes(filter)) {
            items[i].style.display = "block";
        } else {
            items[i].style.display = "none";
        }
    }
}
var totalValue = <%= totalValue %>;

var placeOrderButton = document.getElementById("placeOrderButton");

if (totalValue <= 0) {
    
    placeOrderButton.disabled = true;
}

</script>
</body>
</html>
