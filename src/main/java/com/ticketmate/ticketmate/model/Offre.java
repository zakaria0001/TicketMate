package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Offres")
public class Offre {

    public Offre(){}

    public long getIdOffre() {
        return idOffre;
    }

    public void setIdOffre(long idOffre) {
        this.idOffre = idOffre;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public Ville getVilleOffre() {
        return VilleOffre;
    }

    public void setVilleOffre(Ville villeOffre) {
        VilleOffre = villeOffre;
    }

    public Agence getIdAgense() {
        return idAgense;
    }

    public void setIdAgense(Agence idAgense) {
        this.idAgense = idAgense;
    }

    public int getPrixOffre() {
        return PrixOffre;
    }

    public void setPrixOffre(int prixOffre) {
        PrixOffre = prixOffre;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idOffre;


    private String Description;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "VilleOffre", referencedColumnName = "idVille")
    private Ville VilleOffre;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idAgense", referencedColumnName = "idAgence")
    private Agence idAgense;


    private int PrixOffre;

}
