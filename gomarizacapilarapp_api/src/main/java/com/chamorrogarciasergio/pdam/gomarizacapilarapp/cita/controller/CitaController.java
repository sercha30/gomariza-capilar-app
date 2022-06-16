package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.controller;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto.*;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Hueco;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.service.CitaService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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

    @Operation(summary = "Obtiene las citas del usuario logado en formato calendario")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado las citas",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetListCitaCalendarDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado citas"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/allAppointmentsCalendar")
    public ResponseEntity<List<GetListCitaCalendarDto>> getAllAppointmentsFromUsuario(
            @AuthenticationPrincipal Usuario usuario) {
        return ResponseEntity.ok(citaService.findAllAppointmentsFromUsuario(usuario));
    }

    @Operation(summary = "Obtiene el detalle de la cita con el ID indicado")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se ha encontrado la cita",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetDetailedCitaDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se ha encontrado la cita"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/citaDetail/{citaId}")
    public ResponseEntity<GetDetailedCitaDto> getDetailedCitaById(@PathVariable UUID citaId) {
        return ResponseEntity.ok(citaService.findCitaById(citaId));
    }

    @Operation(summary = "Edita la cita con el ID indicado")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "Se ha editado la cita correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetDetailedCitaDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se ha encontrado la cita / servicio"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @PutMapping("/editCita/{citaId}")
    public ResponseEntity<GetDetailedCitaDto> editCita(@PathVariable UUID citaId, @RequestBody EditCitaDto editCitaDto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(citaService.editCita(citaId, editCitaDto));
    }

    @Operation(summary = "Elimina la cita con el ID indicado")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "204",
                    description = "Se ha eliminado la cita correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetDetailedCitaDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se ha encontrado la cita"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @DeleteMapping("/deleteCita/{citaId}")
    public ResponseEntity<?> deleteCita(@PathVariable UUID citaId) {
        citaService.deleteCita(citaId);
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Obtiene todas las citas registradas")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado las citas",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetListCitaCalendarDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado citas"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/allAppointments")
    public ResponseEntity<List<GetListCitaDto>> findAllList() {
        return ResponseEntity.ok(citaService.findAllList());
    }

    @Operation(summary = "Obtiene todas las citas disponibles del mes actual")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado citas disponibles",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = HashMap.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado citas disponibles"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/freeAppointmentsCalendar")
    public ResponseEntity<HashMap<Integer,List<Hueco>>> getFreeAppointmentsCalendar(
            @RequestParam UUID idServicio, @RequestParam int monthNumber) {
        return ResponseEntity.ok(citaService.comprobarCalendario(idServicio, monthNumber));
    }

    @Operation(summary = "Crea una nueva cita")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "Se ha creado la cita correctamente",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema())
                    }),
            @ApiResponse(responseCode = "404", description = "No se ha encontrado el servicio solicitado"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @PostMapping("/newAppointment")
    public ResponseEntity<?> createCita(@RequestBody CreateCitaDto createCitaDto,
                                        @AuthenticationPrincipal Usuario usuario) {
        citaService.createCita(createCitaDto, usuario);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @Operation(summary = "Obtiene todas las citas registradas paginadas con filtros")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Se han encontrado las citas",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GetListCitaDto.class))
                    }),
            @ApiResponse(responseCode = "404", description = "No se han encontrado citas"),
            @ApiResponse(responseCode = "400", description = "Se ha producido un error inesperado")
    })
    @GetMapping("/allAppointmentsPaged")
    public ResponseEntity<Page<GetListCitaDto>> getAllAppointmentsPaged(
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
            @RequestParam(required = false) LocalDateTime fechaCita,
            @RequestParam(required = false) UUID idServicio,
            @RequestParam(required = false) UUID idCliente,
            @RequestParam(defaultValue = "0") int pageNum,
            @RequestParam(defaultValue = "5") int pageSize) {
        final Page<GetListCitaDto> pagedCitas = citaService.findAllFiltered(fechaCita,
                idServicio,
                idCliente,
                PageRequest.of(pageNum, pageSize));
        return ResponseEntity.ok(pagedCitas);
    }
}
