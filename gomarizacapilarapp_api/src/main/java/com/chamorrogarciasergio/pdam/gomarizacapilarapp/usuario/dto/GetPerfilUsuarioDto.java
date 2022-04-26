package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class GetPerfilUsuarioDto {

    private UUID id;
    private String nombre;
    private String apellidos;
    private String email;
    private String foto;
    private String rol;
}
