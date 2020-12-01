<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

// Delete product selected
// Get product information
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
Integer quantity = new Integer(1);

// Store product information in an ArrayList
ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);
product.add(quantity);

// Update quantity if add same item to order again
if (productList.containsKey(id))
{	product = (ArrayList<Object>) productList.get(id);
	int curAmount = ((Integer) product.get(3)).intValue();
	productList.remove(id,product);
}

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />