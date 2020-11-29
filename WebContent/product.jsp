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
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);


try ( Connection con = DriverManager.getConnection(url, uid, pw);) {	// Make the connection	
    String sql = "SELECT productId, productName, productPrice   , productImageURL FROM Product WHERE productId = '"+productId+"'";
    PreparedStatement pstmt = con.prepareStatement(sql);		
    ResultSet rst = pstmt.executeQuery();
    
    while(rst.next()){
        out.println("<h2>"+rst.getString(2)+"</h2>");
        out.println("<table><tr><th>Id:</th><td>"+rst.getInt(1)+"</td></tr><tr><th>Price: </th><td>"
            +currFormat.format(rst.getDouble(3))+"</td></tr>");
        //out.println("<img src=\"img/"+rst.getInt(1)+".jpg\">");
        
        //out.println("<img src = " + rst.getString(4) + " >");
        //out.println("<img src=\"displayImage.jsp?id=" + rst.getInt(1) +" \">" );//rst.getInt(1)
        if(rst.getString(4) == null){
             //out.println("No pic in the server");
        }else{      
            out.println("<img src = " + rst.getString(4) + " >");        
            out.println("<img src=\"displayImage.jsp?id=" + rst.getInt(1) + "\">");//rst.getInt(1)
            //out.println("<img src=\"img/1_a.jpg\">");
            //out.println("<img style=\"-webkit-user-select: none;margin: auto;\" src=\"http://localhost/shop/displayImage.jsp?id=1\">");
        }
        out.println("</table>");
        out.println("<h3><a href=addcart.jsp?id=" +rst.getInt(1)+ "&name=" +rst.getString(2)+ "&price=" +rst.getString(3)+ ">Add to Cart</a></h3>");
        out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
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

