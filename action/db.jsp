<%@ page import = "java.sql.*, java.util.*, java.io.*" %><%		

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dnuch", "dnuch", "monkey");

%>