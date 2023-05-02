<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<%@ page import="javax.xml.transform.Result" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<% if(request.getSession().getAttribute("reqParam")!=null){
    int idCurrentUser =0;
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="style/home.css">
    <link rel="icon" type="image/x-icon" href="assets/Logo/SmallLogo.png">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/index.global.min.js'></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
    <title>Home</title>
</head>
<body>
<script>

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth'
        });
        calendar.render();
    });

</script>

<nav>

    <a href="#Dashboard"><img src="assets/Logo/SmallLogo.png" width="70%"/></a>
    <a href="#Dashboard"><img src="assets/images/home_icon.png"/></a>
    <a href="#Locations"><img src="assets/images/Locations_icon.png"/></a>
    <a href="#History"><img src="assets/images/Command_History.png"/></a>
    <hr>
    <a href="/logout"><img src="assets/images/Profil_icon.png"/></a>
</nav>

<div class= 'container'>
    <section id= 'Dashboard'>
<input class="SearchInput" placeholder="Search For a Destination ....." type="text"/>
    <%
       String connectionURL = "jdbc:mysql://localhost:3307/TicketMate";
        Connection  connection = null;
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        connection = DriverManager.getConnection(connectionURL, "root", "");
    %>
    <%if(!connection.isClosed())
    %>

        <%

            String sqlQuery = "select nom_client , bio ,idclient from client c where email_client=?";

            PreparedStatement psGetUsername = connection.prepareStatement(sqlQuery);
            psGetUsername.setString(1,String.valueOf(request.getSession().getAttribute("reqParam")));
            ResultSet rsusername = psGetUsername.executeQuery();
            try {
            while(rsusername.next()){
                idCurrentUser=rsusername.getInt("idclient");
                session.setAttribute("user",String.valueOf(idCurrentUser));
                session.setAttribute("username",rsusername.getString("nom_client"));
        %>

                    <a href="Login.jsp">   <h2 id="currentUsername"><%=rsusername.getString("nom_client")%></h2></a>
        <%
            }
                }catch (SQLException e) {
                  System.out.println("Error During Getting Values");
                }

           %>

        <div >
            <h3>Deal of the Day ! </h3>
            <%

                Statement psListOffres = connection.createStatement();
                ResultSet rsListeOffres = psListOffres.executeQuery("select * from offres where prix_offre < 2000 order by prix_offre ASC LIMIT 1");
                while(rsListeOffres.next()){

                    PreparedStatement psVille = connection.prepareStatement("select designation,image from villes where id_ville=?");
                    psVille.setInt(1,Integer.parseInt(rsListeOffres.getString("ville_offre")));
                    ResultSet rsVilleDetail = psVille.executeQuery();

                    PreparedStatement psAgence = connection.prepareStatement("select adresse_agence,nom_agence from agences where id_agence=?");
                    psAgence.setInt(1,Integer.parseInt(rsListeOffres.getString("id_agense")));
                    ResultSet rsAgenceDetail = psAgence.executeQuery();

                    while(rsVilleDetail.next() && rsAgenceDetail.next()){
                        Blob blob = rsVilleDetail.getBlob("image");

                        InputStream inputStream = blob.getBinaryStream();
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = outputStream.toByteArray();
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            %>
            <div class="card" >
                <div class="card-body">
                    <img id="offerImage" src="data:image/jpg;base64,<%=base64Image%>"/>
                    <h5 class="card-title" style="color:#BF2051;"><%=rsAgenceDetail.getString("nom_agence")%></h5>
                    <h5 class=""><%=rsVilleDetail.getString("designation")%></h5>
                    <h5 class="" style="float: right;color:#BF2051;"><b><%=rsListeOffres.getInt("prix_offre")%> DHS / J</b></h5>

                </div>
            </div>
<%
        }
    }
%>
        </div>
        <div style="margin-top:4%">
            <h3>Best Destinations : <a class="link" href="#Locations"><h6>Explore More : </h6></a> </h3>

            <div class="box" >


            <%
                Statement psListOffress = connection.createStatement();

                ResultSet rsListeDest = psListOffress.executeQuery("select  distinct * from offres order by prix_offre > 2000 LIMIT 3");
                while(rsListeDest.next()){

                    PreparedStatement psVilleDest = connection.prepareStatement("select designation,image,id_ville from villes where id_ville=?");
                    psVilleDest.setInt(1,Integer.parseInt(rsListeDest.getString("ville_offre")));
                    ResultSet rsVilleDetailDest = psVilleDest.executeQuery();

                    PreparedStatement psAgence = connection.prepareStatement("select adresse_agence,nom_agence from agences where id_agence=?");
                    psAgence.setInt(1,Integer.parseInt(rsListeDest.getString("id_agense")));
                    ResultSet rsAgenceDetailsDest = psAgence.executeQuery();

                    while(rsVilleDetailDest.next() && rsAgenceDetailsDest.next()){
                        Blob blobs = rsVilleDetailDest.getBlob("image");

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
                    <div class="cardSmall" >
                        <a style="text-decoration: none" href="/Destination/<%=rsListeDest.getInt("id_offre")%>">

                        <div class="card-bodySmall">
                            <img id="offerImagesSmall" src="data:image/jpg;base64,<%=base64Images%>"/>
                            <h5 class="card-titleSmall" style="color:#BF2051;"><%=rsAgenceDetailsDest.getString("nom_agence")%></h5>
                            <h5 class=""><%=rsVilleDetailDest.getString("designation")%></h5>
                        </div>
                        </a>
                    </div>

                    <%
                        }
                        }
                    %>

                    </div>

            <div id='calendar' ></div>
        </div>
        <div style="float: right;border:2px solid black;border-radius:20px;background-color:#DEDEDE;width:35%;margin-top: -12%;margin-right: 1.5%;max-height:300px">
            <h2 style="color:black;background-color: white;border-top-left-radius: 18px;border-top-right-radius: 18px;text-align: center">Notes : </h2>
            <%
                PreparedStatement psNotes = connection.prepareStatement("select * from notes where id_clientn=? and DATE(date_note) >= CURRENT_DATE() LIMIT 4 ");
                psNotes.setInt(1,idCurrentUser);

                ResultSet rsNotes = psNotes.executeQuery();
                while(rsNotes.next()){
            %>
                <ul>
                    <li><%=rsNotes.getString("contenu")%><input style="float: right;margin-top: 1%;margin-right: 2%" type="checkbox"/>
                    <br>
                        <label style="font-size: 10px"><%=rsNotes.getString("date_note")%></label>
                    </li>
                </ul>
            <%
                }
            %>
        </div>
    </section>
    <section id= 'Locations'>
        <h3>Our Destinations :</h3>
        <%
            PreparedStatement psVilleDest = connection.prepareStatement("select designation,image from villes ");
            ResultSet rsVilleDetailDest = psVilleDest.executeQuery();
            while(rsVilleDetailDest.next()){
                Blob blobs = rsVilleDetailDest.getBlob("image");

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

        <div class="cardVille" style="width: 18rem; display: inline-grid;margin:0.5%;">
            <div class="card-body">
                <img id="VilleImagesSmall" src="data:image/jpg;base64,<%=base64Images%>"/>

                <h5 class="" style="color:#BF2051;"><%=rsVilleDetailDest.getString("designation")%></h5>

            </div>
        </div>
        <%
            }
        %>
    </section>

    <section id= 'History'>
        <h1>Third</h1>
    </section>

    <section id= 'Profile'>
        <h1>Fourth</h1>
    </section>
</div>
</body>
<%
    }else{
        response.sendRedirect("/");
    }
%>
</html>
<script>

</script>
