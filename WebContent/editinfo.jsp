<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>

</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
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
        
        h1{
            font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		    font-variant: small-caps; font-weight: 400; 
		    color:rgb(255, 255, 255);
		    text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		    margin-top: 0px;
            text-align: center;
        }
        form{
            margin-left:20%;
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
        
        </style>



<h1>Edit Information</h1>

<div class="d">


<br>
<form name="MyForm" method=post action="editinfo2.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right">Your firstName:</font></div></td>
        <td><input required="required" type="text" name="firstName"  size=30 maxlength=30 pattern="[a-zA-Z]{1,20}" title="Only letter">
    </tr>
    <tr>
        <td><div align="right">Your lastName:</font></div></td>
        <td><input required="required" type="text" name="lastName" size=30 maxlength="10"></td>
    </tr>
    <tr>
        <td><div align="right">Your email:</font></div></td>
        <td><input required="required" type="email" name="email"  size=30 maxlength=30></td>
    </tr>
    <tr>
        <td><div align="right">Your phone number:</font></div></td>
        <td><input required="required" type="text" name="phonenum" size=30 pattern="[0-9]{10}" title="must be 10 digits"></td>
    </tr>
    
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="submit" >
    
    </form>



</div>




</body>
</html>

