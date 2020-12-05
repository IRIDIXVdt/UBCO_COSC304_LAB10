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
    
    