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
    String email = request.getParameter("email");
    
    


	try
	{
        getConnection();
          
        String sql = "select password from customer where email = ? ";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1,email);   
        ResultSet rst = stmt.executeQuery();
        
           
        if(rst.next()){
            out.println("<h2 align=\"center\">Your password is: "+ rst.getString(1)+"<a href=\"customer.jsp\"> Login</a></h2>");
        }
        else{
            out.println("<h2 align=\"center\">Email does not match, <a href=\"findpassword.jsp\">Go back</a></h2>");
        }
        
	}
	catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException e){}
    }
    
    %>
    
  