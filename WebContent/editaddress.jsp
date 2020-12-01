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


<h1>Edit Address</h1>
<%@ include file="jdbc.jsp" %>
<%
String userName = (String) session.getAttribute("authenticatedUser");
out.println("Signed in as: "+userName);
%>



<br>
<form name="MyForm" method=post action="editaddress2.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your new address:</font></div></td>
        <td><input required="required" type="text" name="address"  size=30 maxlength=50></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your new city:</font></div></td>
        <td><input required="required" type="text" name="city" size=30 maxlength="10"></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your new state:</font></div></td>
        <td><input required="required" type="text" name="state"  size=30 maxlength=50></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your new country:</font></div></td>
        <td><input required="required" type="text" name="country"  size=30 maxlength=50></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Your new postalCode:</font></div></td>
        <td><input required="required" type="text" name="postalCode"  size=30 maxlength=50></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="submit">
    </form>



</div>




</body>
</html>

