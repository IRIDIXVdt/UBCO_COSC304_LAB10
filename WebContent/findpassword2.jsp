<!DOCTYPE html>
<html>
<head>
<title>Find Password</title>
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
    
</body>
</html>