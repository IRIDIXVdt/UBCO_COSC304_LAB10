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
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String country = request.getParameter("country");
    String postalCode = request.getParameter("postalCode");
    

    username = (String) session.getAttribute("authenticatedUser");

    


	try
	{
        getConnection();
          
        String sql = "update customer set address =?, city=?, state=?, postalCode=?,country=? where userid = ? ";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1,address);
        stmt.setString(2,city);
        stmt.setString(3,state);
        stmt.setString(4,postalCode);
        stmt.setString(5,country);
        stmt.setString(6,username);
        
        stmt.executeUpdate();
        out.println("<h2 align=\"center\">Succussful edit your address, back to<a href=\"customer.jsp\">Customer Info</a></h2>");
       
        
	}
	catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException e){}
    }
    
    %>
    
  