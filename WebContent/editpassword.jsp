<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">s
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



<h1>Edit Your Password</h1>
<div class="d">


<br>
<form name="MyForm" method=post action="editpassword2.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right">Your old password:</font></div></td>
        <td><input required="required" type="text" name="oldpassword" size=30 maxlength="10"></td>
    </tr>
    <tr>
        <td><div align="right">Your new password:</font></div></td>
        <td><input required="required" type="text" name="editpassword" size=30 maxlength="10"></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="submit">
    </form>



</div>




</body>
</html>

