<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>Ollivender's Magical Wand Shop WareHouse</title>
</head>
<body>
    <script text="javaScript">
        function welcome(){
        alert("Update Successfull!");
        }
    </script>
	<% 
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		
		//String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		//String uid = "SA";
        //String pw = "YourStrong@Passw0rd";
        
        try 
            //( Connection con = DriverManager.getConnection(url, uid, pw);) 
            {	
            getConnection();
            Statement stmt = con.createStatement();
            Statement stmtInven = con.createStatement();
            ResultSet rst = stmt.executeQuery("SELECT warehouseName, warehouseId FROM warehouse");//result set has inventory
            out.println("<tr><h1>Wand Shop Inventory Summary</h1>");// Print out order summary
            while(rst.next()){
                String RSTwarehouseName = rst.getString(1);
                int RSTwarehouseId = rst.getInt(2);

                out.println("<tr><h2>Summary of "+ RSTwarehouseName +"</h2>");// Print out order summary
                
                ResultSet rstInven = stmtInven.executeQuery("SELECT productInventory.productId, productName,"+
                 "quantity FROM productInventory JOIN product ON product.productId = productInventory.productId"+
                 " WHERE warehouseId = " + RSTwarehouseId);
				//ResultSet rstInven = stmtInven.executeQuery("SELECT productId, quantity FROM productInventory WHERE warehouseId = " + RSTwarehouseId);
                out.print("<table><tr><th>Product Id</th><th>Product Name</th><th size=10>Quantity</th><th>Individual Update</th></tr>");
                while(rstInven.next()){
                    out.println("<tr><th>"+rstInven.getInt(1)+"</th><th>"+rstInven.getString(2)+"</th>"
                        + "<form name=MyInventory method=post action=updateInventory.jsp>"
                        + "<th><input type=text name=pnq value="+rstInven.getInt(3)+" size=10 maxlength=10></th>"
                        + "<input type=hidden name=pid value = "+rstInven.getInt(1)+">"
                        + "<input type=hidden name=pwi value ="+RSTwarehouseId+">"
                        + "<th><input class=submit type=submit name=Submit3 value=\"Update Inventory\"></th>"
                        + "</form>"
                        //+rstInven.getInt(3)+
                        +"</tr>");
                }
                out.println("</table>");
            } 
		} catch (SQLException ex) { 	
			out.println(ex); 
		} finally {
            closeConnection();
        }
	%>
</body>
</html>
