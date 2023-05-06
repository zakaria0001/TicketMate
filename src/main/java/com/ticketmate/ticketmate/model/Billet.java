package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name="Billets")

public class Billet {
    public Billet(){}
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idBillet;

    @JoinColumn(name = "AeroportDepart", referencedColumnName = "idAeroport")
    private String AeroportDepart;

    @JoinColumn(name = "AeroportArrivee", referencedColumnName = "idAeroport")
    private String AeroportArrivee;

    @JoinColumn(name = "idClient", referencedColumnName = "idCLient")
    private int idClient;

    @JoinColumn(name = "idOffre", referencedColumnName = "idOffre")
    private int idOffre;

    public int getIdOffre() {
        return idOffre;
    }

    public void setIdOffre(int idOffre) {
        this.idOffre = idOffre;
    }

    private double prix ;

    private String DateDepart;
    private int Duree;

    public void setAeroportDepart(String aeroportDepart) {
        AeroportDepart = aeroportDepart;
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        AeroportArrivee = aeroportArrivee;
    }

    public String getDateDepart() {
        return DateDepart;
    }

    public void setDateDepart(String dateDepart) {
        DateDepart = dateDepart;
    }

    public int getDuree() {
        return Duree;
    }

    public void setDuree(int duree) {
        Duree = duree;
    }

    public long getIdBillet() {
        return idBillet;
    }

    public void setIdBillet(long idBillet) {
        this.idBillet = idBillet;
    }


    public String getAeroportDepart() {
        return AeroportDepart;
    }

    public String getAeroportArrivee() {
        return AeroportArrivee;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }
}
