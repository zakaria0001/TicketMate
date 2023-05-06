package com.ticketmate.ticketmate.model;


import jakarta.persistence.*;

@Entity
@Table(name="Aeroports")
public class Aeroport {
    public Aeroport(){}

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idAeroport ;

    private String NomAeroport;

    private String Adresse;







    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "Ville", referencedColumnName = "idVille")
    private Ville ville;

    public long getIdAeroport() {
        return idAeroport;
    }

    public void setIdAeroport(long idAeroport) {
        this.idAeroport = idAeroport;
    }

    public String getNomAeroport() {
        return NomAeroport;
    }

    public void setNomAeroport(String nomAeroport) {
        NomAeroport = nomAeroport;
    }

    public String getAdresse() {
        return Adresse;
    }

    public void setAdresse(String adresse) {
        Adresse = adresse;
    }

    public Ville getVille() {
        return ville;
    }

    public void setVille(Ville ville) {
        this.ville = ville;
    }
}
