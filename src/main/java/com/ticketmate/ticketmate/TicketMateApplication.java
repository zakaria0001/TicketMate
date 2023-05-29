package com.ticketmate.ticketmate;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@EntityScan(basePackages = {"com.ticketmate.ticketmate.model"})
@ComponentScan(basePackages = {"com.ticketmate.ticketmate.*"})
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })

public class TicketMateApplication {

    public static void main(String[] args) {
        SpringApplication.run(TicketMateApplication.class, args);
    }

}
