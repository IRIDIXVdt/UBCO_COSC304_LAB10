<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	session = request.getSession(true);
	try{
		String test = postreview(out,request,session);
	}catch(IOException e){
		System.err.println(e); 
	}	
	response.sendRedirect("listprod.jsp");
%>

<%!
    String postreview(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException
	{
		String rate = request.getParameter("rate");
		String content = request.getParameter("content");
		String retStr = null;
		String customerId = "anonymous";
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		double date = System.currentTimeMillis();
		String reviewDate = formatter.format(date);

		String username = (String)session.getAttribute("authenticatedUser");
		try 
		{
			getConnection();
			String sql = "SELECT customerId FROM customer WHERE userid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);		
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
				customerId = rst.getString(1);
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}finally{
			try{closeConnection();}catch(SQLException e){}
		}
		
		@SuppressWarnings({"unchecked"})
		session.setAttribute("reviewList",null);
		HashMap<String, ArrayList<Object>> reviewList = (HashMap<String, ArrayList<Object>>) session.getAttribute("reviewList");
		
		if (reviewList == null)
		{	// No products currently in list.  Create a list.
			reviewList = new HashMap<String, ArrayList<Object>>();
		}

		ArrayList<Object> review = new ArrayList<Object>();
		review.add(rate);
		review.add(content);
		review.add(reviewDate);
		review.add(customerId);
			
		reviewList.put(customerId,review);
		session.setAttribute("reviewList",reviewList);
		return retStr;
	}
%>