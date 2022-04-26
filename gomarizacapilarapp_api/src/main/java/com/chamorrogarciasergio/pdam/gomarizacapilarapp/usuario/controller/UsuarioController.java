package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.controller;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.CreateUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.GetUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.UsuarioDtoConverter;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @PostMapping("auth/register/cliente")
    public ResponseEntity<GetUsuarioDto> nuevoCliente(@RequestPart("usuario")CreateUsuarioDto createUsuarioDto,
                                                      @RequestPart("foto")MultipartFile multipartFile) throws Exception {
        Usuario guardado = usuarioService.saveCliente(createUsuarioDto, multipartFile);

        if(guardado == null) {
            return ResponseEntity.badRequest().build();
        } else {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(usuarioDtoConverter.convertUsuarioToGetUsuarioDto(guardado));
        }
    }
}
