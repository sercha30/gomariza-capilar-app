package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetListCitaCalendarDto {

    private UUID id;
    private String nombreServicio;
    private LocalDateTime de;
    private LocalDateTime a;
}
