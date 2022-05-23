package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class CreateUsuarioDto {

    private String nombre;
    private String apellidos;
    private String email;
    private String password;
    private String password2;
    private String fechaNacimiento;
}
