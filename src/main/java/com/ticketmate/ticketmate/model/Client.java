package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;
import org.springframework.web.multipart.MultipartFile;

@Entity

public class Client {
    public Client() {}

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idCLient;

    private String NomClient;
    @Column(nullable = true, length = 64)

    private String email_client ;
    @Column(nullable = true, length = 64)

    private String Password;
    private String Bio;
    private String City;

    public String getCity() {
        return City;
    }

    public void setCity(String city) {
        City = city;
    }

    @Column(nullable = true, length = 64)
    private String photos;

    public String getBio() {
        return Bio;
    }

    public void setBio(String bio) {
        Bio = bio;
    }

    public long getIdCLient() {

        return idCLient;
    }



    public Client setIdCLient(long idCLient) {
        this.idCLient = idCLient;
        return this;
    }

    public String getNomClient() {
        return NomClient;
    }

    public void setNomClient(String nomClient) {
        NomClient = nomClient;
    }

    public String getEmailClient() {
        return email_client;
    }

    public void setEmailClient(String emailClient) {
        email_client = emailClient;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }



    @OneToOne(mappedBy = "idClient")
    private Billet idClient;
}

