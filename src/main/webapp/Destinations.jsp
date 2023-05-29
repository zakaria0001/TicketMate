<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
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
    <title><%=request.getSession().getAttribute("NomDest")%> - TicketMate</title>
    <link rel="icon" type="image/x-icon" href="../assets/Logo/SmallLogo.png">
    <link rel="stylesheet" href="../style/Destinations.css">
</head>
    <%
            if(request.getSession().getAttribute("NomDest")!=null){
    %>
<body>
<nav>
    <a href="/Home#Dashboard"><img src="../assets/Logo/SmallLogo.png" width="70%"/></a>
    <a href="/Home#Dashboard"><img src="../assets/images/home_icon.png"/></a>
    <a href="/Home#Locations"><img src="../assets/images/Locations_icon.png"/></a>
    <a href="/Home#History"><img src="../assets/images/Command_History.png"/></a>
    <hr>
    <a href="/Home#Profile"><img src="../assets/images/Profil_icon.png"/></a>
</nav>
<a href="Login.jsp">   <h2 class="currentUsername"><%=session.getAttribute("username")%></h2></a>

<section id="container">
        <%
            int size =0;
            PreparedStatement psDestOffers = connection.prepareStatement("select * from offres where ville_offre=(select id_ville from villes where designation=?)");
            psDestOffers.setString(1,request.getSession().getAttribute("NomDest").toString());
            ResultSet rsDestOffers= psDestOffers.executeQuery();
            while(rsDestOffers.next()){
                size++;
                PreparedStatement psVilleDest = connection.prepareStatement("select designation,image,id_ville from villes where id_ville=?");
                psVilleDest.setInt(1,Integer.parseInt(rsDestOffers.getString("ville_offre")));
                ResultSet rsVilleDetailDest = psVilleDest.executeQuery();

                PreparedStatement psAgence = connection.prepareStatement("select adresse_agence,nom_agence,logo from agences where id_agence=?");
                psAgence.setInt(1,Integer.parseInt(rsDestOffers.getString("id_agense")));
                ResultSet rsAgenceDetailsDest = psAgence.executeQuery();

                while(rsVilleDetailDest.next() && rsAgenceDetailsDest.next()){

//                    Image Ville Stream
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

//                    Logo Agence Stream
                    Blob blobss = rsAgenceDetailsDest.getBlob("logo");

                    InputStream inputStreamss = blobss.getBinaryStream();
                    ByteArrayOutputStream outputStreams = new ByteArrayOutputStream();
                    byte[] buffers = new byte[4096];
                    int bytesReads = -1;

                    while ((bytesReads = inputStreamss.read(buffers)) != -1) {
                        outputStreams.write(buffers, 0, bytesReads);
                    }

                    byte[] imageBytess = outputStreams.toByteArray();
                    String base64Imagess = Base64.getEncoder().encodeToString(imageBytess);



        %>
        <div class="cardVille" >
            <a style="text-decoration: none" href="/Destination/<%=rsDestOffers.getInt("id_offre")%>">
                <img id="offerImagesSmall" src="data:image/jpg;base64,<%=base64Imagess%>"/>
                <div class="card-bodySmall">
                    <h3 class="" style="color:black;float:left;margin-top: 1.2%"><%=rsAgenceDetailsDest.getString("nom_agence")%></h3>
                    <h3 class="card-titleSmall" style="color:#BF2051;float: right"><%=rsDestOffers.getInt("prix_offre")%> DHS / J</h2>
                </div>
            </a>
        </div>
<%--                <h2><%=rsDestOffers.getString("description")%></h2>--%>
<%--                <h2><%=rsDestOffers.getInt("id_agense")%></h2>--%>


<%
            }
        }
        if(size==0){ %>
           <h1 style="text-align: center" >No Offers here ! </h1>
       <% }%>
</section>
</body>
<%
    } else{
    response.sendRedirect("/");
        }
%>
</html>
<script>

</script>