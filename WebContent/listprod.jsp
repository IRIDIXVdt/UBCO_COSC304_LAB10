<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Ollivender's Magical Wand Shop</title>
</head>
<body>
	<h1>Search for the products you want to buy:</h1>
	<form method="get" action="listprod.jsp">
		<input type="text" name="productName" size="50">
		<input type="submit" value="Submit">
		<input type="reset" value="Reset"> (Leave blank for all products)
	</form>
	<h2>All Products</h2>
	<% 
		//Note: Forces loading of SQL Server driver
		String name = request.getParameter("productName"); // Get product name to search for
		if(name == null) name ="";		
		try{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e){
			out.println("ClassNotFoundException: " +e);
		}
		// Useful code for formatting currency values
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		try ( Connection con = DriverManager.getConnection(url, uid, pw);) {	// Make the connection	
			PreparedStatement pstmt = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%"+name+"%'");		
			ResultSet rst = pstmt.executeQuery();
			out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
			while (rst.next()){	// Print out the ResultSet and For each product create a link of the form	
				String nameReplace = rst.getString(2).replace(" ", "%20");	
				//add cart option
				out.print("<tr><td><a href=addcart.jsp?id="+rst.getInt(1)+"&name="+nameReplace+"&price="+rst.getString(3)+">Add to Cart</a></td><td>"+ "<a href=product.jsp?id=" + rst.getInt(1)+">"+rst.getString(2) + "</a></td><td>" + currFormat.format(rst.getDouble(3)) +"</td></tr>"+"\n");		
			}
			out.println("</table>");
		} catch (SQLException ex) { // Close connection with try catch
			out.println(ex); 
		}
	%>
</body>
</html>