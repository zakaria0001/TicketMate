package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Agences")

public class Agence {
    public Agence(){}

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idAgence;

    @OneToOne(mappedBy = "agence")
    private Admin agence;

    @OneToOne(mappedBy = "idAgense")
    private Offre idAgense;
    private String NomAgence;

    private String AdresseAgence;

    public long getIdAgence() {
        return idAgence;
    }

    public void setIdAgence(long idAgence) {
        this.idAgence = idAgence;
    }

    public String getNomAgence() {
        return NomAgence;
    }

    public void setNomAgence(String nomAgence) {
        NomAgence = nomAgence;
    }

    public String getAdresseAgence() {
        return AdresseAgence;
    }

    public void setAdresseAgence(String adresseAgence) {
        AdresseAgence = adresseAgence;
    }
}
