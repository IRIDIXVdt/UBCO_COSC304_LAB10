<!DOCTYPE html>
<html>
<head>
    <title>Ollivander's Magical Wand Shop Checkout</title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
  <style>
		tr,td{
			font-family: CenturyGothic; font-size: 20px; font-style: normal; 
			font-variant: small-caps; font-weight: 400; 
			color:rgb(255, 255, 255);
			text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
			
		}
</style>
<form method="get" action="order.jsp">
          <table align="center">
            <h1 align="center"><font face="cursive" color="#ffffff"> Please Enter your Customer ID and Password to confirm</h1>                    
                
                <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
                <tr><td>Password:</td><td><input type="password" name="customerpassword" size="20"></td></tr>
                <tr><td><input type="submit" value="Submit">&nbsp;</td><td><input type="reset" value="Reset"></td></tr>
            
        
            </table>
            
        </form>
      </div>
    </div>
  


</form>





</body>
</html>



