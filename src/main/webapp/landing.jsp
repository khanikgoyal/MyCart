<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nature's Vibe - Clay Utensils</title>
    <%@ include file="componants/common_css_js.jsp" %>
     <style>
    .carousel-inner img {
      width: 100%;
      height: 70vh; /* Adjust this as needed */
      object-fit: cover;
    }
     .carousel-caption {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
    }
  </style>
</head>
<body>

	<%@ include file="componants/navbar.jsp" %>
    <div class="container-fluid p-0">
    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img class="d-block w-100" src="img/bn-1.jpg" alt="First slide">
           <div class="carousel-caption text-center">
            <h5>Welcome to Our Shop</h5>
            <p>Find the best products here</p>
            <a class="btn btn-primary" href="#shop">Shop Now</a>
          </div>
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="img/bg1.png" alt="Second slide">
           <div class="carousel-caption text-center">
            <h5>Welcome to Our Shop</h5>
            <p>Find the best products here</p>
            <a class="btn btn-primary" href="#shop">Shop Now</a>
          </div>
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="img/bg3.jpg" alt="Third slide">
           <div class="carousel-caption text-center">
            <h5>Welcome to Our Shop</h5>
            <p>Find the best products here</p>
            <a class="btn btn-primary" href="#shop">Shop Now</a>
          </div>
        </div>
      </div>
      <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    </div>
    
    <div class="container-fluid p-0 color-custom">
    	<div class="row">
    	 	<div class="col-8 mx-3 mt-5">
    	 		<p>Re-Introduction to Vedic Style of Cooking
Vedic Cooking is more focused on retaining the health benefits of the food as compared to Modern Style that is more confined to taste buds.
In order to help community by providing the means to retain food nutrients, have made us launch complete range of Terracotta/Earthen CookWare.

Health Benefits of Using Clay Pots:
Clay is somewhat porous therefore heat and moisture circulate through the pot unlike metal & enamel pots.
Clay is Alkaline in nature, hence it interacts with the acidity in the food and neutralize the pH balance. Thereby reducing the common stomach problems, that even youngsters in the grab of due to excessive consumption of Fast Foods.
Clay pots add many essential nutrients like calcium, phosphorus, iron, magnesium and sulphur to food.
Clay contains all the possible vitamins, even vitamin B12.
The food cooked in Clay pots is much tastier.
Cooking in the Jagannath Temple in Puri & Many Other Temples:
Lord Jagannath’s kitchen is considered to be the largest kitchen in the world. All the cooking pots in the Jagannath temple in Puri are made of clay and are used only one time in cooking.

The Jagannath Mandir uses the services of around three hundred full-time potters to supply the cooking vessels for the Lord of the Universe.

Only red colored pots are used, and once a clay pot has been put on the fire it cannot be reused. New cooking pots are called kuduas. Their thick walls retain heat very well. After cooking and offering, the prasada stays warm for four to five hours.</p>
    	 	</div>
    	 	<div class="col-4"></div>
    	 	
    	</div>
    	
    </div>
</body>
</html>
    