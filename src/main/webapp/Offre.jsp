<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Base64" %>
<!doctype html>
<html lang="en" >
<meta charset="UTF-8">

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
    <link rel="icon" type="image/x-icon" href="../assets/Logo/SmallLogo.png">
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
<a href="Login.jsp"><h2 class="currentUsername"><%=session.getAttribute("username")%></h2></a>
    <div id="container">
        <%
            int idCurrentuser =0;
            int idCurrentOffre=Integer.parseInt(request.getSession().getAttribute("idOffre").toString());
            PreparedStatement UserDetails = connection.prepareStatement("select * from client where email_client=?");
            UserDetails.setString(1,String.valueOf(request.getSession().getAttribute("reqParam")));
            ResultSet rsUserDetail = UserDetails.executeQuery();
            if(rsUserDetail.next()){
                idCurrentuser=rsUserDetail.getInt("idclient");
            }
            PreparedStatement psOffreDetails = connection.prepareStatement("Select * from offres where id_offre=?");
            psOffreDetails.setInt(1, Integer.parseInt(String.valueOf(request.getSession().getAttribute("idOffre"))));
            ResultSet rsOffreDetail = psOffreDetails.executeQuery();
            if(rsOffreDetail.next()){
                PreparedStatement psListeAeroport = connection.prepareStatement("Select * from aeroports where ville NOT IN(?)");
                psListeAeroport.setInt(1,rsOffreDetail.getInt("ville_offre"));
                ResultSet rsListeAeroport = psListeAeroport.executeQuery();

                PreparedStatement psAeroportArrivee = connection.prepareStatement("Select * from aeroports where ville=? ");
                psAeroportArrivee.setInt(1,rsOffreDetail.getInt("ville_offre"));
                ResultSet rsAeroportArrivee = psAeroportArrivee.executeQuery();


                PreparedStatement psVille = connection.prepareStatement("select designation,image from villes where id_ville=?");
                psVille.setInt(1,Integer.parseInt(rsOffreDetail.getString("ville_offre")));
                ResultSet rsVilleDetail = psVille.executeQuery();

                PreparedStatement psAgence = connection.prepareStatement("select adresse_agence,nom_agence from agences where id_agence=?");
                psAgence.setInt(1,Integer.parseInt(rsOffreDetail.getString("id_agense")));
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
        <section style="float: left" id="LeftP">
            <img id="offerImage" src="data:image/jpg;base64,<%=base64Image%>"/>

        </section>
        <section id="RightP">
            <h1 class=""><%=rsVilleDetail.getString("designation")%></h1>
            <h1 class="card-title" style="color:#BF2051;"><%=rsAgenceDetail.getString("nom_agence")%></h1>
            <h1 class="card-title"  style="color:#BF2051;"><%=rsOffreDetail.getInt("prix_offre")%> DHS / J</h1>
            <input hidden id="PrixJournee" value="<%=rsOffreDetail.getInt("prix_offre")%>"/>
            <button id="orderButton" onclick="myFunction()">Check Availability</button>
        </section>
        <br>
        <section style="float: left" id="divs">
            <h1><b>Description :</b></h1>
            <p><%=rsOffreDetail.getString("description")%></p>
        </section>
        <br>
        <section id="Details">
            <h1>Details Reservation :</h1>
            <%
                PreparedStatement psVerifyAv = connection.prepareStatement("select * from billets where id_client=? and id_offre=?");
                psVerifyAv.setInt(1,idCurrentuser);
                psVerifyAv.setInt(2,rsOffreDetail.getInt("id_offre"));
                ResultSet rsVerify = psVerifyAv.executeQuery();
                if(!rsVerify.next()){
            %>
                <form id="Form" action="/Billet" method="post">
                    <table>
                        <tr>
                            <td><input type="date" name="DateDepart" id="DateDepart" required></td>
                            <td><input type="number" placeholder="Duration (Days) " min="1"  onchange="onChangeFunction(this.value)" required></td>
                        </tr>
                        <tr>
                            <td><select name="AeroportDepart" required>
                                <option value=""selected hidden>Aeroport Depart</option>
                                <% while(rsListeAeroport.next()){%>
                                <option value="<%=rsListeAeroport.getInt("id_aeroport")%>"><%=rsListeAeroport.getString("nom_aeroport")%></option>
                                <% }%>
                            </select></td>
                            <input  type="text" hidden value="<%=idCurrentuser%>" name="idClient"/>
                            <input  type="text" hidden value="<%=idCurrentOffre%>" name="idOffre"/>
                            <td>
                                <select name="AeroportArrivee" required>
                                    <% if(rsAeroportArrivee.next()){%>
                                    <option selected value="<%=rsAeroportArrivee.getInt("id_aeroport")%>"><%=rsAeroportArrivee.getString("nom_aeroport")%></option>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Total ( DHS ):</td>
                            <td>
                                <input type="text" name="prix" id="total" class="TotalDisplay" value="0"/>
                            </td>
                        </tr>
                        <tr>
                            <td><h2 style="color: red"><%=request.getSession().getAttribute("Message")==null?"":request.getSession().getAttribute("Message")%></h2></td>
                        </tr>
                        <tr>
                            <td colspan="2"><button type="submit" class="BookB">Book</button></td>
                        </tr>
                    </table>
                </form>

        </section>
        <%}else{
                    %>
        <h2 class="message">Already Reserved !</h2>

        <%
                }
                }
            }
        %>
    </div>
</body>
<script>
    function myFunction() {
        var x = document.getElementById("Details");
        if (x.style.display === "none") {
            x.style.display = "block";

        } else {
            x.style.display = "none";
        }


        }
        function onChangeFunction(value){
            var totalPrice =0;

        let total = document.getElementById("total");
        let PrixJournee= document.getElementById("PrixJournee").value;

        totalPrice=PrixJournee * value ;
        total.value=totalPrice;

        }
</script>
<%}else{
    response.sendRedirect("/");
}%>
</html>