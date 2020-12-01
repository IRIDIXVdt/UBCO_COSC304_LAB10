<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%

	
    session = request.getSession(true);
    String newusername = request.getParameter("newusername");
    String newpassword = request.getParameter("newpassword");
    boolean validPassword = false;
    boolean validUsername = false;
    boolean exsit = false;
    


	try
	{
        validPassword = validatePassword(out,request,session,newpassword);
        validUsername = validateUsername(out,request,session,newusername);
        try{
            getConnection();
          
            String sql = "select userid from customer";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rst = stmt.executeQuery();
			while(rst.next()){
                if(newusername.equals(rst.getString(1))){
                    exsit = true;
                }
            }

             }catch (SQLException ex) {// throws exception here
                out.println(ex);
            }finally{
                try{closeConnection();}catch(SQLException e){}
             }
     
        
        if(!validUsername){	
            session.setAttribute("registerMessage","Username must contains 1 letter");
            response.sendRedirect("register.jsp");
        }
        else if(!validPassword){	
            session.setAttribute("registerMessage","Password must contains 1 letter");
            response.sendRedirect("register.jsp");
        }
        else if(exsit){
            session.setAttribute("registerMessage","The user name already exsit!");
            response.sendRedirect("register.jsp");
        }
        
        else{
            
            try{
              getConnection();
			
			String sql = "INSERT INTO customer (userid, password) VALUES(?,?);";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1,newusername);
            pstmt.setString(2,newpassword);

            pstmt.executeUpdate();
            
           
            }catch (SQLException ex) {// throws exception here
                out.println(ex);
            }finally{
                try{closeConnection();}catch(SQLException e){}
            }
            
            session.removeAttribute("registerMessage");
            response.sendRedirect("login.jsp");		// Successful login, jump to login  
        }
		
        
	}
	catch(IOException e){	
        System.err.println(e); 
    }

	
%>


<%!
	boolean validateUsername(JspWriter out,HttpServletRequest request, HttpSession session, String newusername) throws IOException
	{
	
       if(newusername==null) return false;

		for(int i=0; i < newusername.length(); i++) {
				if(Character.isLetter(newusername.charAt(i))){
					return true;
				    }
				 
			}
				
				
		return false;
		
    }

    boolean validatePassword(JspWriter out,HttpServletRequest request, HttpSession session,String newpassword) throws IOException
	{

        if(newpassword==null) return false;

		for(int i=0; i < newpassword.length(); i++) {
				if(Character.isLetter(newpassword.charAt(i))){
					return true;
				    }				 
			}								
		return false;		
    }
    
%>

