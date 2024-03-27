<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a href="sessionLogout">Logout</a>
	</div>
</div>
</div>
<%String UserName=(String)session.getAttribute("UserName");
if(UserName!=null){
	 Properties prop=getConnectionData();
	 String url=prop.getProperty("db.url");
	 String user=prop.getProperty("db.user");
	 String psswd=prop.getProperty("db.passwd");
	 Class.forName("com.mysql.jdbc.Driver");
	 	try(Connection con=DriverManager.getConnection(url,user,psswd)){
	 		PreparedStatement prp=con.prepareStatement("Select * from items where UserName=? ");
	 		prp.setString(1,UserName);
	 		ResultSet rs= prp.executeQuery();%>
	 		<div class="item-content">
	 		<% 
	 		while(rs.next()){
	 			 String itemName = rs.getString("ItemName");
                String description = rs.getString("Description");
                int stock = rs.getInt("Stock");
                int price = rs.getInt("Price");
                String unit=rs.getString("Unit");
                byte[] image = rs.getBytes("Image");
                String base64Image = new String(Base64.getEncoder().encode(image));
    %>
    <div class="item">
        <img src="data:image/jpeg;base64, <%= base64Image %>" /><br>
        <h2><%= itemName %></h2>
        <p>Description: <%= description %></p>
        <p>Stock: <%= stock %></p>
        <p>Unit:<%=unit %></p>
        <p>Price: <%= price %> Rs</p>
        <form action="updateItem" method="post">
        <input type="hidden" name="ItemName" value=<%=itemName%>>
        <label>New Stock:</label>
        <input type="number" name="stockUpdate" min="0" required >        
        <button class="update-button">Update Stock</button>
        </form>
        <form action="deleteItem" method="post">
        <input type="hidden" name="ItemName" value=<%=itemName%>>
        <button class="update-button">Delete Item</button>
        </form>
    </div>
	 			
<% 
	 		}
	 	}catch(Exception ex){
			ex.printStackTrace();
		}
} %>
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
</script>
</body>
</html>