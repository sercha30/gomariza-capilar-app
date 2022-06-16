package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetDetailedCitaDto {

    private UUID id;
    private String nombreServicio;
    private LocalDateTime de;
    private LocalDateTime a;
    private String apellidosProfesional;
    private String lat;
    private String lng;
    private String nombreCliente;

}
