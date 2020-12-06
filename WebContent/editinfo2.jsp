<!DOCTYPE html>
<html>
<head>
<title>Edit Password</title>
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
</style>

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
    
    

	try
	{
        getConnection();
          
        String sql = "update customer set firstName =?, lastName=?, email=?, phonenum=? where userid = ? ";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1,firstName);
        stmt.setString(2,lastName);
        stmt.setString(3,email);
        stmt.setString(4,phonenum);
        stmt.setString(5,username);
        
        
        stmt.executeUpdate();
        out.println("<h2 align=\"center\">Succussful edit your personal information, back to<a href=\"customer.jsp\">Customer Info</a></h2>");
       
        
	}
	catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException e){}
    }
    
    %>

</body>
</html>
  