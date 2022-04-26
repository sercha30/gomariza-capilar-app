package com.chamorrogarciasergio.pdam.gomarizacapilarapp.security.jwt;

import lombok.*;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class JwtUserResponse {

    private String nombre;
    private String apellidos;
    private String email;
    private String foto;
    private String rol;
    private String token;
}
