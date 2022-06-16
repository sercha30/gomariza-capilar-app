package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Hueco;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@Component
public class CitaDtoConverter {

    public GetNonDetailedCitaDto convertCitaToGetNonDetailedCitaDto(Cita cita) {
        return GetNonDetailedCitaDto.builder()
                .id(cita.getId())
                .nombreProfesional(cita.getServicio().getProfesionalesAsignados().get(0).getNombre())
                .apellidosProfesional(cita.getServicio().getProfesionalesAsignados().get(0).getApellidos())
                .nombreServicio(cita.getServicio().getNombre())
                .fotoProfesional(cita.getServicio().getProfesionalesAsignados().get(0).getFoto())
                .fechaCita(cita.getFechaCita())
                .duracion(cita.getServicio().getDuracion())
                .build();
    }

    public GetListCitaCalendarDto convertCitaToGetListCitaCalendarDto(Cita cita) {
        return GetListCitaCalendarDto.builder()
                .id(cita.getId())
                .nombreServicio(cita.getServicio().getNombre())
                .de(cita.getFechaCita())
                .a(cita.getFechaCita().plus(cita.getServicio().getDuracion().toSecondOfDay(), ChronoUnit.SECONDS))
                .build();
    }

    public GetDetailedCitaDto convertCitaToGetDetailedCitaDto(Cita cita) {
        return GetDetailedCitaDto.builder()
                .id(cita.getId())
                .de(cita.getFechaCita())
                .a(cita.getFechaCita()
                        .plus(cita.getServicio()
                                .getDuracion()
                                .toSecondOfDay(),
                                ChronoUnit.SECONDS))
                .nombreServicio(cita.getServicio().getNombre())
                .apellidosProfesional(cita.getServicio().getProfesionalesAsignados().get(0).getApellidos())
                .lat(cita.getLocalizacion().getLat())
                .lng(cita.getLocalizacion().getLng())
                .nombreCliente(cita.getSolicitadaPor().getNombre() + cita.getSolicitadaPor().getApellidos())
                .build();
    }

    public GetListCitaDto convertCitaToGetListCitaDto(Cita cita) {
        return GetListCitaDto.builder()
                .id(cita.getId())
                .nombreServicio(cita.getServicio().getNombre())
                .nombreCliente(cita.getSolicitadaPor().getNombre() + cita.getSolicitadaPor().getApellidos())
                .fecha(cita.getFechaCita().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")))
                .build();
    }

    public Hueco convertCitaToHueco(Cita cita) {
        return Hueco.builder()
                .fecha(cita.getFechaCita().toLocalDate())
                .horaInicio(cita.getFechaCita().toLocalTime())
                .horaFin(cita.getFechaCita()
                        .toLocalTime()
                        .plus(cita.getServicio()
                                .getDuracion()
                                .toSecondOfDay(),
                                ChronoUnit.SECONDS))
                .build();
    }
}
