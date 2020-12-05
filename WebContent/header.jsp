<%@ page import="java.util.*" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<style>
    .p{ font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	font-variant: small-caps; font-weight: 400;  
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000; 
	margin-top:-50px;}

    /* .title:hover{ font-family: CenturyGothic; font-size: 80px; font-style: normal; 
	font-variant: small-caps; font-weight: 400; 
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000; }
	
    .title:link{font-family: CenturyGothic; font-size: 80px; font-style: normal; 
	font-variant: small-caps; font-weight: 400;  
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;}
	
    .title:visited{font-family: CenturyGothic; font-size: 80px; font-style: normal; 
	font-variant: small-caps; font-weight: 400; 
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;}
	.title { text-decoration: none;} */
	
	
</style>

<header>
    <h1 align="center">
        <a href="index.jsp" class ="title"><img src="img/title.png" width="1700"></a></h1>
<%
    // show current logged user
    String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
    if(username != null){
        out.println("<p align=\"center\" class=\"p\">welcome!"+"<br>");
			out.println("Signed in as: "+username+"</p>");
    }
        
%>

<hr style="height:1px;border:none;border-top:5px solid rgb(0, 0, 0);" />	
</header>


