<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
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
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");// get user name from authenticatedUser
%>

<%

// TODO: Print Customer information


out.println("<h3 align=\"center\" >Customer Profile</h3>");


try {	// Make the connection	
	getConnection();
	//get customerId
	int custId = -1;
    String sql = "select customerId from customer where userid='"+userName+"'";   
    PreparedStatement pstmt = con.prepareStatement(sql);	
	ResultSet rst = pstmt.executeQuery();
	while(rst.next()){
		custId = rst.getInt(1);
	}

	
	//Print Customer information
	ArrayList<String> data = new ArrayList<String>(); //user's data
	ArrayList<String> title = new ArrayList<String>(); //data name
	title.add("Id");
	title.add("First Name");
	title.add("Last Name");
	title.add("Email");
	title.add("Phone");
	title.add("Address");
	title.add("City");
	title.add("State");
	title.add("Postal Code");
	title.add("Country");
	title.add("User id");
	title.add("Admin");


	String sql2 = "select customerId, firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid,admin "
    +" from customer where customerId = ? ";   
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1,custId);	
	ResultSet rst2 = pstmt2.executeQuery();
	
	int j =1;
	if(rst2.next()){ // add all data into datalist
		while(j<=12){
			data.add(rst2.getString(j));
			j++;	
		}
	}
	
	//Print Customer information
	out.println("<table class=\"table\" border=\"1\" align=\"center\">"); 
	if(data.size()>0)
		for (int i = 0; i < title.size(); i++) {
				out.println("<tr><th>"+title.get(i)+"</th><td>"+data.get(i)+"</td></tr>");
		}
	out.println("</table>"); 
		
	
    
    


    
} catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}finally{
	closeConnection();
}
%>


<h2 align="center"><a href="editaddress.jsp">Edit Your address click here</a></h2>
<h2 align="center"><a href="editpassword.jsp">Edit Your password click here</a></h2>
<h2 align="center"><a href="editinfo.jsp">Edit Your personal information click here</a></h2>
</body>
</html>

