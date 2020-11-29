<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
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


out.println("<h3>Customer Profile</h3>"+"Signed in as: "+userName);


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


	String sql2 = "select customerId, firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid "
    +" from customer where customerId = ? ";   
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1,custId);	
	ResultSet rst2 = pstmt2.executeQuery();
	
	int j =1;
	if(rst2.next()){ // add all data into datalist
		while(j<=11){
			data.add(rst2.getString(j));
			j++;	
		}
	}
	
	//Print Customer information
	out.println("<table class=\"table\" border=\"1\">"); 
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

</body>
</html>

