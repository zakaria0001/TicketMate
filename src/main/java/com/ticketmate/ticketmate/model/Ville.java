package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Villes")

public class Ville {

    public Ville(){}

    public String getDesignation() {
        return Designation;
    }

    public void setDesignation(String designation) {
        Designation = designation;
    }

    public String getPhotoVille() {
        return PhotoVille;
    }

    public void setPhotoVille(String photoVille) {
        PhotoVille = photoVille;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idVille;

    private String Designation;

    @Column(nullable = true, length = 64)
    private String PhotoVille;


    @OneToOne(mappedBy = "VilleOffre")
    private Offre VilleOffre;



}
