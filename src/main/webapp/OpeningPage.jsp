<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>O&N Mart</title>

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f2f2f2;
        }

        .firstdiv {
            background-color: #3CAF50;
            color: white;
            padding: 20px;
            /* text-align: center; */
            /* font-size: 50px; */
            display: flex;
        }
        .title{
            background-color: #3CAF50;
            color: white;
            /* padding: 20px; */
            text-align: center;
            margin-left: 430px;
            font-size: 50px;
            margin-right: 200px;
        }
        .dropdown{
            position: relative;
            margin-left: 10px; 
            /* margin-right: 10px; */
            margin-top: 10px;
            display: inline-block;
        }

        .login-button{
            background-color: #3CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 30px;
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
        .gallery-section{
            text-align: center;
            margin: 2%;
        }
        .gallery-container {
            text-align: center;
            position: relative;
        }

        .gallery-image {
            display: none;
            max-width: 100%;
            height: auto;
        }

        .gallery-button {
            background-color: #3CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }

        .gallery-button-left {
            left: 20px;
        }

        .gallery-button-right {
            right: 20px;
        }
        .container {
            /* display: flex; */
            /* justify-content: center; */
            align-items: center;
            /* height: 400px; */
            margin-top:1%;
            margin-bottom:2%;
            margin-left:2%;
        }
        h2{
            color: black;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            /* font-family: 'Times New Roman', Times, serif; */
            /* font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif; */
        }
        p{
            font-size: 20px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }
    </style>
</head>
<body>
    <div class="firstdiv">
        <div class="title">
            O&N Mart
        </div>
        <div class="dropdown">
            <button class="login-button"><u>Buyer</u></button>
            <div class="dropdown-content">
                <a href="Buyer_Login.jsp">Login</a>
                <a href="Buyer_SignUp.jsp">Sign-up</a>
            </div>
        </div>
        <div class="dropdown">
            <button class="login-button"><u>Seller</u></button>
            <div class="dropdown-content">
                <a href="Seller_Login.jsp">Login</a>
                <a href="Seller_SignUp.jsp">Sign-up</a>
            </div>
        </div>
        
    </div>
    <div class="gallery-section">
        <div class="gallery-container">
            <img class="gallery-image" src="bb1.webp" alt="Grocery Item 1">
            <img class="gallery-image" src="bb2.webp" alt="Grocery Item 2">
            <img class="gallery-image" src="bb3.webp" alt="Grocery Item 3">
            <!-- Add more images as needed -->
            <button class="gallery-button gallery-button-left" onclick="previousImage()">&#8249;</button>
            <button class="gallery-button gallery-button-right" onclick="nextImage()">&#8250;</button>
        </div>
    </div>
    <div class="container">
        <h2>O&N Mart - Online grocery store</h2>
        <p>With an experience of more than 10 years. We have served more than 10 lakh customers.We have more than 30 thousand sellers.  Now O&N family is growing faster, stronger and bigger.</p>

    </div>
    
    <%@ include file="Footer.html" %>

    <script>
        let currentImageIndex = 0;
        const galleryImages = document.querySelectorAll('.gallery-image');

        function showCurrentImage() {
            galleryImages.forEach((image, index) => {
                if (index === currentImageIndex) {
                    image.style.display = 'block';
                } else {
                    image.style.display = 'none';
                }
            });
        }

        function previousImage() {
            if (currentImageIndex > 0) {
                currentImageIndex--;
            } else {
                currentImageIndex = galleryImages.length - 1;
            }
            showCurrentImage();
        }

        function nextImage() {
            if (currentImageIndex < galleryImages.length - 1) {
                currentImageIndex++;
            } else {currentImageIndex = 0;
            }
            showCurrentImage();
        }

        showCurrentImage();
    </script>
</body>
</html>

