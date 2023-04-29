package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name="Admins")
public class Admin {
    public Admin(){}

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idAdmin;
    private String Nom;
    private String Identifiant;
    private String Email;
    private String Password;
    private String ProfilePic;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "agence", referencedColumnName = "idAgence")
    private Agence agence;
    public long getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(long idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getNom() {
        return Nom;
    }

    public void setNom(String nom) {
        Nom = nom;
    }

    public String getIdentifiant() {
        return Identifiant;
    }

    public void setIdentifiant(String identifiant) {
        Identifiant = identifiant;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getProfilePic() {
        return ProfilePic;
    }

    public void setProfilePic(String profilePic) {
        ProfilePic = profilePic;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String role) {
        Role = role;
    }

    private String Role;



}
