<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<!doctype html>
<html lang="en">
<head>
<% String connectionURL = "jdbc:mysql://localhost:3307/TicketMate";
    Connection connection = null;
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    connection = DriverManager.getConnection(connectionURL, "root", "");
%>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>TicketMate</title>
    <link rel="icon" type="image/x-icon" href="assets/Logo/SmallLogo.png">
    <link rel="stylesheet" href="../style/offre.css">
</head>
<% if(session.getAttribute("user")!=null){%>
<body>
<nav>
    <a href="/Home#Dashboard"><img src="../assets/Logo/SmallLogo.png" width="70%"/></a>
    <a href="/Home#Dashboard"><img src="../assets/images/home_icon.png"/></a>
    <a href="/Home#Locations"><img src="../assets/images/Locations_icon.png"/></a>
    <a href="/Home#History"><img src="../assets/images/Command_History.png"/></a>
    <hr>
    <a href="/logout"><img src="../assets/images/Profil_icon.png"/></a>
</nav>
<a href="Login.jsp"><h2 id="currentUsername"><%=session.getAttribute("username")%></h2></a>
    <div id="container" >
        <%

            PreparedStatement psOffreDetails = connection.prepareStatement("Select * from offres where id_offre=?");
            psOffreDetails.setInt(1, Integer.parseInt(String.valueOf(request.getAttribute("idOffre"))));
            ResultSet rsOffreDetail = psOffreDetails.executeQuery();
            if(rsOffreDetail.next()){
        %>
            <h2><%=rsOffreDetail.getString("description")%></h2>
        <%
            }
        %>
    </div>
</body>
<%}else{
    response.sendRedirect("/");
}%>
</html>