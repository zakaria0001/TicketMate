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
    <a href="#Profile"><img src="assets/images/Profil_icon.png"/></a>
</nav>

<div class= 'container'>
    <section id= 'Dashboard'>
<%--<input  placeholder="Search For a Destination ....." onkeyup="searchInfo()" type="text"/>--%>


        <form name="vinform">
            <input placeholder="Search For a Destination ....." class="SearchInput" type="text" name="name" onkeyup="searchInfo()">
        </form>

        <div id="mylocation"></div>
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

                    <a href="/logout">   <h2 class="currentUsername"><%=rsusername.getString("nom_client")%></h2></a>
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
                <img id="offerImage" src="data:image/jpg;base64,<%=base64Image%>"/>

                <a style="text-decoration: none;        color:#717171;
" href="/Destination/<%=rsListeOffres.getInt("id_offre")%>">
                <div class="card-body">
                    <h5 class="card-title" style="color:#BF2051;"><%=rsAgenceDetail.getString("nom_agence")%></h5>
                    <h5 class=""><%=rsVilleDetail.getString("designation")%></h5>
                    <h5 class="" style="float: right;color:#BF2051;"><b><%=rsListeOffres.getInt("prix_offre")%> DHS / J</b></h5>
                </div>
                </a>
            </div>
<%
        }
    }
%>
        </div>
        <div style="margin-top:3%">
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
                            <img id="offerImagesSmall" src="data:image/jpg;base64,<%=base64Images%>"/>

                        <div class="card-bodySmall">
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
        <div id="Notes">
            <h2 style="color:black;background-color: white;border-top-left-radius: 18px;border-top-right-radius: 18px;text-align: center">Notes : <label style="font-weight: bolder;float: right;margin-right: 1%">+</label></h2>
            <%
                PreparedStatement psNotes = connection.prepareStatement("select * from notes where id_clientn=? and DATE(date_note) >= CURRENT_DATE() LIMIT 2 ");
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
        <a href="Login.jsp">   <h2 class="currentUsername"><%=session.getAttribute("username")%></h2></a>

        <h2 class="title">Our Destinations :</h2>
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
            <a style="text-decoration: none" href="/Destinations/<%=rsVilleDetailDest.getString("designation")%>">

            <img id="VilleImagesSmall" src="data:image/jpg;base64,<%=base64Images%>"/>

            <div class="card-body">
                <h5 class="" style="color:#BF2051;"><%=rsVilleDetailDest.getString("designation")%></h5>
            </div>
            </a>
        </div>
        <%
            }
        %>
    </section>

    <section id= 'History'>
        <a href="Login.jsp"><h2 class="currentUsername"><%=session.getAttribute("username")%></h2></a>
        <h2 class="title">History :</h2>

        <table>
            <thead>
            <tr>
                <td>Departure</td>
                <td>Destination</td>
                <td>Date</td>
                <td>Agency</td>
                <td>Total Price</td>
                <td>Actions </td>
            </tr>
            </thead>
            <%
                int RecordsCounter=0;
                PreparedStatement psBilletList = connection.prepareStatement("select * from billets where id_client=?");
                psBilletList.setInt(1,idCurrentUser);
                ResultSet rsBilletList = psBilletList.executeQuery();
                while(rsBilletList.next()){
                    RecordsCounter++;
                    PreparedStatement psAgenceDetail = connection.prepareStatement("select * from offres o join  agences a on o.id_agense=a.id_agence where o.id_offre=?");
                    psAgenceDetail.setInt(1,rsBilletList.getInt("id_offre"));
                    ResultSet rsAgenceDetail = psAgenceDetail.executeQuery();


                    while(rsAgenceDetail.next()){
                        PreparedStatement psAgenceName = connection.prepareStatement("select * from agences where id_agence=?");
                        psAgenceName.setInt(1,rsAgenceDetail.getInt("id_agense"));
                        ResultSet rsAgenceName = psAgenceName.executeQuery();

                    PreparedStatement psAirportDepart = connection.prepareStatement("select * from aeroports where id_aeroport=?");
                    psAirportDepart.setInt(1,rsBilletList.getInt("aeroport_depart"));
                    ResultSet rsAirportDepart = psAirportDepart.executeQuery();

                    PreparedStatement psAirportArrivee = connection.prepareStatement("select * from aeroports where id_aeroport=?");
                    psAirportArrivee.setInt(1,rsBilletList.getInt("aeroport_arrivee"));
                    ResultSet rsAirportArrivee = psAirportArrivee.executeQuery();
                    while (rsAirportDepart.next() && rsAirportArrivee.next() && rsAgenceName.next()){
            %>
            <tbody>
            <tr>
                <td><%=rsAirportDepart.getString("nom_aeroport")%></td>
                <td><%=rsAirportArrivee.getString("nom_aeroport")%></td>
                <td><%=rsBilletList.getString("date_depart")%></td>
                <td><%=rsAgenceName.getString("nom_agence")%></td>
                <td style="color: #BF2051"><b><%=rsBilletList.getInt("prix")%> DHS </b></td>
                <td style="color: #BF2051"><b><a href="/Billet/<%=rsBilletList.getInt("id_billet")%>">Delete </a></b></td>
            </tr>
            </tbody>
            <%
                        }
                    }
                }
                if(RecordsCounter==0){
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center">No Previous Reservation</td>
                    </tr>
                <% } %>
        </table>
    </section>

    <section id= 'Profile'>
        <a href="Login.jsp"><h2 class="currentUsername"><%=session.getAttribute("username")%></h2></a>
        <%

            String userInfo = "select * from client c where email_client=?";

            PreparedStatement psGetUserInfo = connection.prepareStatement(userInfo);
            psGetUserInfo.setString(1,String.valueOf(request.getSession().getAttribute("reqParam")));
            ResultSet rsuserInfo = psGetUserInfo.executeQuery();

                while(rsuserInfo.next()){
                    Blob blobUserPic = rsuserInfo.getBlob("profile_pic");

                    InputStream inputStreamsUser = blobUserPic.getBinaryStream();
                    ByteArrayOutputStream outputStreamUser = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesReads = -1;

                    while ((bytesReads = inputStreamsUser.read(buffer)) != -1) {
                        outputStreamUser.write(buffer, 0, bytesReads);
                    }

                    byte[] imageBytes = outputStreamUser.toByteArray();
                    String ProfilePicture = Base64.getEncoder().encodeToString(imageBytes);
        %>
        <h2 class="title">My Profile :</h2>
        <div id="container">

           <div class="upperInfo">
               <img id="ProfilePicture"  src="data:image/jpg;base64,<%=ProfilePicture%>"/>
               <div class="PersonalInfo">
                 <h1><%=session.getAttribute("username")%></h1>
                 <h4><%=rsuserInfo.getString("bio")%></h4>
                 <h4><%=rsuserInfo.getString("city")%></h4>
                   <button class="LogOutButton"><a href="/logout">Logout</a></button>
               </div>
           </div>
            <div class="DetailledInfo">
                <button id="editButton" onclick="myFunction()"><a>Edit</a></button>
                <h1>Personal Information : </h1>
                <table id="UserInfosShow">
                    <tr>
                        <td>
                            <h4>Full Name :</h4>
                            <h3><%=rsuserInfo.getString("nom_client")%></h3>
                        </td>
                        <td>
                            <h4>Email Adress : </h4>
                            <h3><%=rsuserInfo.getString("email_client")%></h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h4>Bio :</h4>
                            <h3><%=rsuserInfo.getString("bio")%></h3>
                        </td>
                        <td>
                            <h4>Password :</h4>
                            <input  type="password" value="<%=rsuserInfo.getString("password")%>"/>
                        </td>
                    </tr>
                </table>
                <table id="UpdatableTable">
                    <tr>
                        <td>
                            <h4>Full Name :</h4>
                            <input  type="text"value="<%=rsuserInfo.getString("nom_client")%>"/>
                        </td>
                        <td>
                            <h4>Email Adress : </h4>
                            <input type="text"  value="<%=rsuserInfo.getString("email_client")%>">

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h4>Bio :</h4>
                            <input type="text" value="<%=rsuserInfo.getString("bio")%>">

                        </td>
                        <td>
                            <h4>Password :</h4>
                            <input  type="password" value="<%=rsuserInfo.getString("password")%>"/>
                        </td>
                    </tr>
                </table>
            </div>
            </div>
        <%
            }
        %>
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
    function myFunction() {
        var x = document.getElementById("UserInfosShow");
        var y = document.getElementById("UpdatableTable");

        if (x.style.display === "table") {
            x.style.display="none";
            y.style.display = "table";
            y.style.width="90%";

        } else {
            x.style.display = "table";
            x.style.width="90%";
            y.style.display = "none";
        }


    }

</script>
<script src="../style/jquery.js"></script>
<script>

    var request=new XMLHttpRequest();
    function searchInfo(){
        var name=document.vinform.name.value;
        var url="Result.jsp?val="+name;

        try{
            request.onreadystatechange=function(){
                if(request.readyState==4){
                    var val=request.responseText;
                    document.getElementById('mylocation').innerHTML=val;
                }
            }//end of function
            request.open("GET",url,true);
            request.send();
        }catch(e){alert("Unable to connect to server");}
    }
</script>
