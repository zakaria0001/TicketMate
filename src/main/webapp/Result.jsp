<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<%
    String name=request.getParameter("val");
    if(name==null||name.trim().equals("")){

    }else{
        try{
            String connectionURL = "jdbc:mysql://localhost:3307/TicketMate";
            Connection connection = null;
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(connectionURL, "root", "");
            PreparedStatement psResult =connection.prepareStatement("select * from villes where designation like '"+name+"%'");
            ResultSet rs=psResult.executeQuery();
            if(!rs.isBeforeFirst()) {
                out.println("<p>No result!</p>");
            }else{
                 while(rs.next()){%>



                    <a href="/Destinations/<%=rs.getString("designation")%>"><h2><%=rs.getString("designation")%></h2></a>
                <%
                 }}
            connection.close();
        }catch(Exception e){out.print(e);}
    }
%>
</body>
</html>