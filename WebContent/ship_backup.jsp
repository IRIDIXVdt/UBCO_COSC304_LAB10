<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	try{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}catch (java.lang.ClassNotFoundException e){
		out.println("ClassNotFoundException: " +e);
	}
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {		
		Statement stmt = con.createStatement();
		con.setAutoCommit(false);// TODO: Start a transaction (turn-off auto-commit)
		String orderId = request.getParameter("orderId"); // TODO: Get order id
		ResultSet rst = stmt.executeQuery("SELECT productId, quantity FROM orderproduct WHERE orderId = " + orderId);
		//if(!rst.Next())// TODO: Check if valid order id
		//	raise SQLException();


		PreparedStatement psRetrieveItems = con.prepareStatement("SELECT productId, quantity FROM orderproduct WHERE orderId = ?");
		// TODO: Retrieve all items in order with given id
		// SQL to get given items: SELECT productId, quantity FROM orderproduct WHERE orderId = ?

		PreparedStatement psGetQuantity = con.prepareStatement("SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?");
		// TODO: For each item verify sufficient quantity available in warehouse 1.
		// SQL to get quantity: SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?

		PreparedStatement psUpdateInventory = con.prepareStatement("Update productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?");
		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		// SQL to update inventory: Update productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?

		int inventoryQuantity, requiredQuantity, newInventoryQuantity, currentProductId;
		while(rst.next()){
			currentProductId = rst.getInt(1);
			psGetQuantity.setInt(1, currentProductId);
			ResultSet rstGetQuantity = psRetrieveItems.executeQuery();//Retrieve quantity
			rstGetQuantity.next();
			inventoryQuantity = rstGetQuantity.getInt(1);
			requiredQuantity = rst.getInt(2);
			newInventoryQuantity = inventoryQuantity - requiredQuantity;
			if(newInventoryQuantity < 0 ){//if we do not have sufficient inventory, then end the transaction
				out.println("Shipment not done. Insuffcient inventory for product id: " + currentProductId);
				throw new SQLException();
			}
			psUpdateInventory.setInt(1, newInventoryQuantity);
			psUpdateInventory.setInt(2, currentProductId);
			psUpdateInventory.executeQuery();//update the inventory
			out.println("Ordered product: " + currentProductId + " Qty: " + requiredQuantity + " Previous inventory: " + inventoryQuantity + " New inventory: " + newInventoryQuantity);
		}
		// TODO: Create a new shipment record.
		// Insert values:  shipmentDate shipmentDesc warehouseId
		// SQL to insert record: INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (,?,1)
		stmt.executeQuery("INSERT INTO shipment(shipmentDate, warehouseId) VALUES (current_timestamp, 1)");
		con.commit();
		con.setAutoCommit(true);
	}catch(SQLException ex){
		System.err.println("SQLException: " + ex); 
		con.rollback();
	}
	//finally{
	//	con.setAutoCommit(true);// TODO: Auto-commit should be turned back on
	//}
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
