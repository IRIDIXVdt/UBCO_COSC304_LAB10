<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    #main{
        height: 450px;
    }
    #leftdiv{
        width: 20%;
        margin-left: 27.5%;
        margin-top: 50px;
        float: left;
        height: 450px;
    }
    #rightdiv{
        width: 20%;
        margin-right: 27.5%;
        margin-top: 50px;
        float: right;
        height: 450px;
    }
    #box{
        width: 50%;
        margin-left: 25%;
        margin-right: 25%;
        text-align: center;
    }
    #input{
        margin-top: 30px;
        margin-bottom: 50px;
        margin-left: 25%;
        margin-right: 25%;
        width: 50%;
        text-align: left;
    }
    #review{
        width: 40%;
        margin-left: 30%;
        margin-right: 30%;
        margin-bottom: 20px;
        text-align: center;
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
    
    out.println("<div id=\"main\">");
    while(rst.next()){
        if(rst.getString(4) != null){    
            out.println("<div id=\"leftdiv\"><img src = " + rst.getString(4) + " width=\"250px\"><div><h4>"+rst.getString(6)+"</h4></div></div>");   
        }else{
            out.println("<div id=\"leftdiv\"><h4>"+rst.getString(6)+"</h4></div>");
        }
        
        String nameReplace = rst.getString(2).replace(" ", "%20");
        out.println("<div id=\"rightdiv\"><h2>"+rst.getString(2)+"</h2>");
        out.println("<table><tr><th>Product Id</th><td>"+rst.getInt(1)+"</td></tr>");
        out.println("<tr><th>Price</th><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
        out.println("<tr><th>In Stock</th><td>"+rst.getInt(5)+"</td></tr>");
        out.println("</table>");
        out.println("<h3><a href=addcart.jsp?id=" +rst.getInt(1)+ "&name=" +nameReplace+ "&price=" +rst.getString(3)+ ">Add to Cart</a></h3>");
        out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3></div>");
    }

    //review
    out.println("<form name=\"MyReview\" method=\"post\" action=\"postreview.jsp\">");
    out.println("<div id=\"box\"><h2>Reviews about this product</h2>");
    out.println("<div id=\"input\"><h4>Rate and Write a review :</h4>");
    out.println("<h5>Rate (0-10): <input type=\"text\" name=\"rate\" size=\"50\"></h5>");
    out.println("<h5>Review: <input type=\"text\" name=\"content\" size=\"50\"></h5>");
    out.println("<input class=\"submit\" type=\"submit\" name=\"Submit1\" value=\"Submit review\">");
    out.println("</div></div></form>");

    String sql2 = "SELECT reviewRating, reviewDate, productId, reviewComment FROM review WHERE productId = '"+productId+"'";
    PreparedStatement pstmt2 = con.prepareStatement(sql2);		
    ResultSet rst2 = pstmt2.executeQuery();
    while(rst2.next()){
        out.println("<div id=\"review\">");
        out.println("<table><tr><th>Rating</th><td>"+rst2.getInt(1)+"</td><th>Reviewed on </th><td>"+rst2.getString(2)+"</td></tr>");
        out.println("<tr><th>Comments </th><td colspan=\"3\">"+rst2.getString(4)+"</td></tr>");
        out.println("</table></div>");
    }

    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> reviewList = (HashMap<String, ArrayList<Object>>) session.getAttribute("reviewList");
    if(reviewList != null){
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = reviewList.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> review = (ArrayList<Object>) entry.getValue();
            
            out.println("<div id=\"review\">");
            out.println("<table><tr><th>Rating</th><td>"+review.get(0)+"</td><th>Reviewed on </th><td>"+review.get(2)+"</td></tr>");
            out.println("<tr><th>Comments </th><td colspan=\"3\">"+review.get(1)+"</td></tr>");
            out.println("</table></div>");
        }
    }else{
        out.println("<div>no review</div>");
    }
    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}
%>


</body>
</html>

