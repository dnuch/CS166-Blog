<%@include file="db.jsp" %>

<%
String delblog = request.getParameter("deleteblog");
Statement stmt = con.createStatement();
stmt.execute("DELETE FROM blog WHERE ID =" + delblog);
response.sendRedirect("blog_list.jsp"); 
%>