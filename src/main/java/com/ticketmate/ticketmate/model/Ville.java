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


    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idVille;

    private String Designation;

    @Lob
    @Column (name = "image")
    private byte[] image;


    @OneToOne(mappedBy = "VilleOffre")
    private Offre VilleOffre;



}
