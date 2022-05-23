package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetListServicioDto {

    private UUID id;
    private String nombre;
    private String foto;
}
