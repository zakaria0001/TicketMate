<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Dashboard</title>
    <link rel="stylesheet" href="../style/DashboardAdmin.css">

</head>
<%if(request.getSession().getAttribute("Username")!=null ){
    String connectionURL = "jdbc:mysql://localhost:3307/TicketMate";
    Connection connection = null;
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    connection = DriverManager.getConnection(connectionURL, "root", "");
    if(connection!=null){
%>
<body>
<h2>Home </h2>
    <%=request.getSession().getAttribute("Username")%>
    <%

    %>
</body>
<%}}else{
    response.sendRedirect("/Admin");
}%>
</html>