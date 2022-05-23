package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import org.springframework.stereotype.Component;

@Component
public class ServicioDtoConverter {

    public GetListServicioDto convertServicioToGetListServicioDto(Servicio servicio) {
        return GetListServicioDto.builder()
                .id(servicio.getId())
                .nombre(servicio.getNombre())
                .foto(servicio.getFoto())
                .build();
    }
}
