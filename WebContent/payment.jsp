<!DOCTYPE html>
<html>
<head>
<title>Payment page</title>
</head>
<header>
	<h1 align="center" color="33CCFF"><font face="cursive" color="#3399FF">
		<a href="index.jsp" class ="a">Ollivender's Magical Wand Shop</a></font></h1>
<%
	// show current logged user
	String username = (String)session.getAttribute("authenticatedUser"); // get username from authenticatedUser(validateLogin)
	if(username != null){
		out.print("<h4 align=\"center\">welcome!</h4>");
		out.print("<h5 align=\"center\">Please enter your credit card information Or use Paypal to pay for your wand</h5>");
	}
		
%>

<hr style="height:1px;border:none;border-top:1px solid rgb(51,204,255);" />	
</header>
<body>
    <style type="text/css">
        .d{margin:0 auto;text-align:center;
            height: 600px;
            width: 500px;
            border: 3px solid rgb(51,204,255);
            border-radius:30px};
        
        
        </style>
<div class="d">


<h1>Credit Card</h1>
<%@ include file="jdbc.jsp" %>
<%
String userName = (String) session.getAttribute("authenticatedUser");
out.println("Signed in as: "+userName);
%>



<br>
<form method="get" action="thankyou.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Name on Card:</font></div></td>
        <td><input required="required" onkeyup="value=value.replace(/[^a-zA-Z]/g,'')" type="text" name="cardname"  size=30 maxlength=50></td>
  
    </tr>
    <br>
    <tr>
        <div  id = "bank" >
            Credit card number:
        <input  size = "4"  tabindex = "1"  maxlength = "4" minlength="4" oninput="value=value.replace(/[^\d]/g,'')" />
        <input  size = "4"  tabindex = "2"  maxlength = "4" minlength="4" oninput="value=value.replace(/[^\d]/g,'')" />
        <input  size = "4"  tabindex = "3"  maxlength = "4" minlength="4" oninput="value=value.replace(/[^\d]/g,'')" />
        <input  size = "4"  tabindex = "4"  maxlength = "4" minlength="4" oninput="value=value.replace(/[^\d]/g,'')" />
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Exp Date:</font></div></td>
        <td><input required="required" type="month" name="expdate"></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">CVV:</font></div></td>
        <td><input required="required" type="integer" name="cvv" oninput="value=value.replace(/[^\d]/g,'')" size=30 maxlength=3></td>
    </tr>
    
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="submit">
    </form>
    <table style="display:inline">
    <h1>Paypal</h1>
         <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
          <input type="hidden" name="cmd" value="_xclick">
          <input type="hidden" name="business" value="liying415@yahoo.com">
          <input type="hidden" name="lc" value="US">
          <input type="hidden" name="item_name" value="MAGIC WAND">
          <input type="hidden" name="button_subtype" value="services">
          <input type="hidden" name="no_note" value="0">
          <input type="hidden" name="currency_code" value="USD">
          <input type="hidden" name="tax_rate" value="15.000">
          <input type="hidden" name="shipping" value="1.00">
          <input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynowCC_LG.gif:NonHostedGuest">
          <table align="center">
          <tr><td><input type="hidden" name="on0" value="Choose your shipment">Choose your shipment</td></tr><tr><td><select name="os0">
            <option value="Pick up">Pick up $1.00 USD</option>
            <option value="Shipped to Wizard">Shipped to Wizard $1.00 USD</option>
            <option value="Shipped to muggle">Shipped to muggle $1,000.00 USD</option>
          </select> </td></tr>
          </table>
          <input type="hidden" name="option_select0" value="Pick up">
          <input type="hidden" name="option_amount0" value="1.00">
          <input type="hidden" name="option_select1" value="Shipped to Wizard">
          <input type="hidden" name="option_amount1" value="1.00">
          <input type="hidden" name="option_select2" value="Shipped to muggle">
          <input type="hidden" name="option_amount2" value="1000.00">
          <input type="hidden" name="option_index" value="0">
          <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
          <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
          </form>
     </table>



</div>




</body>
</html>

