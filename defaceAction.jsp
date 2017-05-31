<%
   try {
        String input = request.getParameter( "input" );
        out.print(input);
   } catch (Exception error) {
        out.print("error");
   } 
%>