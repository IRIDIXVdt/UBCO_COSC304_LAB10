

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ include file="auth.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html>
<head>
<title><h1>Your Shopping Cart</h1>></title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;"></body>
    <style>
        h2,h1{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;
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
    tr,td{
			font-family: CenturyGothic; font-size: 20px; font-style: normal; 
			font-variant: small-caps; font-weight: 400; 
			color:rgb(255, 255, 255);
			text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
			
		}
    
    </style>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th> </th><th>Quantity</th><th> </th>");
	out.println("<th>Price</th><th>Subtotal</th><th> </th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td align=\"center\">"+product.get(0)+"</td>");
		out.print("<td align=\"center\">"+product.get(1)+"</td>");

		out.print("<td><a href=deleteitem.jsp?id="+product.get(0)+"&name="+product.get(1)+"&price="+product.get(3)+">-</a></td>");
		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		out.print("<td><a href=addcart.jsp?id="+product.get(0)+"&name="+product.get(1)+"&price="+product.get(3)+">+</a></td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.print("<td><a href=removeitem.jsp?id="+product.get(0)+"&name="+product.get(1)+"&price="+product.get(3)+">remove</a></td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"6\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

