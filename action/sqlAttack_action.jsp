<%@include file="db.jsp" %>
<%
   try {
        String testinjection = request.getParameter( "testinjection" );
        String sqlStr = "SELECT * FROM login WHERE user='" + testinjection;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sqlStr);
        if(rs.next())
        {
            out.print("SQL string query returned true");
        }
   } catch (Exception error) {
        out.print("error");
   } 
%>