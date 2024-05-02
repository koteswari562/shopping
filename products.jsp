<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Display</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* Style for cart icon */
    #cartIcon {
        position: fixed;
        top: 20px;
        right: 20px;
        font-size: 24px;
        color: #333;
        cursor: pointer;
    }

    /* Custom card styles */
    .product-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 20px;
        margin-left:10%;
        width: 35%; /* Set the width of the card */
    }

    .product-card .card-img-top {
        object-fit: cover;
        height: 250px; /* Set the height of the product image */
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    .product-card .card-body {
        padding: 15px;
    }

    .product-card .card-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-card .card-text {
        font-size: 16px;
        margin-bottom: 10px;
    }

    .product-card .btn-primary {
        width: 100%;
    }
</style>
<script>
$(document).ready(function(){
    $("#category").change(function(){
        var categoryId = $(this).val();
        $.ajax({
            url: "ProductsServlet",
            method: "POST",
            data: {category: categoryId},
            success: function(data){
                $("#products").empty();
                
                $.each(data, function(index, product){
                    var card = $("<div>").addClass("card product-card");
                    var cardBody = $("<div>").addClass("card-body");
                    var productImage = $("<img>").addClass("card-img-top").attr("src", product.imgpath); 
                    var productName = $("<h5>").addClass("card-title").text(product.name);
                    var productPrice = $("<p>").addClass("card-text").text("Price: " + product.price);
                    var addToCartButton = $("<button>").addClass("btn btn-primary").text("Add to Cart");
                    
                    addToCartButton.click(function(){
                        $.ajax({
                            url: "CartServlet",
                            method: "POST",
                            data: {productId: product.id},
                            dataType: "text",
                            success: function(response){
                                console.log("Product added to cart:", product);
                            },
                            error: function(xhr, status, error){
                                console.error("Error adding product to cart:", error);
                            }
                        });
                    });
                    
                    cardBody.append(productImage, productName, productPrice, addToCartButton);
                    card.append(cardBody);
                    $("#products").append(card);
                });
            }
        });
    });
    
    // Redirect to cartdisplay.jsp when cart icon is clicked
    $("#cartIcon").click(function() {
        window.location.href = "cartdisplay.jsp";
    });
});
</script>
</head>
<body>
    <div class="container">
        <h2>Products</h2>
        <div class="row">
            <div class="col-md-6">
                <select id="category" class="form-control">
                    <option>Category</option>
                    <option value="1">Mobiles</option>
                    <option value="2">Clothes</option>
                </select>
            </div>
        </div>
        <div class="row mt-3" id="products">
            <!-- Product cards will be dynamically added here -->
        </div>
    </div>
    <!-- Cart icon at the top right corner -->
    <i id="cartIcon" class="fas fa-shopping-cart"></i>

    <!-- jQuery and Bootstrap JavaScript libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
