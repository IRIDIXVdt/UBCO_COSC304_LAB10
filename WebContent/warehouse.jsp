<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ollivender's Magical Wand Shop WareHouse</title>
</head>

<style>
    #main{
        height: 550px;
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:2px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
	    width: 1000px;
	    margin-top:20px;
        margin-left:auto;
        margin-right:auto;
    }
    #leftdiv{
        width: 20%;
        margin-left: 20%;
        margin-top: 50px;
        float: left;
        height: 450px;
        
    }
    #rightdiv{
        width: 30%;
        margin-right: 12.5%;
        margin-top: 50px;
        float: right;
        height: 450px;
    }
    
    #input{
        margin-top: 30px;
        margin-bottom: 50px;
        margin-left: 40px;
        width: 50%;
        text-align: left;
        position: relative;
    }
    .desc{ text-align: left; width: 250px; color:rgb(219, 217, 217);font-family: Arial, Helvetica, sans-serif;}
    .desc:hover{
        font-family: CenturyGothic; font-size: 30px; font-style: normal; 
	    font-variant: small-caps; font-weight: 400;  
	    color:rgb(255, 249, 225);
	    text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
    }
    .pname{font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	font-variant: small-caps; font-weight: 400;  
	color:rgb(255, 255, 255);
	text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;}
    .detail{ color:rgb(219, 217, 217);font-family: Arial, Helvetica, sans-serif; font-size: 20px;}
    
    .detailTitle{ color:rgb(255, 255, 255);font-family: Arial, Helvetica, sans-serif; font-size: 25px;}

    .addcart{ width: 300px;
        margin-left: 5px;
        margin-top: 130px;
        position: relative;
        height: 250px;}


     .reviewTitle{
        font-family: CenturyGothic; font-size: 40px; font-style: normal; 
	    font-variant: small-caps; font-weight: 400;  
	    color:rgb(219, 245, 255);
	    text-shadow: 0 0 8px #fff347, 0 0 8px #ff6b6b;
        text-align: center;
    }   
    .reviewTitle2{
        font-family: CenturyGothic; font-size: 60px; font-style: normal; 
	    font-variant: small-caps; font-weight: 400;  
	    color:rgb(255, 255, 255);
	    text-shadow: 0 0 8px #ffee00, 0 0 8px #fc0000;
        text-align: center;
    } 
    .review{
        background-color: rgba(0,0,0,0.3);  
	    border:1px solid #e7eaf1; 
	    border-radius:2px; 
	    box-shadow: 0 1px 3px rgba(0,37, 55, .05);
	    box-sizing: border-box;
        width: 50%;
        margin-left: 25%;
        margin-right: 25%;
        margin-bottom: 20px;
        text-align: center;
        
    }  
    .input [type = submit]{
    background: transparent;
    border:none;
    outline:none;
    font-size: 16px;
    color:rgb(255, 0, 0);
    background: #03a9f4;
    padding:15px 20px;
    cursor: pointer;
    border-radius:10px; 
    }
    
</style>

<body  background="img/bk2.jpg;" style="background-repeat:no-repeat;background-size:cover;background-attachment:fixed;">
    <script type ="text/javascript">
        function welcome(){
        alert("Update Successfull!");
        }
    </script>
    <div align="center">
	<% 
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		
		//String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		//String uid = "SA";
        //String pw = "YourStrong@Passw0rd";
        
        try 
            //( Connection con = DriverManager.getConnection(url, uid, pw);) 
            {	
            getConnection();
            Statement stmt = con.createStatement();
            Statement stmtInven = con.createStatement();
            ResultSet rst = stmt.executeQuery("SELECT warehouseName, warehouseId FROM warehouse");//result set has inventory
            out.println("<h1 class = reviewTitle2>Wand Shop Inventory Summary</h1>");// Print out order summary
            while(rst.next()){
                String RSTwarehouseName = rst.getString(1);
                int RSTwarehouseId = rst.getInt(2);

                out.println("<h2 class = reviewTitle>Summary of "+ RSTwarehouseName +"</h2>");// Print out order summary
                
                ResultSet rstInven = stmtInven.executeQuery("SELECT productInventory.productId, productName,"+
                 "quantity FROM productInventory JOIN product ON product.productId = productInventory.productId"+
                 " WHERE warehouseId = " + RSTwarehouseId);
				//ResultSet rstInven = stmtInven.executeQuery("SELECT productId, quantity FROM productInventory WHERE warehouseId = " + RSTwarehouseId);
                out.print("<table class = review><tr class = detailTitle><th>Product Id</th><th>Product Name</th><th size=10>Quantity</th><th>Individual Update</th></tr>");
                while(rstInven.next()){
                    out.println("<tr class = detail><th>"+rstInven.getInt(1)+"</th><th>"+rstInven.getString(2)+"</th>"
                        + "<div><form name=MyInventory method=post action=updateInventory.jsp>"
                        + "<th><input type=text name=pnq value="+rstInven.getInt(3)+" size=10 maxlength=10 </th>"//pattern=\"[0-9]{10}\" title=\"must be digits\">
                        + "<input type=hidden name=pid value = "+rstInven.getInt(1)+">"
                        + "<input type=hidden name=pwi value ="+RSTwarehouseId+">"
                        + "<th><input class=submit type=submit name=Submit3 style = \"width:120px;background-color:rgb(255, 249, 225);outline:none;border:none;cursor:pointer;padding:5px 8px;border-radius:8px;font-family: Arial, Helvetica, sans-serif; font-size: 12px; \" value=\"Update Inventory\"></th>"
                        + "</form>"
                        //+rstInven.getInt(3)+
                        +"</tr></div>");
                }
                out.println("</table>");
            } 
		} catch (SQLException ex) { 	
			out.println(ex); 
		} finally {
            closeConnection();
        }
    %>
    
    </div>
</body>
</html>
