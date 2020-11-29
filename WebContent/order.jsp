<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
	<title>Ollivender's Magical Wand Shop Order Processing</title>
</head>
<body>
	<% 
		//NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String custId = request.getParameter("customerId");// Get customer id
		String custPass = request.getParameter("customerpassword");//Get customer password
		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) {		
			ResultSet rst = stmt.executeQuery("SELECT customerId, password FROM customer");
			boolean idValid = false;
			boolean passValid = false;
			while(rst.next()){// Determine if valid customer id and password was entered
				if(rst.getString(1).equals(custId))
					idValid = true;	
				if(rst.getString(2).equals(custPass))
					passValid= true;
			}		
			if( productList.size() != 0 && idValid && passValid){//Then the inputs are valid, we will start saving order information to database
				//String DMLInsertOrder = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, NOW(), ?)";

				String OutputCustomerId = custId;
				int OutputOrderId = -1;
				String OutputCustomerName = "TestName";
				rst = stmt.executeQuery("SELECT * FROM customer WHERE customerId = " + custId);
				rst.next();
				OutputCustomerName = rst.getString(2) + " " + rst.getString(3);

				out.println("<tr><h1>Your Order Summary</h1>");// Print out order summary
				//out.println("Product Id Product Name Quantity Price Subtotal");
				out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
				out.println("<th>Price</th><th>Subtotal</th></tr>");

				//print the first line 
				String orderSummarySQL = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, current_timestamp, ?)";
				PreparedStatement summaryStatement = con.prepareStatement(orderSummarySQL);
				summaryStatement.setString(1,OutputCustomerId);
				summaryStatement.setInt(2,-1);//totalAmount not yet set
				summaryStatement.executeUpdate();

				//get orderId
				rst = stmt.executeQuery("SELECT orderId FROM OrderSummary ORDER BY orderId DESC");
				rst.next();
				OutputOrderId = rst.getInt(1);

				//now print each item and insert into the database
				String DMLInsertProduct = "";
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				double total =0;
				while (iterator.hasNext()) {	//borrowed from showcart.jsp
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					if (product.size() < 4){//>
						out.println("Expected product with four entries. Got: "+product);
						continue;
					}
					out.print("<tr><td>"+product.get(0)+"</td>");
					out.print("<td>"+product.get(1)+"</td>");
					out.print("<td align=\"center\">"+product.get(3)+"</td>");
					Object price = product.get(2);
					Object itemqty = product.get(3);
					double pr = 0;
					int qty = 0;
					try{pr = Double.parseDouble(price.toString());}catch (Exception e){out.println("Invalid price for product: "+product.get(0)+" price: "+price);}
					try{qty = Integer.parseInt(itemqty.toString());}catch (Exception e){out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);}		
					out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
					out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
					out.println("</tr>");

					total = total +pr*qty;
					String orderProductsql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
					PreparedStatement orderStatement = con.prepareStatement(orderProductsql);
					orderStatement.setInt(1, OutputOrderId);
					orderStatement.setInt(2, Integer.parseInt(product.get(0).toString()));
					orderStatement.setDouble(3, qty);
					orderStatement.setDouble(4, pr);
					orderStatement.executeUpdate();
				}
				out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
						+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
				out.println("</table>");

				out.println("<h1 style = \"line-height:2\">Order completed. Will be shipped soon...");
				out.println("<br>Your order reference number is: " + OutputOrderId);
				out.println("<br>Shipping to customer: "+ OutputCustomerId +" Name: "+ OutputCustomerName + "</h1>");

				String totalAmountUpdatesql = "UPDATE OrderSummary SET totalAmount = ? WHERE OrderId = ?";
				PreparedStatement totalAmountUpdate = con.prepareStatement(totalAmountUpdatesql);
				totalAmountUpdate.setDouble(1, total);
				totalAmountUpdate.setInt(2, OutputOrderId);//totalAmount not yet set
				totalAmountUpdate.executeUpdate();

				//out.println("<br><a href=listprod.jsp> Return to Shopping </a></h1></tr>");
				// Clear cart if order placed successfully	
				session.setAttribute("productList", new HashMap<String, ArrayList<Object>>() );
			} 
			else if(productList.size() == 0){
			
				out.print("<h1>Your shopping cart is empty!</h1>");
			}
			else if(!idValid){
			
				out.print("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
			}
			else {
			
				out.print("<h1>The password you entered was not correct. Please go back and try again.</h1>");
			}
		} catch (SQLException ex) { 	
			out.println(ex); 
		}
	%>
	<h2><a href="shop.html">Return to Shopping</a></h2>
</body>
</html>
