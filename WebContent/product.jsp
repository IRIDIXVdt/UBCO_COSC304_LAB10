<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ollivander's Magical Wand Shop</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<%@ include file="header.jsp" %>
    



<style>
    #main{
        height: 550px;
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:2px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
	    width: 1000px;
	    margin-top:20px;
        margin-left:auto;
        margin-right:auto;
    }
    #leftdiv{
        width: 20%;
        margin-left: 20%;
        margin-top: 50px;
        float: left;
        height: 450px;
        
    }
    #rightdiv{
        width: 30%;
        margin-right: 12.5%;
        margin-top: 50px;
        float: right;
        height: 450px;
    }
    
    #input{
        margin-top: 30px;
        margin-bottom: 50px;
        margin-left: 40px;
        width: 50%;
        text-align: left;
        position: relative;
    }
    .desc{ text-align: left; width: 250px; color:rgb(219, 217, 217);font-family: Arial, Helvetica, sans-serif;}
    .desc:hover{
        font-family: CenturyGothic; font-size: 30px; font-style: normal; 
	    font-variant: small-caps; font-weight: 400;  
	    color:rgb(255, 255, 255);
	    text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
    }
    .pname{font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	font-variant: small-caps; font-weight: 400;  
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;}
    .detail{ color:rgb(219, 217, 217);font-family: Arial, Helvetica, sans-serif; font-size: 20px;}

    .c:hover{ color:rgb(250, 250, 250);font-family: Arial, Helvetica, sans-serif; font-size: 30px; text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.c:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.c:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.c{ text-decoration: none;}


    .addcart{ width: 300px;
        margin-left: 5px;
        margin-top: 130px;
        position: relative;
        height: 250px;}

    form{
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:2px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
	    width: 500px;
	    margin-top:20px;
        margin-left:auto;
        margin-right:auto;
    }
     .reviewTitle{
        font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	    font-variant: small-caps; font-weight: 400;  
	    color:rgb(255, 255, 255);
	    text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
        text-align: center;
    } 
    .review{
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:2px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
        width: 50%;
        margin-left: 25%;
        margin-right: 25%;
        margin-bottom: 20px;
        text-align: center;
    }


   
    
    
</style>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
    



<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);


try ( Connection con = DriverManager.getConnection(url, uid, pw);) {	// Make the connection	
    String sql = "SELECT product.productId, productName, productPrice, productImageURL, SUM(quantity) AS totalQ, productDesc FROM product JOIN productinventory ON product.productId = productinventory.productId WHERE product.productId = '"+productId+"' GROUP BY product.productId, productName, productPrice, productImageURL, productDesc";
    PreparedStatement pstmt = con.prepareStatement(sql);		
    ResultSet rst = pstmt.executeQuery();
    
    out.println("<div id=\"main\" align=\"center\">" );
    while(rst.next()){
        if(rst.getString(4) != null){    
            out.println("<div id=\"leftdiv\"><img src = " + rst.getString(4) + " width=\"250px\"><div class=\"desc\"><h4>"+rst.getString(6)+"</h4></div></div>");   
        }else{
            out.println("<div id=\"leftdiv\"><div class=\"desc\"><h4>"+rst.getString(6)+"</h4></div></div>");
        }
        
        String nameReplace = rst.getString(2).replace(" ", "%20");
        out.println("<div id=\"rightdiv\"><h2 class=\"pname\">"+rst.getString(2)+"</h2>");
        out.println("<table class=\"detail\"><tr><th>Product Id</th><td>"+rst.getInt(1)+"</td></tr>");
        out.println("<tr><th>Price</th><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
        out.println("<tr><th>In Stock</th><td>"+rst.getInt(5)+"</td></tr>");
        out.println("</table>");
        out.println("<div = class=\"addcart\"><h3><a class=\"c\" href=addcart.jsp?id=" +rst.getInt(1)+ "&name=" +nameReplace+ "&price=" +rst.getString(3)+ ">Add to Cart</a></h3>");
        out.println("<h3><a class=\"c\" href=\"listprod.jsp\">Continue Shopping</a></h3></div></div>");
    }
    out.println("</div>");
    //review
    out.println("<form name=\"MyReview\" method=\"post\" action=\"postreview.jsp?id="+productId+"\">");
    out.println("<div id=\"box\"><h2 class =\"reviewTitle\">Reviews about this product</h2>");
    out.println("<div id=\"input\"><h4 style=\"color:rgb(255, 255, 255)\">Rate and Write a review :</h4>");
    out.println("<label style=\"color:rgb(255, 255, 255)\">Rate: </label><select  name=\"rate\" style=\" width:150px; font-size:15px;\">");
    out.println("<option value=\"5\">5</option>");
    out.println("<option value=\"4\">4</option>");
    out.println("<option value=\"3\">3</option>");
    out.println("<option value=\"2\">2</option>");
    out.println("<option value=\"1\">1</option>");
    out.println("<option value=\"0\">0</option>");
    out.println("</select>");
   // <input type=\"textarea\" required=\"required\" name=\"content\" size=\"50\">
    out.println("<br><label style=\"color:rgb(255, 255, 255)\">Review: </label> <textarea  name=\"content\"  cols=\"50\" rows=\"10\"　maxlength=\"20\"></textarea>");
   
    out.println("<input class=\"submit\" type=\"submit\" name=\"Submit1\" value=\"Submit review\">");
    out.println("</div></div></form>");

    String sql2 = "SELECT reviewRating, reviewDate, productId, reviewComment FROM review WHERE productId = '"+productId+"' ORDER BY reviewRating DESC";
    PreparedStatement pstmt2 = con.prepareStatement(sql2);		
    ResultSet rst2 = pstmt2.executeQuery();
    out.println("<div class=\"review\"> <table border=\"2px\" align=\"center\" frame=\"void\">");
    out.println("<tr><td><h4 class =\"reviewTitle\">Rating</h4></td><td><h4 class =\"reviewTitle\">Reviewed at</h4></td><td><h4 class =\"reviewTitle\">Comment</h4></td></tr>");
    while(rst2.next()){
        String date = rst2.getString(2);
        date = date.substring(0,19);
        out.println("<tr><td style=\"color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif;\" align=\"center\">"+rst2.getInt(1)+"</td><td style=\"color:rgb(255, 255, 255)\" align=\"center\">"+date+"</td><td style=\"color:rgb(255, 255, 255)\">"+rst2.getString(4)+"</td></tr>");
    }
    out.println("</table></div>");
    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}
%>


</body>
</html>
