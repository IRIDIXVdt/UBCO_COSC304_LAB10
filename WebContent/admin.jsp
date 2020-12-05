<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>

</head>
<%@ include file="header.jsp" %>
<style>

	h3{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
	}
    h4{
        font-family: CenturyGothic; font-size: 30px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 10px;
        margin-bottom: 10px;
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
		border:2px solid rgb(211, 209, 209); 
		border-radius:2px; 
		border-collapse:collapse;
        margin-bottom:20px;
		
	}

	th{
		font-family: CenturyGothic; font-size: 20px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		
	}

	td{
		font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-style: normal; 
		
		color:rgba(255, 255, 255, 0.829);
		text-shadow: 0 0 8px #68646494, 0 0 8px #9b90908f;
	}
	a:hover{ color:rgb(250, 250, 250);font-family: Arial, Helvetica, sans-serif; font-size: 30px; text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a { text-decoration: none;}
</style>


<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
<h2 align="center"><a href="warehouse.jsp">Warehouse Inventory</a></h2>
    

<div>
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
    out.println("</table></div>");
    
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

