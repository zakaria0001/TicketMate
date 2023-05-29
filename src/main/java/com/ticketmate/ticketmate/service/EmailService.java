// Java Program to Illustrate Creation Of
// Service Interface

package com.ticketmate.ticketmate.service;

import com.ticketmate.ticketmate.Entity.EmailDetails;


public interface EmailService {

    String sendSimpleMail(String recipient,String Username);

}
