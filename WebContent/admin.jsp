<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>



<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>


<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);


String userName = (String) session.getAttribute("authenticatedUser"); // get user name from authenticatedUser
out.println("<h3>Administrator Sales Report by Day</h3>"+"Signed in as: "+userName);
try {	// Make the connection	
	getConnection();
    
    String sql = "select CONCAT(YEAR(orderDate),'-',MONTH(orderDate),'-',DAY(orderDate)), totalAmount"
    +" from ordersummary join customer on ordersummary.customerId = customer.customerId where userid = ? order by totalAmount";
    
    PreparedStatement pstmt = con.prepareStatement(sql);	
	pstmt.setString(1,userName);
	ResultSet rst = pstmt.executeQuery();
    out.println("<table class=\"table\" border=\"1\"><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    while(rst.next()){
        out.println("<tr><td>"+ rst.getString(1)+"</td><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>" );
        
	}
	out.println("<table>");
    


    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}finally{
    closeConnection();
}

// Make sure to close connection
%>
</body>
</html>

