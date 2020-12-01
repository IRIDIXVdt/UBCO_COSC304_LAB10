<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
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
    <style type="text/css">
        .d{margin:0 auto;text-align:center;
            height: 400px;
            width: 500px;
            border: 3px solid rgb(51,204,255);
            border-radius:30px};
        
        
        </style>
<div class="d">


<h1>Find your password</h1>
<%@ include file="jdbc.jsp" %>



<br>
<form name="MyForm" method=post action="findpassword2.jsp">
<table style="display:inline" class="t">
<tr>
    <td><align="right"><font face="Arial, Helvetica, sans-serif" size="4">Enter you email</font></td>
    
</tr>
<tr>
    <td><input type="text" name="email" size=30 maxlength="30"></td>
	
</tr>

</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Submit">
</form>

<%
if (session.getAttribute("registerMessage") != null)
	out.println("<p>"+session.getAttribute("registerMessage").toString()+"</p>");
%>


</div>




</body>
</html>

