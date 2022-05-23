package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.controller;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto.GetNonDetailedCitaDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.service.CitaService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/cita")
@Tag(name = "Citas", description = "Controlador para citas")
public class CitaController {

    private final CitaService citaService;

    @Operation(summary = "Obtiene las próximas dos citas del usuario logado")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado las citas",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetNonDetailedCitaDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado próximas citas"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/nextAppointments")
    public ResponseEntity<List<GetNonDetailedCitaDto>> getNextTwoAppointments(
            @AuthenticationPrincipal Usuario usuario) {
        return ResponseEntity.ok(citaService.findNextTwoAppointments(usuario));
    }
}
