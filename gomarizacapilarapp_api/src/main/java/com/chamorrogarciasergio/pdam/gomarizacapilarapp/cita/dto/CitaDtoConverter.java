package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import org.springframework.stereotype.Component;

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
}
