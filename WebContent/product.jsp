<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
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
        margin-top: 50px;
        float: left;
        width: 300px;
        height: 450px;
    }
    #rightdiv{
        margin-top: 50px;
        float: right;
        width: 300px;
        height: 450px;
    }
    #review{
        margin-bottom: 10px;
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


    //review
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> reviewList = (HashMap<String, ArrayList<Object>>) session.getAttribute("reviewList");
    
    if (reviewList == null){
        reviewList = new HashMap<String, ArrayList<Object>>();
    }
    ArrayList<Object> review = new ArrayList<Object>();
    //review.add(customerId);
    //review.add(rating);
    //review.add(date);
    //review.add(content);
    
    out.println("<div id=\"main\"><h2>Review on this product</h2>");
    out.println("<table id=\"review\"><h4>Write a review for this product:</h4>");
    out.println("<td><input type=\"text\" name=\"review\" size=\"50\"></td>");


    out.println("</table>");
    String sql2 = "SELECT reviewRating, reviewDate, productId, reviewComment FROM review WHERE productId = '"+productId+"'";
    PreparedStatement pstmt2 = con.prepareStatement(sql2);		
    ResultSet rst2 = pstmt2.executeQuery();
    while(rst2.next()){
        out.println("<div id=\"review\">");
        out.println("<table><tr><th>Rating</th><td>"+rst2.getInt(1)+"</td><th>Reviewed on </th><td>"+rst2.getString(2)+"</td></tr>");
        out.println("<tr><th>Comments </th><td>"+rst2.getString(4)+"</td></tr>");
        out.println("</table></div>");
    }
    out.println("</div>");

    //reviewList.put(customerId,review);
    session.setAttribute("reviewList", reviewList);


    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}
%>


</body>
</html>

