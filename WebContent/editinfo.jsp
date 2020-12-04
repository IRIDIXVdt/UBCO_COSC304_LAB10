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


<h1>Edit Information</h1>
<%@ include file="jdbc.jsp" %>
<%
String userName = (String) session.getAttribute("authenticatedUser");
out.println("Signed in as: "+userName);
%>



<br>
<form name="MyForm" method=post action="editinfo2.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your firstName:</font></div></td>
        <td><input required="required" type="text" name="firstName"  size=30 maxlength=30 pattern="[a-zA-Z]{1,20}" title="Only letter">
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your lastName:</font></div></td>
        <td><input required="required" type="text" name="lastName" size=30 maxlength="10"></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your email:</font></div></td>
        <td><input required="required" type="email" name="email"  size=30 maxlength=30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your phone number:</font></div></td>
        <td><input required="required" type="text" name="phonenum" size=30 pattern="[0-9]{10}" title="must be 10 digits"></td>
    </tr>
    
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="submit" >
    
    </form>



</div>




</body>
</html>

