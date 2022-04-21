package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UsuarioDtoConverter {

    public GetUsuarioDto convertUsuarioToGetUsuarioDto(Usuario usuario) {
        return GetUsuarioDto.builder()
                .id(usuario.getId())
                .nombre(usuario.getNombre())
                .foto(usuario.getFoto())
                .email(usuario.getEmail())
                .rol(usuario.getRol().name())
                .build();
    }

    public GetPerfilUsuarioDto convertUsuarioToGetPerfilUsuarioDto(Usuario usuario) {
        return GetPerfilUsuarioDto.builder()
                .id(usuario.getId())
                .email(usuario.getEmail())
                .foto(usuario.getFoto())
                .rol(usuario.getRol().name())
                .nombre(usuario.getNombre())
                .apellidos(usuario.getApellidos())
                .build();
    }
}
