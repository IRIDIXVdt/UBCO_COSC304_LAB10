<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;"></body>
    <style>
        h2{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;
	}
    a:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 35px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fffdfd;}
	a:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 35px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fcf9f9;}
    </style>
<header>

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
    
</body>
</html>