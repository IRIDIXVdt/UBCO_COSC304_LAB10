



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
	<%@ include file="header.jsp" %>
</head>
<body>
	<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;"></body>
	<style>
		h1,h2{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;

	}
		tr,td{
			font-family: CenturyGothic; font-size: 20px; font-style: normal; 
			font-variant: small-caps; font-weight: 400; 
			color:rgb(255, 255, 255);
			text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
			
		}
		table{
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:5px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
	    width: 400px;
	    margin-top:20px;
        margin-left:auto;
        margin-right:auto;
		vertical-align: middle;
    }

		
	</style>
	<% 
		//NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String custId = request.getParameter("customerId");// Get customer id
		String custPass = request.getParameter("customerpassword");//Get customer password
		
		session.setAttribute("custId",custId);
		session.setAttribute("custPass",custPass);
		
		
		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 
			{		
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
				

				//get orderId
				rst = stmt.executeQuery("SELECT orderId FROM OrderSummary ORDER BY orderId DESC");
				rst.next();
				OutputOrderId = rst.getInt(1);

				// get customer address
				ResultSet rst2 = stmt.executeQuery("SELECT address, city, state, postalCode, country FROM customer");
				rst2.next();
				
				//OutputCity = rst.getString(2);
				//OutputState = rst.getString(3);
				//OutputPostalCode = rst.getString(4);
				//OutputCountry = rst.getString(5);
				out.println("<h1><br>Your lovely wand will be shipped to the following address:" + rst2.getString(1)+ " "+ rst2.getString(2)+" "+rst2.getString(3)+ " " + rst2.getString(4) + " " + rst2.getString(5) + "</h1>");
				out.println("<h1>Please confirm this shipping address, to change the shipping address, click the link below: </h1>");
				out.println("<h2><a href=\"editaddress.jsp\">Click me to change your shipping address</a></h2>");

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
					
				}
				out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
						+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
				out.println("</table>");

				
				out.println("<h2><a href=\"payment.jsp\">Click me to finish your payment</a></h2>");
			

				

	
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
	
</body>
</html>
