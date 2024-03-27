<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop keeper Registration</title>
<style>
body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f2f2f2;
        }

.login_form{
			margin-left:10%;
			margin-right:10%;
			margin-bottom:10%;
			font-size:30px;
			text-align:center;
}
input{
		font-size:30px;
		border:2px solid #3CAF50;
		padding:10px;
		margin:10px;
		border-radius:5px;
}

button{
		font-size:30px;
		background-color:#3CAF50;
		color:white;
		border:none;
		padding:10px 20px;
		margin:10px;
		border-radius:5px;
		cursor:pointer;
}
button:hover{
		background-color:#2A7B3D;}
</style>
</head>
<body>
	<%@ include file="Header.html" %>
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
    }

    return props;
}
 %>
	
    <div class="login_form">
    <h2>Seller Registration</h2>
	<form action="" method="post" onsubmit="return validateForm()">
	<label>User Name:</label>
	<input type="text" name="UserName" placeholder="For Unique Identification" required ><br><br>
	<label>Seller Name:</label>
	<input type="text" name="SellerName" required><br><br>
	<label>Shop Name:</label>
	<input type="text" name="ShopName" required><br><br>
	<label>Mobile number:</label>
	<input type="tel" name="Mobile" required><br><br>
	<label>Email_ID:</label>
	<input type="email" name="Email" required><br><br>
	<label>Address</label>
	<input type="text" name="Address" required><br><br>
	<label>Create Password</label>
	<input type="password" name="Password" required><br><br>
	<label>Confirm Password</label>
	<input type="password" required><br><br>
	<button type="submit" >Submit</button>
	<button type="reset">Reset</button>
	</form>
	   <%
	String UserName=request.getParameter("UserName");
	if(UserName!=null){
	   Properties prop=getConnectionData();
Class.forName("com.mysql.jdbc.Driver");
String url=prop.getProperty("db.url");
String user=prop.getProperty("db.user");
String psswd=prop.getProperty("db.passwd");
try(Connection con=DriverManager.getConnection(url,user,psswd)){
	String SellerName=request.getParameter("SellerName");
	String ShopName=request.getParameter("ShopName");
	String mobile=request.getParameter("Mobile");
	String email=request.getParameter("Email");
	String address=request.getParameter("Address");
	String password=request.getParameter("Password");

	PreparedStatement prp1=con.prepareStatement("Select * from Seller where UserName=?");
	prp1.setString(1,UserName);
	PreparedStatement prp2=con.prepareStatement("Select * from Seller where MobileNumber=?");
	prp2.setString(1,mobile);
	PreparedStatement prp3=con.prepareStatement("Select * from Seller where Email_ID=?");
	prp3.setString(1,email);
	ResultSet rs=prp1.executeQuery();
	if(rs.next()){
		out.println("<script>alert('Change the UserName as it already exists')<script>");
	}
	else{
		ResultSet rs1=prp2.executeQuery();
		if(rs1.next()){
		out.println("<script>alert('Change the Mobile Number as it already exists')<script>");
		}
		else{
			ResultSet rs2=prp3.executeQuery();
			if(rs2.next()){
			out.println("<script>alert('Change the Email_ID as it already exists')<script>");
			}
			else{
	PreparedStatement stmt=con.prepareStatement("Insert into Seller values(?,?,?,?,?,?,?)");
	stmt.setString(1,UserName);
	stmt.setString(2,SellerName);
	stmt.setString(3,ShopName);
	stmt.setString(4,mobile);
	stmt.setString(5,email);
	stmt.setString(6,address);
	stmt.setString(7,password);
	stmt.executeUpdate();
	out.println("<script>alert('Account is created Successfully. Now you will be redirected to login page')</script>");
	response.sendRedirect("Seller_Login.jsp");
				}
			}
		}
	
	
	
}catch(Exception e){
	e.printStackTrace();
}}%>
    </div>
<%@ include file="Footer.html" %>
<script>
function validateForm(){
	var x=document.forms[0];
	if (x[0].value.trim() === "") {
        alert("User Name must be filled out");
        return false;
    }
    if (x[0].value.length > 20) {
        alert("User Name must not exceed 20 characters");
        return false;
    }
    if (!/^[A-Za-z ]+$/.test(x[0].value)) {
        alert("User Name must contain alphabets only");
        return false;
    }
	if (x[1].value.trim() === "") {
        alert("Seller Name must be filled out");
        return false;
    }
    if (x[1].value.length > 20) {
        alert("Seller Name must not exceed 20 characters");
        return false;
    }
    if (!/^[A-Za-z ]+$/.test(x[1].value)) {
        alert("Seller Name must contain alphabets only");
        return false;
    }

    if (x[2].value.trim() === "") {
        alert("Shop Name must be filled out");
        return false;
    }
    if (x[2].value.length > 30) {
        alert("Shop Name must not exceed 30 characters");
        return false;
    }
    if (!/^[A-Za-z ]+$/.test(x[2].value)) {
        alert("Shop Name must contain alphabets only");
        return false;
    }

    if (x[3].value.trim() === "") {
        alert("Phone number must be filled out");
        return false;
    }
    if (!/^\d{10}$/.test(x[3].value)) {
        alert("Phone number must contain exactly 10 digits");
        return false;
    }

    if (x[4].value.trim() === "") {
        alert("Email-ID must be filled out");
        return false;
    }
    if (x[4].value.length > 50) {
        alert("Email-ID must not exceed 50 characters");
        return false;
    }
    if (!/^\w+@[a-zA-Z_]+\.[a-zA-Z]{2,3}$/.test(x[4].value)) {
        alert("Invalid Email-ID format");
        return false;
    }

    if (x[5].value.trim() === "") {
        alert("Address must be filled out");
        return false;
    }
    if (x[5].value.length > 50) {
        alert("Address must not exceed 50 characters");
        return false;
    }

    if (x[6].value.trim() === "") {
        alert("Password must be filled out");
        return false;
    }
    if (x[6].value.length < 6) {
        alert("Password must be at least 6 characters long");
        return false;
    }
    if (x[6].value.length > 15) {
        alert("Password must be maximum 15 characters long");
        return false;
    }

    if (x[6].value !== x[7].value) {
        alert("Your password does not match the confirmation password");
        return false;
    }

    return true;
}</script>
</body>
</html>