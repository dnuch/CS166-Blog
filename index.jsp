
<%
//Check the session to see if user is already logged in
String user = (String) session.getAttribute( "user" );

if ( null != user ) {
	response.sendRedirect("blog_list.jsp");	
} else {
	response.sendRedirect("main.html");
}
%>
