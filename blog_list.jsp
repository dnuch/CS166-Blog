<!DOCTYPE html>
<%@include file="action/db.jsp" %><%

String user = (String) session.getAttribute( "user" );
String fullname = (String) session.getAttribute( "fullname" );
int admin = (Integer) session.getAttribute( "admin" );
String visibility = "";
if (null == user) {
	response.sendRedirect("login_form.html"); 
}
if (admin == 1) {
    visibility = "none";
}
//Check user
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM blog");
%>

<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="stylesheets/footer.css">
    </head>
    <body>
        <div class="content">
            <div class="w3-bar w3-blue">
                <a class="w3-bar-item">CS166 Blog</a>
                <a class="w3-bar-item w3-button" onclick="document.getElementById('id01').style.display='block'" style="display:<%= visibility %>">Add Blog</a>
                <a class="w3-bar-item w3-button" href="crypto_form.html">Types of Crypto</a>
                <div class="w3-dropdown-hover">
                    <a class="w3-button">Demonstrations</a>
                    <div class="w3-dropdown-content w3-bar-block w3-border w3-card">
                        <a href="demonstrations/sql_injection.html" class="w3-bar-item w3-button">SQL Injection Attack</a>
                        <a href="demonstrations/CSS_injection.html" class="w3-bar-item w3-button">Cross Site Script Injection Attack</a>
                        <a href="demonstrations/website_deface.html" class="w3-bar-item w3-button">Web Site Defacing</a>
                        <a href="demonstrations/cookies.jsp" class="w3-bar-item w3-button">Use of Cookies</a>
                        <a href="demonstrations/session_management.html" class="w3-bar-item w3-button">Session Mechanism</a>
                    </div>
                </div>
                <a class="w3-bar-item w3-right w3-button w3-hover-red" href="action/logout_action.jsp">Log Out</a>
            </div>
            <div class="w3-container">
                <h1>Welcome, <%= fullname %></h1>           
                <div id="id01" class="w3-modal">
                    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:50%">
                         <div class="w3-center"><br>
                            <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright">&times;</span>
                        </div> 
                    <form class="w3-container" action='action/blog_action.jsp'>
                        <div class="w3-section">
                            <label><b>Blog Title</b></label>
                            <input class="w3-input w3-border w3-margin-bottom" name='blogtitle' size=100 required/>
                            <label><b>Content</b></label>     
                            <textarea class="w3-input w3-border w3-margin-bottom" name='blogcontent' style="resize:vertical" required></textarea><br>
                            <button class="w3-button w3-block w3-blue w3-section w3-padding w3-round">Add Blog</button>
                        </div>
                    </form>
                    </div>
                </div>    
            </div>
            <br>
            <form action='action/blog_delete.jsp' method='POST'>
                <%
                while ( rs.next() ) {
                   //pageContext.setAttribute("blog_content", rs.getString("content"));
                   out.print("<div class='w3-container'><div class='w3-card w3-hover-shadow w3-round'><div class='w3-bar w3-teal'><a class='w3-bar-item'>" + rs.getString("title") + " by " + rs.getString("fullname") + "</a>");
                   if(admin == 1 || user.equals(rs.getString("user"))) {
                        out.print("<button class='w3-bar-item w3-button w3-right w3-hover-red' name='deleteblog' value='" + rs.getInt("ID") + "'>&times</button></div>");
                    } else {
                        out.print("</div>");
                    }
                   out.print("<div class='w3-container'><p>" + rs.getString("content") + "</p></div></div></div><br>");
                }
                %>
            </form>
        </div>    
        <footer class="w3-bar w3-blue">
            <a class="w3-bar-item">&copy Danny Nuch</a>
            <a class="w3-bar-item w3-btn w3-opacity" href="privacy_statement.html">Privacy</a>
        </footer>
    </body>
    <script>
    // Get the modal
    var modal = document.getElementById('id01');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    </script>
</html>