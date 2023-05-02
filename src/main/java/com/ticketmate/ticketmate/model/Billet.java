package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name="Billets")

public class Billet {
    public Billet(){}
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idBillet;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "AeroportDepart", referencedColumnName = "idAeroport")
    private Aeroport AeroportDepart;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "AeroportArrivee", referencedColumnName = "idAeroport")
    private Aeroport AeroportArrivee;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idClient", referencedColumnName = "idCLient")
    private Client idClient;

    private double prix ;

    private String DateDepart;
    private int Duree;

    public long getIdBillet() {
        return idBillet;
    }

    public void setIdBillet(long idBillet) {
        this.idBillet = idBillet;
    }

    public Aeroport getAeroportDepart() {
        return AeroportDepart;
    }

    public void setAeroportDepart(Aeroport aeroportDepart) {
        AeroportDepart = aeroportDepart;
    }

    public Aeroport getAeroportArrivee() {
        return AeroportArrivee;
    }

    public void setAeroportArrivee(Aeroport aeroportArrivee) {
        AeroportArrivee = aeroportArrivee;
    }

    public Client getIdClient() {
        return idClient;
    }

    public void setIdClient(Client idClient) {
        this.idClient = idClient;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }
}
