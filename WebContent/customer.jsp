<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<%@ include file="header.jsp" %>
<style>

	h3{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
	}
	div{
		background-color: rgba(0,0,0,0.3);  
		border:1px solid #e7eaf1; 
		border-radius:2px; 
		box-shadow: 0 1px 3px rgba(0,37, 55, .05);
		box-sizing: border-box;
		width: 700px;
		margin-top:20px;
    	margin-left:auto;
    	margin-right:auto;
	}

	table{
		margin-top:20px;
		border:2px solid rgb(211, 209, 209); 
		border-radius:2px; 
		border-collapse:collapse;
		
	}

	th{
		font-family: CenturyGothic; font-size: 20px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		
	}

	td{
		font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-style: normal; 
		
		color:rgba(255, 255, 255, 0.829);
		text-shadow: 0 0 8px #68646494, 0 0 8px #9b90908f;
	}
	a:hover{ color:rgb(250, 250, 250);font-family: Arial, Helvetica, sans-serif; font-size: 30px; text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a { text-decoration: none;}
</style>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">


<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");// get user name from authenticatedUser
%>



// TODO: Print Customer information


<h3 align="center" >Customer Profile</h3>
<div>
<%
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

</div>
</body>
</html>

