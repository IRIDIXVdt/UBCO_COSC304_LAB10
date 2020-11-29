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
	try {	
		getConnection();
		con.setAutoCommit(false);
		String orderId = request.getParameter("orderId"); // TODO: Get order id
		String sql ="SELECT productId, quantity FROM orderproduct WHERE orderId = " + orderId;
		PreparedStatement pstmt = con.prepareStatement(sql);
		Statement stmt = con.createStatement();
		ResultSet rst = pstmt.executeQuery();
		PreparedStatement psGetQuantity = con.prepareStatement("SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?");
			// TODO: For each item verify sufficient quantity available in warehouse 1.
			// SQL to get quantity: SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?
		PreparedStatement psUpdateInventory = con.prepareStatement("Update productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?");
		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		// SQL to update inventory: Update productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?
		int inventoryQuantity, requiredQuantity, newInventoryQuantity, currentProductId;
		inventoryQuantity=0;
		while(rst.next()){
//			currentProductId = rst.getInt(1);
//			requiredQuantity = rst.getInt(2);
//			psGetQuantity.setInt(1, currentProductId);
//			ResultSet GetQuantityrst = psGetQuantity.executeQuery();
//			if(GetQuantityrst.next()){		
//				inventoryQuantity = GetQuantityrst.getInt(1);
//				}
//			newInventoryQuantity = inventoryQuantity;
//			out.println("<h2>Ordered product: " + currentProductId + " Qty: " + requiredQuantity + " Previous inventory: " + inventoryQuantity + " New inventory: " + newInventoryQuantity+"</h2>");
//			if(newInventoryQuantity <= 0 ){//if we do not have sufficient inventory, then end the transaction
//				out.println("<h2>Shipment not done. Insuffcient inventory for product id: " + currentProductId+"</h2>");
//				throw new SQLException();								
//			}else{
//				newInventoryQuantity = inventoryQuantity - requiredQuantity;
//				psUpdateInventory.setInt(1, newInventoryQuantity);
//				psUpdateInventory.setInt(2, currentProductId);
//				psUpdateInventory.executeUpdate();//update the inventory
//			}		
	
			currentProductId = rst.getInt(1);
			requiredQuantity = rst.getInt(2);
			psGetQuantity.setInt(1, currentProductId);
			ResultSet rstGetQuantity = psGetQuantity.executeQuery();//Retrieve quantity
			//out.println("<h2>now we want to get inventory quantity</h2>");
			if(rstGetQuantity.next())
				inventoryQuantity = rstGetQuantity.getInt(1);
			
			newInventoryQuantity = inventoryQuantity - requiredQuantity;
			//out.println("<h2>now we want to get new inventory quantity</h2>");
			if(newInventoryQuantity < 0 ){//if we do not have sufficient inventory, then end the transaction
				out.println("<h2>Shipment not done. Insuffcient inventory for product id: " + currentProductId+"</h2>");
				throw new SQLException();
			}
			psUpdateInventory.setInt(1, newInventoryQuantity);
			psUpdateInventory.setInt(2, currentProductId);
			
			//out.println("<h2>now we want to update Inventory</h2>");
			psUpdateInventory.executeUpdate();//update the inventory
			out.println("<h2>Ordered product: " + currentProductId + " Qty: " + requiredQuantity + " Previous inventory: " + inventoryQuantity + " New inventory: " + newInventoryQuantity+"</h2>");
		}
		// TODO: Create a new shipment record.
		// Insert values:  shipmentDate shipmentDesc warehouseId
		// SQL to insert record: INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (,?,1)

		stmt.executeUpdate("INSERT INTO shipment(shipmentDate, warehouseId) VALUES (current_timestamp, 1)");
		con.commit();
	}catch(SQLException ex){
		System.err.println("SQLException: " + ex); 
		//out.println("SQLException: ");
		//out.println(ex);
		con.rollback();
	}finally{
		con.setAutoCommit(true);// TODO: Auto-commit should be turned back on
		closeConnection();
	}
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
