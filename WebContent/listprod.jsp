<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Ollivender's Magical Wand Shop</title>
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
</head>
<body>  <!--bgcolor="#BDBDBD"-->
	<style type="text/css">
	.i{width:150px;height:150px;}
	table{border-collapse:collapse;}
	a:hover{ color:rgb(167, 209, 16) }
	a:link{color:rgb(51,204,255);}
	a:visited{color:rgb(51,204,255);}
	.a{text-decoration: none;}
	.b{text-decoration: none;}
	.c{text-decoration: none;}
	</style>
	<div align="center">
		<h3>Top 5 sale: </h3>
		<marquee behavior="scroll" width="500" height="180" scrollamount="6" scrolldelay="60" onmouseover= "this.stop()" onmouseout= "this.start()">
	
		<%
		try{
			getConnection();
			PreparedStatement stmt = con.prepareStatement("select sum(quantity) as total, orderproduct.productId, productImageURL from orderproduct join product on orderproduct.productId = product.productId group by orderproduct.productId, productImageURL order by total desc");
			ResultSet bestSale = stmt.executeQuery();
			int i =0;
			
			while(bestSale.next() && i<5 ){
				out.println("<a target=\"cont\" href=product.jsp?id=" + bestSale.getInt(2)+">"
				+"<img src=\" "+ bestSale.getString(3)+" \" " +" width=\"150\" height=\"150\" border=\"1\" >"+"</a>");
				i++;				
			}		
		}catch (SQLException ex) { // Close connection with try catch
			out.println(ex); 
		}finally{
			try{closeConnection();}catch(SQLException e){}
		}	
	%>
		
	</marquee></div>
	
	<font face="Century Gothic" size="2" color="33CCFF" align="center">
		<h2 color="33CCFF">Search for the products you want to buy:</h2>
	</font>
	
	<form method="get" action="listprod.jsp" >
		<p align="center">
		<select size="1" name="categoryName">
		<option>All</option>
		<option>Springy</option>
		<option>Flexible</option>
		<option>Inflexible</option>
		<option>Swishy</option> 
		<option>Stiff</option> 
		<option>Brittle</option> 
		<option>Bendy</option> 
		<option>Pliable</option> 
		<option>Whippy</option>      
		</select>
		<input type="text" name="productName" size="50">
		<input type="submit" value="Submit"><input type="reset" value="Reset"></p>
	  </form>
	<h2 align="center">All Products</h2>
	<% 
		//Note: Forces loading of SQL Server driver
		String name = request.getParameter("productName"); // Get product name to search for
		String category = request.getParameter("categoryName");
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
			String sql1 = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%"+name+"%'";
			String sql2 = "SELECT productId, productName, productPrice FROM product join category on product.categoryId = category.categoryId WHERE productName LIKE '%"+name+"%' and categoryName = '"+category+"'";
			String sql3 = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%"+name+"%'";
			PreparedStatement pstmt;
			if(category == null)
				pstmt = con.prepareStatement(sql1);	
				else if(category.equals("All"))
					pstmt = con.prepareStatement(sql3);
					else
						pstmt = con.prepareStatement(sql2);
			ResultSet rst = pstmt.executeQuery();
			PreparedStatement pstmt2 = con.prepareStatement("SELECT categoryName FROM category join product on category.categoryId = product.categoryId where product.productName = ?");		
			
			out.println("<font face=\"Century Gothic\" size=\"2\" color=\"33CCFF\"><table align=\"center\" border=\"1\"><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			while (rst.next()){	// Print out the ResultSet and For each product create a link of the form		
				String nameReplace = rst.getString(2).replace(" ", "%20");
				pstmt2.setString(1,rst.getString(2));
				ResultSet rst2 = pstmt2.executeQuery();	
				//add cart option
				out.print("<tr><td><div><img src=\"img/"+rst.getInt(1)+".jpg\" class =\"i\"></div><a href=addcart.jsp?id="+rst.getInt(1)+"&name="+nameReplace+"&price="+rst.getString(3)+" class =\"b\">Add to Cart</a></td><td>"
					+ "<a href=product.jsp?id=" + rst.getInt(1)+" class =\"c\">"+rst.getString(2) + "</a></td><td>");
				if(rst2.next())		
					out.println(rst2.getString(1)+"</td><td>" + currFormat.format(rst.getDouble(3)) +"</td></tr>"+"\n");	
					
					
			}
			out.println("</table></font>");
		} catch (SQLException ex) { // Close connection with try catch
			out.println(ex); 
		}
	%>
</body>
</html>