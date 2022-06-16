package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;

@Component
public class ServicioDtoConverter {

    public GetListServicioDto convertServicioToGetListServicioDto(Servicio servicio) {
        return GetListServicioDto.builder()
                .id(servicio.getId())
                .nombre(servicio.getNombre())
                .foto(servicio.getFoto())
                .build();
    }

    public GetDetailServicioDto convertServicioToGetDetailServicioDto(Servicio servicio) {
        return GetDetailServicioDto.builder()
                .id(servicio.getId())
                .nombre(servicio.getNombre())
                .foto(servicio.getFoto())
                .descripcion(servicio.getDescripcion())
                .nombreProfesional(servicio.getProfesionalesAsignados().get(0).getApellidos())
                .duracion(servicio.getDuracion().format(DateTimeFormatter.ofPattern("h:mm")))
                .precio(servicio.getPrecio())
                .build();
    }
}
