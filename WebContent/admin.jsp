<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>

</head>
<header>
    <h1 align="center" color="33CCFF"><font face="cursive" color="#3399FF">
        <a href="index.jsp" class ="a">Ollivender's Magical Wand Shop</a></font></h1>
<%
    // show current logged user
    String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
    if(username != null){
        out.print("<h4 align=\"center\">Hi, Administrator</h4>");
        out.print("<h5 align=\"center\">"+username+"</h5>");
    }
       
%>

<hr style="height:1px;border:none;border-top:1px solid rgb(51,204,255);" />	
</header>


<body>
    <h2 align="center"><a href="">Add new product</a></h2>
    <h2 align="center"><a href="">delete product</a></h2>


<%@ include file="jdbc.jsp" %>

<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
   
    String str = null;
    if(username!=null){
        try{
            getConnection();		
            String sql = "SELECT admin FROM customer where userid = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1,username);		
            ResultSet rst = pstmt.executeQuery();
        
            while(rst.next()){
                if(rst.getInt(1) == 1){  
                    str = username;
                }
            }
                     
    } 
    catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException ex){}
    }	    
}



if(str == null){
    response.sendRedirect("adminerror.jsp");
}




%>

<%


NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);


try{		
    getConnection();
    
    double total=0;
    Statement stmt2 = con.createStatement();
    ResultSet rstt = stmt2.executeQuery("select totalAmount from ordersummary");
    while(rstt.next()){
        total = total + rstt.getDouble(1);
    }
    
    out.print("<h4 align=\"center\">Total sales: "+currFormat.format(total)+"</h4>");
    
    
    Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customer.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");		
	String sql = "SELECT productId, quantity, price FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId WHERE ordersummary.orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	out.println("<table border=\"1\" align=\"center\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst.next()){
			out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getString(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+ " " + rst.getString(5)+"</td>"+"<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");
			pstmt.setInt(1, rst.getInt(1));
			ResultSet rst2 = pstmt.executeQuery();
			out.println("<tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
			out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
			while(rst2.next()){
				out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getInt(2)+"</td>"+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
			}
			out.println("</tr></td></table>");
	}
    out.println("</table>");
    
}
catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}finally{
    closeConnection();
}

// Make sure to close connection
%>
</body>
</html>

