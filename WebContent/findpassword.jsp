<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
    <style type="text/css">
        .d{margin:0 auto;text-align:center;
            height: 400px;
            width: 500px;
            border: 3px solid rgb(51,204,255);
            border-radius:30px}
        tr,td{
			font-family: CenturyGothic; font-size: 20px; font-style: normal; 
			font-variant: small-caps; font-weight: 400; 
			color:rgb(255, 255, 255);
			text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
			
		}
        h1{
        font-family: CenturyGothic; font-size: 40px; font-style: normal; 
        font-variant: small-caps; font-weight: 400; 
        color:rgb(255, 255, 255);
        text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
        margin-top: 0px;
        text-align: center;
}
        
        
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

