<%@ page import = "java.security.*, java.security.spec.*, javax.crypto.*, javax.crypto.spec.*" %>
<%@include file="db.jsp" %>
<%
   int ITERATIONS = 10000;
   int KEY_LENGTH = 256;

   //Check user
   String user = request.getParameter( "user" );
   String pass = request.getParameter( "pass" );
   String sqlStr = "SELECT salt FROM login WHERE user=?";
   PreparedStatement stmt = con.prepareStatement(sqlStr);
   stmt.setString(1, user);
   ResultSet rs = stmt.executeQuery();
   if(!rs.next()) {
       response.sendRedirect("../login_form.html");
   } else {
       byte[] salt = rs.getBytes("salt");

       PBEKeySpec spec = new PBEKeySpec(pass.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
       SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
       byte[] hashed_pass = skf.generateSecret(spec).getEncoded();
       spec.clearPassword();

       sqlStr = "SELECT * FROM login WHERE hashed_pass=?";
       stmt = con.prepareStatement(sqlStr);
       stmt.setBytes(1, hashed_pass);
       rs = stmt.executeQuery();

       if ( rs.next() ) {
           session.setAttribute( "user", user );
           session.setAttribute( "fullname", rs.getString("fullname") );
           session.setAttribute( "admin", rs.getInt("admin") );
           session.setMaxInactiveInterval(60*20);
           response.sendRedirect("../blog_list.jsp");	
       } else {
           response.sendRedirect("../login_form.html");
       }
   }
%>
