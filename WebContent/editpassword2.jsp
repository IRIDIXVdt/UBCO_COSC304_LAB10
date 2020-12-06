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
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	
    session = request.getSession(true);
    String editpassword = request.getParameter("editpassword");
    String oldpassword = request.getParameter("oldpassword");
    boolean validPassword = false;
    boolean emptyPassword = true;
    boolean matchPassword = false;
    username = (String) session.getAttribute("authenticatedUser");
    
	try
	{
        getConnection();
          
        String sql = "update customer set password=? where userid = ? ";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1,editpassword);
        stmt.setString(2,username);
        String sql2 = "select password from customer where userid =? ";
        PreparedStatement stmt2 = con.prepareStatement(sql2);
        stmt2.setString(1,username);
        ResultSet rst = stmt2.executeQuery();
        if(editpassword!=null && oldpassword != null){
            emptyPassword = false;
            if(rst.next()){
                if(rst.getString(1).equals(oldpassword)){
                    matchPassword=true;
                }
            }
            for(int i=0; i < editpassword.length(); i++) {
				if(Character.isLetter(editpassword.charAt(i))){
                    validPassword = true;
                    break;
				    }				 
			}	
        }
            
        if(emptyPassword){
            out.println("<h2 align=\"center\">Sorry, unsuccussful update - no new password or old password entered, back to <a href=\"customer.jsp\">Customer Info</a></h2>");
        }
        else if(matchPassword &&validPassword){
            stmt.executeUpdate();
            out.println("<h2 align=\"center\">Succussful edit your password, back to<a href=\"customer.jsp\">Customer Info</a></h2>");
        }
        else if(!matchPassword){
            out.println("<h2 align=\"center\">Sorry, unsuccussful update - password does not match the old password, back to <a href=\"customer.jsp\">Customer Info</a></h2>");
        }
        else if(!validPassword){
            out.println("<h2 align=\"center\">Sorry, unsuccussful update - password must contian 1 letter, back to <a href=\"customer.jsp\">Customer Info</a></h2>");
        }
        else{
            out.println("");
        }
   
	}
	catch (SQLException ex) {// throws exception here
        out.println(ex);
    }finally{
        try{closeConnection();}catch(SQLException e){}
    }
    
    %>

</html>