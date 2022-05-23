package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetNonDetailedCitaDto {

    private UUID id;
    private String nombreProfesional;
    private String apellidosProfesional;
    private String nombreServicio;
    private String fotoProfesional;
    private LocalDateTime fechaCita;
    private LocalTime duracion;
}
