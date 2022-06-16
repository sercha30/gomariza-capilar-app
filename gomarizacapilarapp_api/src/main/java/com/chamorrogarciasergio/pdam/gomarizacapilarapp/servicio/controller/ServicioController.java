package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.controller;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto.GetDetailServicioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto.GetListServicioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.service.ServicioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/servicio")
@Tag(name = "Servicio", description = "Controlador para servicios")
public class ServicioController {

    private final ServicioService servicioService;

    @Operation(summary = "Obtiene una lista simplificada de los servicios disponibles")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado los servicios",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetListServicioDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado servicios disponibles"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/serviciosList")
    public ResponseEntity<List<GetListServicioDto>> getAllServiciosList() {
        return ResponseEntity.ok(servicioService.findAllServiciosInList());
    }

    @Operation(summary = "Obtiene el detalle del servicio a través de su ID")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se ha encontrado el servicio",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetDetailServicioDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se ha encontrado el servicio"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/{idServicio}")
    public ResponseEntity<GetDetailServicioDto> getDetailedServicioById(@PathVariable UUID idServicio) {
        return ResponseEntity.ok(servicioService.findDetailedServicio(idServicio));
    }
}
