<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
        <title>Ollivender's Magical Wand Shop</title>
</head>
<head>
	<title>Ollivender's Magical Wand Shop</title>
	<header>
		<h1 align="center" color="33CCFF"><font face="cursive" color="#3399FF">
            <a href="index.jsp" class ="a">Ollivender's Magical Wand Shop</a></font></h1>
            <hr style="height:1px;border:none;border-top:1px solid rgb(51,204,255);" />	
        </header>
            <body>
            <h1 align="center"  color="33CCFF"><font face="cursive" color="#3399FF"> Thank you for your shopping! Have a nice day!</font></h1>
            <h2 align="center"><a href="index.jsp">Return to the main page</a></h2>
            <% 
		
		
        String custId = (String)session.getAttribute("custId");
        String custPass = (String)session.getAttribute("custPass");

		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList2 = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

		
		try {
            
            getConnection();
			Statement stmt = con.createStatement();
					
			if( productList2.size() != 0){//Then the inputs are valid, we will start saving order information to database
				//String DMLInsertOrder = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, NOW(), ?)";

				String OutputCustomerId = custId;
				int OutputOrderId = -1;
				String OutputCustomerName = "TestName";
				ResultSet rst = stmt.executeQuery("SELECT * FROM customer WHERE customerId = " + custId);
				rst.next();
				OutputCustomerName = rst.getString(2) + " " + rst.getString(3);

				
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
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList2.entrySet().iterator();
				double total =0;
				while (iterator.hasNext()) {	//borrowed from showcart.jsp
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					if (product.size() < 4){//>
						out.println("Expected product with four entries. Got: "+product);
						continue;
					}
					
					Object price = product.get(2);
					Object itemqty = product.get(3);
					double pr = 0;
					int qty = 0;
					try{pr = Double.parseDouble(price.toString());}catch (Exception e){out.println("Invalid price for product: "+product.get(0)+" price: "+price);}
					try{qty = Integer.parseInt(itemqty.toString());}catch (Exception e){out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);}		
					

					total = total +pr*qty;
					String orderProductsql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
					PreparedStatement orderStatement = con.prepareStatement(orderProductsql);
					orderStatement.setInt(1, OutputOrderId);
					orderStatement.setInt(2, Integer.parseInt(product.get(0).toString()));
					orderStatement.setDouble(3, qty);
					orderStatement.setDouble(4, pr);
					orderStatement.executeUpdate();
				}
			
				String totalAmountUpdatesql = "UPDATE OrderSummary SET totalAmount = ? WHERE OrderId = ?";
				PreparedStatement totalAmountUpdate = con.prepareStatement(totalAmountUpdatesql);
				totalAmountUpdate.setDouble(1, total);
				totalAmountUpdate.setInt(2, OutputOrderId);//totalAmount not yet set
                totalAmountUpdate.executeUpdate();
                
                out.println("<h1>Order completed.");
                out.println("<br>Your order reference number is: " + OutputOrderId);
                out.println("<br>Shipping to customer: "+ OutputCustomerId +" Name: "+ OutputCustomerName);

				out.println("<br><a href=listprod.jsp> Return to Shopping </a></h1></tr>");
				// Clear cart if order placed successfully	
				session.setAttribute("productList", new HashMap<String, ArrayList<Object>>() );
            } 
        }
        catch (SQLException ex) {// throws exception here
			out.println(ex);
		}finally{
			try{closeConnection();}catch(SQLException e){}
		}
	%>
</body>
</head>
</html>>

