package com.chamorrogarciasergio.pdam.gomarizacapilarapp.security;

import lombok.*;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class LoginDto {

    private String email;
    private String password;
}
