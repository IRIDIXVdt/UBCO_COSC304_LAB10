<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	session = request.getSession(true);
	try{
		String testRst = updateInventoryProcess(out,request,session);
	}catch(IOException e){
		System.err.println(e); 
	}
	response.sendRedirect("warehouse.jsp");		
%>


<%!
	String updateInventoryProcess(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		
		String retStr = null;

		try {
			int productId = Integer.parseInt(request.getParameter("pid"));
			int productNewQuantity = Integer.parseInt(request.getParameter("pnq"));
			int productWarehouseId = Integer.parseInt(request.getParameter("pwi"));

			getConnection();
			String sql = "Update productInventory SET quantity = ? WHERE productId = ? AND warehouseId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNewQuantity);	
			pstmt.setInt(2, productId);
			pstmt.setInt(3, productWarehouseId);	
			pstmt.executeUpdate();
		} 
		catch (SQLException ex) {// throws exception here
			out.println(ex);
		}catch(Exception ex){
			out.println("other exception");
		}finally{
			try{
				closeConnection();
			}catch(SQLException e){}
		}	
		return retStr;
	}
%>

