package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Offres")
public class Offre {

    public Offre(){}

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
