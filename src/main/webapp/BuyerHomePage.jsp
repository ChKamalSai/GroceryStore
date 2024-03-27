<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HomePage(Buyer)</title>
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
    .cart a {
            text-decoration: none;
            color: #3CAF50;
            font-size: 24px;
        }
    input{
		font-size:20px;
		border:2px solid #3CAF50;
		padding:10px;
		margin:10px;
		border-radius:5px;
}
		select,option{
		font-size: 24px;
        background-color: #3CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 20px;
        border-radius: 5px;
        cursor: pointer;
	}
		ul.pagination {
            display: inline;
            padding: 0;
            margin: 0;
        }
        ul.pagination li { display: inline; }
        ul.pagination li a {
            text-decoration: none;
            padding: 5px 10px;
            background-color: #0074D9;
            color: #FFF;
            border: 1px solid #0074D9;
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

<div class="cart">
		<img src="cart.jpeg" alt="cart" width="50" height="50">
	<a href="Cart.jsp">Cart	</a>
</div>

</div>
<%String UserName=(String)session.getAttribute("Name");
		int currentPage=0;
		int totalPages=0;
		int itemsPerPage=0;
if(UserName!=null){
	  itemsPerPage = 10; // Default to 10 items per page
	    String itemsPerPageParam = request.getParameter("itemsPerPage");
	    if (itemsPerPageParam != null) {
	        itemsPerPage = Integer.parseInt(itemsPerPageParam);
	    }
	
	 Properties prop=getConnectionData();
	 String url=prop.getProperty("db.url");
	 String user=prop.getProperty("db.user");
	 String psswd=prop.getProperty("db.passwd");
	 Class.forName("com.mysql.jdbc.Driver");
	 	try(Connection con=DriverManager.getConnection(url,user,psswd)){
	 	   // Calculate the total number of items in the database
	        int totalItems = 0;
	        Statement totalItemsStmt = con.createStatement();
	        ResultSet totalItemsResult = totalItemsStmt.executeQuery("SELECT COUNT(*) FROM items");
	        if (totalItemsResult.next()) {
	            totalItems = totalItemsResult.getInt(1);
	        }

	        // Calculate the total number of pages
	         totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

	        // Get the current page number from the query parameter
	        currentPage = 1; // Default to the first page
	        String pageParam = request.getParameter("page");
	        if (pageParam != null) {
	            currentPage = Integer.parseInt(pageParam);
	        }

	        // Calculate the starting item index for the current page
	        int startItemIndex = (currentPage - 1) * itemsPerPage;
	 		PreparedStatement prp=con.prepareStatement("Select * from items LIMIT ?, ?");
	 		prp.setInt(1,startItemIndex);
	 		prp.setInt(2, itemsPerPage); // Set the limit to the selected number of items per page
	 		ResultSet rs= prp.executeQuery();%>
	 		<div class="item-content">
	 		<% 
	 		while(rs.next()){
	 			String SellerUserName=rs.getString("UserName");
	 			String itemName = rs.getString("ItemName");
                String description = rs.getString("Description");
                int stock = rs.getInt("Stock");
                int price = rs.getInt("Price");
                String unit=rs.getString("Unit");
                byte[] image = rs.getBytes("Image");
                String base64Image = new String(Base64.getEncoder().encode(image));
                if(stock>0){
    %>
    <div class="item">
        <form action="addToCart" method="post" >
        <img src="data:image/jpeg;base64, <%= base64Image %>" /><br>
        <h2><%= itemName %></h2>
        <input type="hidden" name="itemName" value=<%= itemName %>>
        <p>Description: <%= description %></p>
        <input type="hidden" name="sellerName" value=<%= SellerUserName %>>
        <p>Stock: <%= stock %></p>
        <p>Unit:<%=unit %></p>
        <p>Price: <%= price %> Rs</p>
        <label>Quantity:</label>
        <input type="number" name="Quantity" id="Quantity" min="1" max="<%=stock %>" required>
        <button type="submit" class="update-button">Add to cart</button>
        </form>
    </div>

<% }}
	 	}catch(Exception ex){
			ex.printStackTrace();
		}
} %>
</div>
 <div class="dropdown">
       
        <select id="itemsPerPage" onchange="changeItemsPerPage(this.value)">
    	<option value="5" <%= itemsPerPage == 5 ? "selected" : "" %>>5 items/page</option>
    	<option value="10" <%= itemsPerPage == 10 ? "selected" : "" %>>10 items/page</option>
    	<option value="20" <%= itemsPerPage == 20 ? "selected" : "" %>>20 items/page</option>
		</select>
    </div>
    
    <div class="pagination">
            <ul>
                <%-- Previous Page Link --%>
                <% if (currentPage > 1) { %>
                    <li><a href="<%= request.getRequestURI() %>?itemsPerPage=<%= itemsPerPage %>&page=<%= currentPage - 1 %>">Previous</a></li>
                <% } %>

                <%-- Page Number Links --%>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li><a href="<%= request.getRequestURI() %>?itemsPerPage=<%= itemsPerPage %>&page=<%= i %>"><%= i %></a></li>
                <% } %>

                <%-- Next Page Link --%>
                <% if (currentPage < totalPages) { %>
                    <li><a href="<%= request.getRequestURI() %>?itemsPerPage=<%= itemsPerPage %>&page=<%= currentPage + 1 %>">Next</a></li>
                <% } %>
            </ul>
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
function changeItemsPerPage(value) {
    // Redirect to the same page with the selected items per page value
    window.location.href = "<%= request.getRequestURI() %>?itemsPerPage=" + value;
}
</script>
</body>
</html>
