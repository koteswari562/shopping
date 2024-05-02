<%@ page import="java.util.Map" %>
<%@ page import="shop.cart.Cart" %>
<%@ page import="shop.cart.Product" %>
<%@ page import="java.util.Iterator" %>
<%
    // Retrieve Cart from session
    Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    	 h3 {
            text-align: center;
      }
    </style>
</head>
<body>
<div class="container">
<h3>Order Details</h3>
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
                        <h5 class="card-title">Product: <%= product.getName() %></h5>
                        <p class="card-text">Price: <%= product.getPrice() %></p>
                        <p class="card-text">Quantity: <%= quantity %></p>
                       
                        
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
        <%-- Retrieve totalPrice from the request parameters --%>
<% Double totalPrice = Double.parseDouble(request.getParameter("totalPrice")); %>

<%-- Use totalPrice as needed in the JSP --%>
<h3>Total Price: <%= totalPrice %></h3>
    </div>
</body>
</html>

