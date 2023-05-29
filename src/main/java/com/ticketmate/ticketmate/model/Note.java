package com.ticketmate.ticketmate.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Notes")

public class Note {
    public Note() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idNote;


    private String Contenu;

    private String DateNote;

    public long getIdNote() {
        return idNote;
    }

    public void setIdNote(long idNote) {
        this.idNote = idNote;
    }

    public String getContenu() {
        return Contenu;
    }

    public void setContenu(String contenu) {
        Contenu = contenu;
    }

    public String getDateNote() {
        return DateNote;
    }

    public void setDateNote(String dateNote) {
        DateNote = dateNote;
    }


    private String idClientN;

    public String getIdClientN() {
        return idClientN;
    }

    public void setIdClientN(String idClientN) {
        this.idClientN = idClientN;
    }
}