
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	session = request.getSession(true);
	try{
		String test = postreview(out,request,session);
	}catch(IOException e){
		System.err.println(e); 
	}	
	String username = (String)session.getAttribute("authenticatedUser");
	if(username != null){
		int productId = Integer.parseInt(request.getParameter("id"));
		response.sendRedirect("product.jsp?id="+productId);
	}else{
		response.sendRedirect("login.jsp");
	}
%>

<%!
    String postreview(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException
	{
		String rate = request.getParameter("rate");
		String content = request.getParameter("content");
		String retStr = null;
		int customerId = 0;
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		double date = System.currentTimeMillis();
		String reviewDate = formatter.format(date);
		int productId = Integer.parseInt(request.getParameter("id"));

		String username = (String)session.getAttribute("authenticatedUser");
		try 
		{
			getConnection();
			String sql = "SELECT customerId FROM customer WHERE userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);		
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
				customerId = rst.getInt(1);
			}

			String newreview = "INSERT INTO review(customerId, reviewRating, reviewDate, productId, reviewComment) VALUES (?, ?, ?,?,?)";
			PreparedStatement pstmt2 = con.prepareStatement(newreview);	
			pstmt2.setInt(1, customerId);
			pstmt2.setString(2, rate);
			pstmt2.setString(3, reviewDate);
			pstmt2.setInt(4, productId);
			pstmt2.setString(5, content);	
			pstmt2.executeQuery();
		} 
		catch (SQLException ex) {
			out.println(ex);
		}finally{
			try{closeConnection();}catch(SQLException e){}
		}
		
		return retStr;
	}
%>