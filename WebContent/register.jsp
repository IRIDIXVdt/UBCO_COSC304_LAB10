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


<h1>Create account</h1>
<%@ include file="jdbc.jsp" %>



<br>
<form name="MyForm" method=post action="validateRegister.jsp">
<table style="display:inline" class="t">
<tr>
    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></td>
    <td><font face="Arial, Helvetica, sans-serif" size="2">Maxlengthe with 10, and must contian 1 letter</font></td>
</tr>
<tr>
    
	<td></div></td>
	<td><input type="text" name="newusername"  size=40 maxlength=10></td>
</tr>
<tr>
    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
    <td><font face="Arial, Helvetica, sans-serif" size="2">Maxlengthe with 10, and must contian 1 letter</font></td>
</tr>
<tr>
	<td></td>
	<td><input type="password" name="newpassword" size=40 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Sign Up">
</form>

<%
if (session.getAttribute("registerMessage") != null)
	out.println("<p>"+session.getAttribute("registerMessage").toString()+"</p>");
%>

<h2>Already have an account?<a href="login.jsp" align="center">Sign in</a><h2>
</div>




</body>
</html>

