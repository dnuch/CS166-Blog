<%@include file="db.jsp" %><%
//Check user
String blogtitle   = request.getParameter( "blogtitle" );
String blogcontent = request.getParameter( "blogcontent" );
String fullname   = (String) session.getAttribute( "fullname" );
String user   = (String) session.getAttribute( "user" );
//prevent html contents with empty space
blogtitle = blogtitle.replaceAll("<!--.*?-->", "").replaceAll("<[^>]+>", "");     
blogcontent = blogcontent.replaceAll("<!--.*?-->", "").replaceAll("<[^>]+>", "");                                             
String sqlStr = "INSERT INTO blog (title,content,user,fullname) VALUES ( ?, ?, ?, ? )";
PreparedStatement stmt = con.prepareStatement(sqlStr);
stmt.setString(1, blogtitle);
stmt.setString(2, blogcontent);
stmt.setString(3, user);
stmt.setString(4, fullname);
stmt.execute();
response.sendRedirect("blog_list.jsp"); 
%>

<%
//SQL injection attack
// a ' OR '1'='1' -- 
//Users', (select GROUP_CONCAT(fullname) from login), 'hacker') -- 
%>
    
    
