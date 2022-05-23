package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class CreateCitaDto {

    private UUID servicioId;

    private LocalDateTime fechaCita;
}
