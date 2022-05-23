package com.chamorrogarciasergio.pdam.gomarizacapilarapp;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
@PropertySource("classpath:application.properties")
@OpenAPIDefinition(info = @Info(description = "API para la app GomarizaCapilar App",
		version = "1.0",
		contact = @Contact(email = "chamorro.gaser21@triana.salesianos.edu", name = "Sergio Chamorro García"),
		license = @License(name = "Creative Commons Zero v1.0 Universal"),
		title = "GomarizaCapilar App API")
)
public class GomarizaCapilarAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(GomarizaCapilarAppApplication.class, args);
	}

}
