package com.chamorrogarciasergio.pdam.gomarizacapilarapp.security;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.security.jwt.JwtProvider;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.security.jwt.JwtUserResponse;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.GetPerfilUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.UsuarioDtoConverter;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
@Tag(name = "Authentication", description = "Controlador para autenticación")
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @Operation(summary = "Realiza el login en la app")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Login realizado correctamente"),
            @ApiResponse(responseCode = "404", description = "Usuario no registrado"),
            @ApiResponse(responseCode = "400", description = "Error al realizar el login")
    })
    @PostMapping("/login")
    public ResponseEntity<?> doLogin(@RequestBody LoginDto loginDto) {
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDto.getEmail(),
                                loginDto.getPassword()
                        )
                );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtProvider.generateToken(authentication);

        Usuario usuario = (Usuario) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(
                        convertUserToJwtUserResponse(usuario,jwt)
                );
    }

    @Operation(summary = "Obtiene el usuario logado en la app")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "El usuario se ha encontrado",
                    content = {
                            @Content(mediaType = "application/json",
                            schema = @Schema(implementation = GetPerfilUsuarioDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "Usuario no encontrado"),
            @ApiResponse(responseCode = "400", description = "Error al encontrar al usuario")
    })
    @GetMapping("/me")
    public ResponseEntity<GetPerfilUsuarioDto> identifyUser(@AuthenticationPrincipal Usuario usuario){
        return ResponseEntity.ok((usuarioDtoConverter.convertUsuarioToGetPerfilUsuarioDto(usuario)));
    }

    private JwtUserResponse convertUserToJwtUserResponse(Usuario usuario, String jwt){
        return JwtUserResponse.builder()
                .nombre(usuario.getNombre())
                .apellidos(usuario.getApellidos())
                .email(usuario.getEmail())
                .foto(usuario.getFoto())
                .rol(usuario.getRol().name())
                .token(jwt)
                .build();
    }
}
