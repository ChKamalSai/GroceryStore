<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding Items(Seller)</title>
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
		.item{
			margin-left:10%;
			margin-right:10%;
			margin-bottom:10%;
			font-size:30px;
			text-align:center;
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

<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a href="sessionLogout">Logout</a>
	</div>
</div>

<div class="item">
	<h2>Add Item</h2>
    <form action="Seller" method="post" enctype="multipart/form-data" onsubmit="return validationForm()">
        <label for="itemName">Item Name:</label>
        <input type="text" name="itemName" required><br><br>

        <label for="description">Description:</label>
        <input type="text" name="description" required><br><br>

        <label for="stock">Stock:</label>
        <input type="number" name="stock" required><br><br>

        <label for="price">Price:</label>
        <input type="number" name="price" required><br><br>

     	<label for="unit">Unit:</label>
		<input type="text" name="unit" required><br><br>

        <label for="image">Image:</label>
        <input type="file" id="image" name="image" accept="image/*" required><br>
		<span id="error" style="color:red;">* Maximum size 5mb</span><br><br>
        <button type="submit">Add Item</button>
        <button type="reset">Reset</button>
    </form>
</div>
 
<%@include file="Footer.html" %>
<script>
    function validationForm() {
        var x=document.forms[0];
        if (x[0].value.trim() === "") {
            alert("Item Name is required");
            return false;
        }
        if(x[0].value.length>20){
        	alert("Item Name should not be more than 20 characters");
        	return false;
        }
        if(!/^[A-Za-z]+$/.test(x[0].value)){
        	alert("Item Name should contain only alphabets]");
        	return true;
        }

        if (x[1].value.trim() === "") {
            alert("Description is required");
            return false;
        }
        if (x[1].value.length>50){
        	alert("Description should not be more than 50 characters");        	
        	return false;
        }

        if (isNaN(x[2].value) || x[2].value <= 0) {
        	 alert("Stock must be a positive number");
             return false;
         }

         if (isNaN(x[3].value) || x[3].value <= 0) {
             alert("Price must be a positive number");
             return false;
         }
         if(x[4].value.trim()===""){
        	 alert("Unit cannot be null");
        	 return false;
         }
         if(x[4].value.length>20)){
        	 alert("Unit cannot be more than 20 characters");
        	 return false;
         }
         if(/^[A-Za-z ]+$/.test(x[4].value)){
        	 alert("Unit should contain only alphabets");
        	 return false;
         }

         if (x[5].value.trim() === "") {
             alert("Image is required");
             return false;
         }

         return true;
     }
    var x=document.getElementById("image");
    //var error=document.getElementById("error");
    x.addEventListener("change",function(){
    	const file=this.files[0];
    	const maxsize=5*1024*1024;
    	if(file && file.size>maxsize){
    		//error.textContent="Image size is more than 5mb. File should be less than 5mb";
    		alert("Image size is more than 5mb. File should be less than 5mb");
    		this.value="";
    	}else{
    		error.textContent="";
    	}
    });
 </script>
        
</body>
</html>