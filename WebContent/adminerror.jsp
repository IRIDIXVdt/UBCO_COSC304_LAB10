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

<h2 align="center"><a href="index.jsp">Your are not administrator</a></h2>
</body>
</html>

