<!DOCTYPE html>
<html>
<head>
        <title>Ollivender's Magical Wand Shop</title>
</head>
<head>
	<title>Ollivender's Magical Wand Shop</title>
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
	
	<hr style="height:1px;border:none;border-top:3px solid rgb(22, 21, 21);" />	
	</header>

<body  background="img/bk2.jpg"
style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
<style type="text/css">
	
	a:hover{ color:rgb(167, 209, 16) }
	a:link{color:rgb(51,204,255);}
	a:visited{color:rgb(51,204,255);}
	a { text-decoration: none;}
	
	.div{background-color: rgba(0,0,0,0.3);  
	border:1px solid #e7eaf1; 
	border-radius:2px; 
	box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	box-sizing: border-box;
	width: 500px;
	margin-top:20px;
    margin-left:auto;
    margin-right:auto;
	}

	
	</style>
<div class="div" width=200px; height=1000px;>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<div>
</body>
</head>


