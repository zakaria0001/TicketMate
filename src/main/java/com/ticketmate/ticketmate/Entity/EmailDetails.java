package com.ticketmate.ticketmate.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Annotations
@Data
@AllArgsConstructor
@NoArgsConstructor

// Class
public class EmailDetails {
    private String recipient;
    private String msgBody;
    private String subject;
    private String attachment;
}