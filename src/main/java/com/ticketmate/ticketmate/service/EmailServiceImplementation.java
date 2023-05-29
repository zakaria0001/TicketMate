// Java Program to Illustrate Creation Of
// Service implementation class

package com.ticketmate.ticketmate.service;

// Importing required classes
import com.ticketmate.ticketmate.Entity.EmailDetails;
import java.io.File;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

// Annotation
@Service
// Class
// Implementing EmailService interface
public class EmailServiceImplementation implements EmailService {

    @Autowired private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}") private String sender;

    public String sendSimpleMail(String recipient,String Username)
    {
        try {

            SimpleMailMessage mailMessage
                    = new SimpleMailMessage();

            mailMessage.setFrom(sender);
            mailMessage.setTo(recipient);
            mailMessage.setSubject("Welcome To TicketMate");
            mailMessage.setText("Hi "+Username+" , Welcome to TicketMate . We're thrilled to see you here! We're confident that TicketMate will help you Choose Your Next Vacation Destination .");


            javaMailSender.send(mailMessage);
            System.out.println("Mail Sent Successfully...");
            return "Mail Sent Successfully...";
        }

        catch (Exception e) {
            System.out.println("Error while Sending Mail");
            return "Error while Sending Mail";
        }
    }









}

