package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class GetUsuarioDto {

    private UUID id;
    private String nombre;
    private String foto;
    private String email;
    private String rol;
}
