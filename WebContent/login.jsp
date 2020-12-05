<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<style type="text/css">
	.all{background-color: rgba(0,0,0,0.3);  
		border:1px solid #e7eaf1; 
		border-radius:2px; 
		box-shadow: 0 1px 3px rgba(0,37, 55, .05);
		box-sizing: border-box;
		width: 700px;
		margin-top:20px;
		margin-left:auto;
		margin-right:auto;}
	
	h1{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;
	}
	form{
		margin-left:22%;
	}
	.submit{
		margin-left: 30%;
		font-family: CenturyGothic; font-size: 20px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(2, 2, 2);
		text-shadow: 0 0 5px #da7a6a, 0 0 5px #dd7c7c;
		margin-top: 20px;
		margin-bottom: 20px;
		border-radius:5px
	}
	
	td{
		font-family: CenturyGothic; font-size: 20px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
		
	}
	a:hover{ color:rgb(250, 250, 250);font-family: Arial, Helvetica, sans-serif; font-size: 30px; text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 30px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	a { text-decoration: none;}
	</style>



<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">



<h3>Please Login to System</h3>
<div class="all">
<%@ include file="jdbc.jsp" %>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right">Username:</div></td>
	<td><input type="text" required="required" name="username"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right">Password:</div></td>
	<td><input type="password" required="required" name="password" size=30 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>




<h2 align="center"><a href="register.jsp">Register your account!!!</a></h2>

<h2 align="center"><a href="findpassword.jsp">Forgot your password?</a></h2>
</div>
</body>
</html>

