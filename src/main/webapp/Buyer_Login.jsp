<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buyer Login</title>
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
	<form action="" method="post" onsubmit="return validationForm()">
	<h2>Buyer Login</h2>
	<label>User Name:</label>
	<input type="text" name="UserName" required><br><br>
	<label>Password:</label>
	<input type="password" name="Password" required><br><br> 
	<button type="submit">Enter</button>
	<button type="reset">Reset</button>
	</form>
<%
	String UserName=request.getParameter("UserName");
if(UserName!=null){
Properties prop=getConnectionData();
String url=prop.getProperty("db.url");
String user=prop.getProperty("db.user");
String psswd=prop.getProperty("db.passwd");
Class.forName("com.mysql.jdbc.Driver");
try(Connection con=DriverManager.getConnection(url,user,psswd)){
	PreparedStatement stmt=con.prepareStatement("Select Password from Buyer where UserName=?");
	String password=request.getParameter("Password");
	stmt.setString(1,UserName);
	ResultSet rs=stmt.executeQuery();

	if(rs.next()){
		if(rs.getString(1).equals(password)){
			session.setAttribute("Name",UserName);
			response.sendRedirect("BuyerHomePage.jsp");
		}
		else {
			out.println("<script>alert('Incorrect Password')</script>");
		}
	}
	else{
		out.println("<script>alert('User Name doesnot exist.Please Go back and Register/ Write correct User Name')</script> ");
	}
	
}catch(Exception e){
	e.printStackTrace();
}
}
%>
    </div>

<%@ include file="Footer.html" %>
<script>
function validationForm(){
	var x=document.forms[0];
	if (x[0].value.trim()===""){
		alert("UserName cannot be empty");
		return false;
	}
	if (x[1].value.trim()===""){
		alert("Password cannot be empty");
		return false;
	}
	return true;
}</script>

</body>
</html>