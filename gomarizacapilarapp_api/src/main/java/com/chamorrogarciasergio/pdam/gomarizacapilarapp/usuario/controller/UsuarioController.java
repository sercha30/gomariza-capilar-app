package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.controller;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.CreateUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.GetUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.UsuarioDtoConverter;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.service.UsuarioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@CrossOrigin
@Tag(name = "Usuario", description = "Controlador para usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @Operation(summary = "Registra un nuevo usuario CLIENTE en la app")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "El usuario se ha registrado correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetUsuarioDto.class))
                    }),
            @ApiResponse(responseCode = "400", description = "Error al registrar el usuario")
    })
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

    @Operation(summary = "Registra un nuevo usuario EMPLEADO en la app")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "El usuario se ha registrado correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetUsuarioDto.class))
                    }),
            @ApiResponse(responseCode = "400", description = "Error al registrar el usuario")
    })
    @PostMapping("auth/register/empleado")
    public ResponseEntity<GetUsuarioDto> nuevoEmpleado(@RequestPart("usuario")CreateUsuarioDto createUsuarioDto,
                                                      @RequestPart("foto")MultipartFile multipartFile) throws Exception {
        Usuario guardado = usuarioService.saveEmpleado(createUsuarioDto, multipartFile);

        if(guardado == null) {
            return ResponseEntity.badRequest().build();
        } else {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(usuarioDtoConverter.convertUsuarioToGetUsuarioDto(guardado));
        }
    }

    @Operation(summary = "Registra un nuevo usuario ADMINISTRADOR en la app")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "El usuario se ha registrado correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetUsuarioDto.class))
                    }),
            @ApiResponse(responseCode = "400", description = "Error al registrar el usuario")
    })
    @PostMapping("auth/register/admin")
    public ResponseEntity<GetUsuarioDto> nuevoAdmin(@RequestPart("usuario")CreateUsuarioDto createUsuarioDto,
                                                      @RequestPart("foto")MultipartFile multipartFile) throws Exception {
        Usuario guardado = usuarioService.saveAdmin(createUsuarioDto, multipartFile);

        if(guardado == null) {
            return ResponseEntity.badRequest().build();
        } else {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(usuarioDtoConverter.convertUsuarioToGetUsuarioDto(guardado));
        }
    }
}
