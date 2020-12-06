<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<%@ include file="header.jsp" %>
<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;"></body>
    <style>
        h2,h1{
		font-family: CenturyGothic; font-size: 40px; font-style: normal; 
		font-variant: small-caps; font-weight: 400; 
		color:rgb(255, 255, 255);
		text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
		margin-top: 0px;
		text-align: center;
	}
    form{
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:5px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
	    width: 400px;
	    margin-top:20px;
        margin-left:auto;
        margin-right:auto;
    }
    tr,td{
			font-family: CenturyGothic; font-size: 20px; font-style: normal; 
			font-variant: small-caps; font-weight: 400; 
			color:rgb(255, 255, 255);
			text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;		    
			
		}
    
    </style>
<div class="d">

<h2>Please enter your credit card information Or use Paypal to pay for your wand</h2>>
<h1>Credit Card</h1>
<%@ include file="jdbc.jsp" %>

<br>
<form method="get" action="thankyou.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Credit card number:</font></div></td>
        <td><input required="required" size = "16"   maxlength = "16" minlength="16"  onkeyup="value=value.replace(/[^\d]/g,'')" /></td>
    </tr>
    <tr>
        <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Name on Card:</font></div></td>
        <td><input required="required" onkeyup="value=value.replace(/[^a-zA-Z]/g,'')" type="text" name="cardname"  size=30 maxlength=50></td>
  
    </tr>
    <tr>
        <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Exp Date:</font></div></td>
        <td><input required="required" type="month" name="expdate"></td>
    </tr>
    <tr>
        <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">CVV:</font></div></td>
        <td><input required="required" type="integer" name="cvv" oninput="value=value.replace(/[^\d]/g,'')" size=30 maxlength=3></td>
    </tr>
    
    </table>
    <br/>
    <div align="center">
    <td><input class="submit" type="submit" name="Submit2" value="submit"></td>
    </div >
    </form>
    <table style="display:inline" align="center">
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
          <td><input style="display:block;margin:0 auto" align="center" type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!"></td>
          <td><img style="display:block;margin:0 auto" align="center" alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1"></td>
          </form>
     </table>



</div>




</body>
</html>

