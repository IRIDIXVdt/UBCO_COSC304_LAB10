<header>
	<h1 align="center" color="33CCFF"><font face="cursive" color="#3399FF">
		<a href="index.jsp" class ="a">Ollivender's Magical Wand Shop</a></font></h1>
<%
	// show current logged user
	String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
	if(username != null){
		out.print("<h4 align=\"center\">welcome!</h4>");
		out.print("<h5 align=\"center\">Signed in as: "+username+"</h5>");
	}
		
%>

<hr style="height:1px;border:none;border-top:1px solid rgb(51,204,255);" />	
</header>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%

	
    session = request.getSession(true);
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    
    userName = (String) session.getAttribute("authenticatedUser");

	try
	{
        getConnection();
          
        String sql = "update customer set firstName =?, lastName=?, email=?, phonenum=? where userid = ? ";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1,firstName);
        stmt.setString(2,lastName);
        stmt.setString(3,email);
        stmt.setString(4,phonenum);
        stmt.setString(5,userName);
        
        
        stmt.executeUpdate();
        out.println("<h2 align=\"center\">Succussful edit your personal information, back to<a href=\"customer.jsp\">Customer Info</a></h2>");
       
        
	}
	catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException e){}
    }
    
    %>
    
  