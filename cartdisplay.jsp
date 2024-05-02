<%@ page import="java.util.Map" %>
<%@ page import="shop.cart.Cart" %>
<%@ page import="shop.cart.Product" %>

<%
    // Retrieve Cart from session
    Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart Items</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>

        /* Custom card styles */
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            width: 100%; /* Set the width of the card to fill the column */
        }

        .product-image {
            object-fit: cover;
            height: 250px; /* Set a fixed height for the product image */
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        .card-body {
            padding: 15px;
        }

        .card-body .card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card-body .card-text {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .btn-primary {
            width: 20%; /* Button width takes full card width */
        }
    </style>
    
</head>
<body>
    <h1>Cart Items</h1>
    <div class="container">
        <div class="row">
            <% 
                if (cart != null) {
                    // Display cart items
                    Map<Product, Integer> items = cart.getItems();
                    if (items != null && !items.isEmpty()) {
                        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
                            Product product = entry.getKey();
                            int quantity = entry.getValue();
            %>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                    <img src="<%= product.getImgpath() %>" class="product-image">
                        <h5 class="card-title">Product: <%= product.getName() %></h5>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                        <p class="card-text">Quantity: <%= quantity %></p>
                       <p class="card-text">
                           <button class="btn btn-sm btn-secondary" onclick="decrementQuantity(<%= product.getId() %>,-1
                           )">-</button>
                            <span id ="quantity_<%= product.getId() %>" class="quantity"><%= quantity %></span>
                            <button class="btn btn-sm btn-secondary" onclick="incrementQuantity(<%= product.getId() %>, 1)">+</button>
                        </p>
                       
                        
                    </div>
                </div>
            </div>
            <%          
                        }
                    } else {
            %>
            <div class="col">
                <p>No items in the cart.</p>
            </div>
            <%      
                    }
                } else {
            %>
            <div class="col">
                <p>Cart is empty.</p>
            </div>
            <%      
                }
            %>
        </div>
    </div>
    <div class="container">
        <div class="row mt-3">
            <div class="col text-center">
                <button class="btn btn-primary" onclick="checkout()">Checkout</button>
            </div>
        </div>
    </div>

    <script>
    function incrementQuantity(productId,quantity) {
        var quantityElement = $('.quantity#quantity_' + productId);
        var currentQuantity = parseInt(quantityElement.text());

        // Increment the current quantity by 1
        var newQuantity = currentQuantity + 1;

        // Update the displayed quantity
        quantityElement.text(newQuantity);
        updateQuantity(productId,quantity);
    }
    function decrementQuantity(productId,quantity) {
        var quantityElement = $('.quantity#quantity_' + productId);
        var currentQuantity = parseInt(quantityElement.text());

        // Increment the current quantity by 1
        var newQuantity = currentQuantity - 1;

        // Update the displayed quantity
        quantityElement.text(newQuantity);
        updateQuantity(productId,quantity);
    }
    function updateQuantity(productId, quantity) {
        // AJAX request to update quantity
        $.ajax({
            url: 'CartServlet',
            method: 'POST',
            data: {
                productId: productId,
                quantity: quantity
            },
            success: function(response) {
            	$('.quantity').text(response.quantity);
            	console.log("Quantity updated successfully");
            },
            error: function(xhr, status, error) {
                console.log('Error updating quantity:', error);
            }
        });
    }
    function checkout() {
        // Create a form element
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "CheckoutServlet"); // Set the action to your servlet URL
        
        // Submit the form
        document.body.appendChild(form);
        form.submit();
    }
    </script>
</body>
</html>