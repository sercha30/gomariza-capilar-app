package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetListCitaDto {

    private UUID id;
    private String nombreServicio;
    private String nombreCliente;
    private String fecha;
}
