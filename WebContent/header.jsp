<%@ page import="java.util.*" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<style>
    .p{ font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	font-variant: small-caps; font-weight: 400;  
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000; 
	margin-top:-80px;}

    .cart:hover{ color:rgb(250, 250, 250);font-family: Arial, Helvetica, sans-serif; font-size: 35px; text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.cart:link{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 35px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.cart:visited{color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 35px;text-shadow: 0 0 5px #ffee00, 0 0 5px #fc0000;}
	.cart { text-decoration: none;}
	
	.hr{
		margin-top:-30px;
	}
	.h1{
		margin-top:-20px;
	}
</style>

<header>
    <h1 align="center" class="h1">
		<a href="index.jsp" ><img src="img/title.png" width=100%></a></h1>
		
		
<%
    // show current logged user
    String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
    if(username != null){
        out.println("<br><p align=\"center\" class=\"p\">welcome!"+"<br>");
		out.println("Signed in as: "+username);
		out.println("<br><a href=\"showcart.jsp\" class=\"cart\">My Cart</a></p>");
    }
        
%>
<h2 align = center>
	<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=430 height=52 src="//music.163.com/outchain/player?type=2&id=3993358&auto=1&height=32"></iframe>	
</h2>
<div>
	
	<hr class="hr" style="height:1px;border:none;border-top:5px solid rgb(0, 0, 0);" />	
</div>

</header>


