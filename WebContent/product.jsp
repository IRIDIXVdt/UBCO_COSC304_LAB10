<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    #main{
        width: 45%;
        margin-left: 27.5%;
        margin-right: 27.5%;
    }
    #leftdiv{
        float: left;
        width: 300px;
        height: 600px;
    }
    #rightdiv{
        float: right;
        width: 300px;
        height: 600px;
    }
</style>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);


try ( Connection con = DriverManager.getConnection(url, uid, pw);) {	// Make the connection	
    String sql = "SELECT product.productId, productName, productPrice, productImageURL, quantity, productDesc FROM product JOIN productinventory ON product.productId = productinventory.productId WHERE product.productId = '"+productId+"'";
    PreparedStatement pstmt = con.prepareStatement(sql);		
    ResultSet rst = pstmt.executeQuery();
    
    while(rst.next()){
        out.println("<div id=\"main\">");
        if(rst.getString(4) != null){    
            out.println("<div id=\"leftdiv\"><img src = " + rst.getString(4) + " width=\"250px\">");   
            out.println("<table><td>"+rst.getString(6)+"</td></table></div>");
        }else{
            out.println("<div id=\"leftdiv\"><table><td>"+rst.getString(6)+"</td></table></div>");
        }
        
        String nameReplace = rst.getString(2).replace(" ", "%20");
        out.println("<div id=\"rightdiv\"><h2>"+rst.getString(2)+"</h2>");
        out.println("<table><tr><th>Product Id</th><td>"+rst.getInt(1)+"</td></tr>");
        out.println("<tr><th>Price</th><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
        out.println("<tr><th>In Stock</th><td>"+rst.getInt(5)+"</td></tr>");
        out.println("</table>");
        out.println("<h3><a href=addcart.jsp?id=" +rst.getInt(1)+ "&name=" +nameReplace+ "&price=" +rst.getString(3)+ ">Add to Cart</a></h3>");
        out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3></div>");
        out.println("</div>");
    }
    


    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}
// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

