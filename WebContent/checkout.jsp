<!DOCTYPE html>
<html>
<head>
<title>Magic Wand Shop CheckOut Line</title>
</head>
<body>
<form method="get" action="order.jsp">

    <div class="col-100">
      <div class="container">
        <form action="order.jsp">
        <table>
            <div class="col-50">
              <h1>Step1: Please enter your credit card information Or use Paypal to pay for your wand</h1>
              <h3>Credit Card</h3>
              <tr><td><label for="cname">Name on Card</label></td></tr>
              <tr><td><input type="text" id="cname" name="cardname" placeholder="Harry Potter"></td></tr>
              <tr><td><label for="ccnum">Credit card number</label></td></tr>
              <tr><td><input type="text" id="ccnum" name="cardnumber" placeholder="xxxx-xxxx-xxxx-xxxx"></td></tr>
              <tr><td><label for="expmonth">Exp Date</label></td></tr>
              <tr><td><input type="text" id="expdate" name="expdate" placeholder="01/19"></td></tr>
              <tr><td><label for="cvv">CVV</label></td></tr>
              <tr><td><input type="text" id="cvv" name="cvv" placeholder="111"></td></tr>
              
            </div>
        </table>
  
          </div>
             

          <h2>Paypal</h2>
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
          <table>
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

          <h1>Step2: Please Enter your customer id and password to complete the transaction:</h1>
          
          <table text-align="center">
            <h3>Please Enter your Customer ID and Password to login</h3>
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



