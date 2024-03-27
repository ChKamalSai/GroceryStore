<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buyer Registration</title>
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
        ex.printStackTrace();
    }

    return props;
}
 %>
    
    <div class="login_form">
    <h2>Buyer Registration</h2>
	<form action="" method="post" onsubmit="return validateForm()">
			<label >User Name:</label>
            <input type="text" name="name" placeholder="For Unique Identification" required><br><br>

            <label >Mobile number:</label>
            <input type="tel" name="mobile" required><br><br>

            <label >Email:</label>
            <input type="email" name="email" required><br><br>

            <label >Password:</label>
            <input type="password" name="password" required><br><br>

            <label >Confirm password:</label>
            <input type="password" " required><br><br>

            <button type="submit">Submit</button>
            <button type="reset">Reset</button>
        </form>
    <%
	String UserName=request.getParameter("name");
if(UserName!=null){
    Properties prop=getConnectionData();
String url=prop.getProperty("db.url");
String user=prop.getProperty("db.user");
String psswd=prop.getProperty("db.passwd");
Class.forName("com.mysql.jdbc.Driver");
	try(Connection con=DriverManager.getConnection(url,user,psswd)){
	String mobile=request.getParameter("mobile");
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	
	PreparedStatement prp1=con.prepareStatement("Select * from Buyer where UserName=?");
	prp1.setString(1,UserName);
	PreparedStatement prp2=con.prepareStatement("Select * from Buyer where MobileNumber=?");
	prp2.setString(1,mobile);
	PreparedStatement prp3=con.prepareStatement("Select * from Buyer where Email_ID=?");
	prp3.setString(1,email);
	ResultSet rs=prp1.executeQuery();
	if(rs.next()){
		out.println("<script>alert('Change the UserName as it already exists'')<script>");
	}
	else{
		ResultSet rs1=prp2.executeQuery();
		if(rs1.next()){
		out.println("<script>alert('Change the Mobile Number as it already exists'')<script>");
		}
		else{
			ResultSet rs2=prp3.executeQuery();
			if(rs2.next()){
			out.println("<script>alert('Change the Email_ID as it already exists')<script>");
			}
			else{
				PreparedStatement stmt=con.prepareStatement("Insert into Buyer values(?,?,?,?)");
				stmt.setString(1,UserName);
				stmt.setString(2,mobile);
				stmt.setString(3,email);
				stmt.setString(4,password);
				stmt.executeUpdate();
				out.println("<script>alert('Account is created Successfully. Now you will be redirected to login page')</script>");
				response.sendRedirect("Buyer_Login.jsp");		
			}
		}
		}
	
}catch(Exception e){
	e.printStackTrace();
}
}
%>
    </div>
<%@ include file="Footer.html" %>
    <script>
        function validateForm() {
         
			var x=document.forms[0];
            if (x[0].value.trim() === "") {
                alert("User Name must be filled out");
                return false;
            }
            if (x[0].value.length > 10) {
                alert("User Name must not exceed 10 characters");
                return false;
            }
            if (x[1].value.trim() === "") {
                alert("Mobile number must be filled out");
                return false;
            }
            if (!/^\d{10}$/.test(x[1].value)) {
                alert("Mobile number must contain exactly 10 digits");
                return false;
            }
            if (x[2].value.trim() === "") {
                alert("Email must be filled out");
                return false;
            }
            if (!/^\w+@[a-zA-Z_]+\.[a-zA-Z]{2,3}$/.test(x[2].value)) {
                alert("Invalid email format");
                return false;
            }
            if (x[3].value.trim() === "") {
                alert("Password must be filled out");
                return false;
            }
            if (x[3].value.length < 6) {
                alert("Password must be at least 6 characters long");
                return false;
            }
            if (x[3].value !== x[4].value) {
                alert("Passwords do not match");
                return false;
            }

            return true; // Form will be submitted
        }
        
    </script>
</body>
</html>