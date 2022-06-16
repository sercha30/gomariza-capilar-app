package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto;

import lombok.*;

import javax.persistence.Lob;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetDetailServicioDto {

    private UUID id;

    private String nombre;

    private String foto;

    @Lob
    private String descripcion;

    private String nombreProfesional;

    private String duracion;

    private String precio;
}
