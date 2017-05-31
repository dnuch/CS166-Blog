<%@page import = "java.security.*, java.security.spec.*, javax.crypto.*, javax.crypto.spec.*" %>
<%@include file="db.jsp" %>

<%
   //get form input
   String fullname  = request.getParameter( "fullname" );
   String user      = request.getParameter( "user" );
   String pass      = request.getParameter( "pass" );
   String recaptcha = request.getParameter( "g-recaptcha-response" );
   
   //identify uniqueness of user 
   String sqlStr = "SELECT user FROM login where user=?";
   PreparedStatement stmt = con.prepareStatement(sqlStr);
   stmt.setString(1, user);
   ResultSet rs = stmt.executeQuery();
   if(recaptcha.equals("") || rs.next()) {
       response.sendRedirect("register_form.html");
   } else {
       Random RANDOM = new SecureRandom();
       int ITERATIONS = 10000;
       int KEY_LENGTH = 256;

       byte[] salt = new byte[16];
       RANDOM.nextBytes(salt);

       PBEKeySpec spec = new PBEKeySpec(pass.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
       SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
       byte[] hashed_pass = skf.generateSecret(spec).getEncoded();
       spec.clearPassword();

       sqlStr = "INSERT INTO login(fullname, user, hashed_pass, salt, admin) VALUES ( ?, ?, ?, ?, ? )";
       stmt = con.prepareStatement(sqlStr);
       stmt.setString(1, fullname);
       stmt.setString(2, user);
       stmt.setBytes (3, hashed_pass);     
       stmt.setBytes (4, salt);   
       stmt.setInt   (5, 0);   //Default admin = 0
       stmt.execute();
       response.sendRedirect("login_form.html"); 
   }
   //SQL injection attack
   // a' OR 1=1 --
%> 
