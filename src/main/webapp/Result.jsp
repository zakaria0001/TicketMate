<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<style>
    #ResultImage{
        width: 20%;
        border-radius: 5px;
    }
    #box{
        width: 100%;
        padding: 2%;
        font-size: 10px;
        border-radius: 30px;
    }
    #box a{
        margin: 1%;
    }
    #box:hover{
        background-color: #BF2051;
    }
</style>
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
                 while(rs.next()){
                     Blob blobs = rs.getBlob("image");

                     InputStream inputStreams = blobs.getBinaryStream();
                     ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                     byte[] buffer = new byte[4096];
                     int bytesRead = -1;

                     while ((bytesRead = inputStreams.read(buffer)) != -1) {
                         outputStream.write(buffer, 0, bytesRead);
                     }

                     byte[] imageBytes = outputStream.toByteArray();
                     String base64Images = Base64.getEncoder().encodeToString(imageBytes);
%>
                    <div style="display: inline-flex" id="box">
                        <img id="ResultImage" src="data:image/jpg;base64,<%=base64Images%>"/>

                        <a style="color:black;text-decoration: none;font-size: 15px" href="/Destinations/<%=rs.getString("designation")%>"><h2><%=rs.getString("designation")%></h2></a>

                    </div>
                <%
                 }}
            connection.close();
        }catch(Exception e){out.print(e);}
    }
%>
</body>
</html>