<!DOCTYPE html>
<%@ page import="java.util.*" %>
<%
  Cookie[] cookies = request.getCookies();
  if (cookies == null)
    cookies = new Cookie[0];
  Date thisVisit = new Date();
  // add data cookie to session
  Cookie c = new Cookie("lastVisit",""+thisVisit);
  response.addCookie(c);
  // add cookie to session
  String name = request.getParameter("name");
  String value = request.getParameter("value");
  Cookie added = null;
  if (name!=null && value!=null && name.length()>0) {
    added = new Cookie(name,value);
    response.addCookie(added);
  }
%>
<HTML>
  <HEAD>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="../stylesheets/footer.css">
    <TITLE>Cookie List</TITLE>
  </HEAD>
  <BODY>
    <div class="content">
        <div class="w3-bar w3-blue">
            <a class="w3-bar-item w3-button" href="../index.jsp">CS166 Blog</a>
            <a class="w3-bar-item w3-button" href="../crypto_form.html">Types of Crypto</a>
            <div class="w3-dropdown-hover">
                <a class="w3-button">Demonstrations</a>
                <div class="w3-dropdown-content w3-bar-block w3-border w3-card">
                    <a href="sql_injection.html" class="w3-bar-item w3-button">SQL Injection Attack</a>
                    <a href="CSS_injection.html" class="w3-bar-item w3-button">Cross Site Script Injection Attack</a>
                    <a href="website_deface.html" class="w3-bar-item w3-button">Web Site Defacing</a>
                    <a href="cookies.jsp" class="w3-bar-item w3-button">Use of Cookies</a>
                    <a href="session_management.html" class="w3-bar-item w3-button">Session Management</a>
                </div>
            </div>
            <a class="w3-bar-item w3-right w3-button w3-hover-red" href="../action/logout_action.jsp">Log Out</a>
        </div>
        <div class="w3-container">
            <br>
            <h><strong>Use of Cookies</strong></h>
            <p>Web cookies record and store user data (such as session time) in the web browser of a user.  Cookies allow for websites to remember stateful information such as if a session is valid or invalid.</p>
            <br><br>
            This visit: <%= thisVisit %><BR>
            Number of cookies: <%= cookies.length %><BR>
            <H2>Cookies</H2>
            <%
            for (int i=0; i<cookies.length; i++) {
              out.println(cookies[i].getName()+":\t"+
                cookies[i].getValue()+"<BR>");
              // check if added cookie already present
              if (added!=null && added.getName().equals(cookies[i].getName()))
                added = null;
            }
            if (added != null)
              out.println("new cookie: "+added.getName()+":\t"+
                added.getValue()+"<BR>");
            %>
            <H2>New cookie</H2>
            <FORM>
                <div class="w3-section">
                    <p>
                        <label>Name:</label><INPUT class="w3-border w3-margin-bottom" TYPE='TEXT' NAME='name'/>
                    </p>
                    <p>
                        <label>Value:</label><INPUT class="w3-border w3-margin-bottom" TYPE='TEXT' NAME='value'/>
                    </p>
                    <p>
                        <button class="w3-btn w3-blue w3-ripple w3-round">Add new value</button>
                    </p>
                </div>
            </FORM>
        </div>
    </div>
    <footer class="w3-bar w3-blue">
        <a class="w3-bar-item">&copy Danny Nuch</a>
        <a class="w3-bar-item w3-btn w3-opacity" href="../privacy_statement.html">Privacy</a>
    </footer>
  </BODY>
</HTML>