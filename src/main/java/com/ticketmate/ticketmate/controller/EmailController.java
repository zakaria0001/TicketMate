// Java Program to Create Rest Controller that
// Defines various API for Sending Mail

package com.ticketmate.ticketmate.controller;

// Importing required classes
import com.ticketmate.ticketmate.Entity.EmailDetails;
import com.ticketmate.ticketmate.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

// Annotation
@RestController
// Class
public class EmailController {

    @Autowired private EmailService emailService;

    // Sending a simple Email
    @PostMapping("/sendMail")
    public String sendMail(@RequestBody String recipient,String Username )
    {
        String status = emailService.sendSimpleMail(recipient,Username);

        return status;
    }


}
