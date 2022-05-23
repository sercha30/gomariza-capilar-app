package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.service;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.ListEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.general.BaseService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto.GetListServicioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.dto.ServicioDtoConverter;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.repos.ServicioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ServicioService extends BaseService<Servicio, UUID, ServicioRepository> {

    private final ServicioDtoConverter servicioDtoConverter;

    public List<GetListServicioDto> findAllServiciosInList() {
        List<Servicio> servicios = findAll();

        if(servicios.isEmpty()) {
            throw new ListEntityNotFoundException(Servicio.class);
        } else {
            return servicios.stream()
                    .map(servicioDtoConverter::convertServicioToGetListServicioDto)
                    .collect(Collectors.toList());
        }
    }
}
