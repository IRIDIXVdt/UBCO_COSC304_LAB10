
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Magic Wand Shop Order List</title>

</head>

<%@ include file="header.jsp" %>
<style>
	h1{
		font-family: CenturyGothic; font-size: 50px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
	}
	div{
		background-color: rgba(0,0,0,0.3);  
		border:1px solid #e7eaf1; 
		border-radius:2px; 
		box-shadow: 0 1px 3px rgba(0,37, 55, .05);
		box-sizing: border-box;
		width: 700px;
		margin-top:20px;
    	margin-left:auto;
    	margin-right:auto;
	}

	table{
		margin-top:20px;
		border:2px solid rgb(255, 255, 255); 
		border-radius:2px; 
		border-collapse:collapse;
		margin-bottom: 20px;
	}

	th{
		font-family: CenturyGothic; font-size: 20px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
	}

	td{
		font-family: Arial, Helvetica, sans-serif; font-size: 20px; font-style: normal; 
		text-align:center;
		color:rgba(255, 255, 255, 0.829);
		text-shadow: 0 0 8px #68646494, 0 0 8px #9b90908f;
	}
	.t{
		margin-left:32%;
		margin-bottom: 20px;
		position: relative;
	}
	
</style>
<body background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">

<h1 align="center">Order List</h1>
<div>
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
	out.println("<table align=\"center\" border= \"1\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst.next()){
			out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getString(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+ " " + rst.getString(5)+"</td>"+"<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");
			
			pstmt.setInt(1, rst.getInt(1));
			ResultSet rst2 = pstmt.executeQuery();
			out.println("<tr align=\"right\"><td colspan=\"5\"><table border= \"1\" class=\"t\">" );
			out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
			while(rst2.next()){
				out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getInt(2)+"</td>"+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
			}
			out.println("</tr></td></table>");
	}
	out.println("</table></div>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>

</body>
</html>

