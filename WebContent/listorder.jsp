
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Magic Wand Shop Order List</title>

</head>
<header>
	<h1 align="center" color="33CCFF"><font face="cursive" color="#3399FF">
		<a href="index.jsp" class ="a">Ollivender's Magical Wand Shop</a></font></h1>
<%
	// show current logged user
	String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
	if(username != null){
		out.print("<h4 align=\"center\">welcome!</h4>");
		out.print("<h5 align=\"center\">Signed in as: "+username+"</h5>");
	}
		
%>

<hr style="height:1px;border:none;border-top:1px solid rgb(51,204,255);" />	
</header>
<body>

<h1 align="center">Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{		
	// Write query to retrieve all order summary records
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
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>

</body>
</html>

