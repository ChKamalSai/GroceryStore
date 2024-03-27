<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
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
    	
    	
    	.box{
    	margin-bottom:5%;
    	}
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
			align-items:center;
            min-height: 20vh;
         
        }
        .option {
            flex: 0 0 calc(33.33% - 50px);
            margin: 20px;
            padding: 50px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            /* transition: transform 0.2s; */
        }
        .option:hover {
            transform: scale(1.05);
        }
        .option a {
            text-decoration: none;
            color: #3CAF50;
            font-size: 24px;
        }
        
      
   
</style>
</head>
<body>

<%@include file="Header.html" %>
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a  href="sessionLogout">Logout</a>
	</div>
</div>
<div class="box">
    <div class="container">
        <div class="option">
            <a href="ProduceReport.jsp">Produce Report</a>
        </div>
        <div class="option">
            <a href="AddItems.jsp">Add Items</a>
        </div>
    </div>
    <div class="container">
        <div class="option">
            <a href="SellerShowItems.jsp">Show Items and Update Stock</a>
        </div>
    </div>
</div>	

<%@include file="Footer.html" %>

</body>
</html>