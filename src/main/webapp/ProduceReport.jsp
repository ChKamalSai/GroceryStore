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
<form method="post" action="SellerReportDate.jsp">
<h2>Sales in a Particular range of date</h2>
    <label for="fromDate">From Date:</label>
    <input type="date" id="fromDate" name="fromDate" required>
    
    <label for="toDate">To Date:</label>
    <input type="date" id="toDate" name="toDate" required>
    
    <button type="submit">Show Orders</button>
</form>
<form method="post" action="SellerReportName.jsp">
<h2>Purchases of a User</h2>
	<label>User</label>
	<input type="text" name="UserName" required>
	<button type="submit">Show Orders</button>
</form>
<%@include file="Footer.html" %>

</body>
</html>