<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<style type="text/css">
	.d{background-color: rgba(0,0,0,0.3);  
		border:1px solid #e7eaf1; 
		border-radius:2px; 
		box-shadow: 0 1px 3px rgba(0,37, 55, .05);
		box-sizing: border-box;
		width: 700px;
		margin-top:20px;
		margin-left:auto;
		margin-right:auto;}
	
	h1,h2{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;
	}
	form{
		margin-left:16%;
	}
	.submit{
		margin-left: 32%;
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
 



<h1>Create account</h1>
<div class="d">



<br>
<form name="MyForm" method=post action="validateRegister.jsp">
<table style="display:inline" class="t">
<tr>
    <td><div align="right">Username:</td>
    <td>Maxlengthe with 10, and must contian 1 letter</td>
</tr>
<tr>
    
	<td></div></td>
	<td><input type="text" name="newusername"  size=40 maxlength=10></td>
</tr>
<tr>
    <td><div align="right">Password:</div></td>
    <td>Maxlengthe with 10, and must contian 1 letter</td>
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

<h2>Already have an account? <a href="login.jsp" align="center">Sign in</a><h2>
</div>




</body>
</html>

