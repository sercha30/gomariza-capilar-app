package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.service;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto.*;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Hueco;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.repos.CitaRepository;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.ListEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.SingleEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.general.BaseService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.model.Localizacion;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.service.LocalizacionService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.service.ServicioService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CitaService extends BaseService<Cita, UUID, CitaRepository> {

    private final CitaRepository citaRepository;
    private final CitaDtoConverter citaDtoConverter;
    private final ServicioService servicioService;
    private final LocalizacionService localizacionService;

    @Value("${business.hour.opening}")
    private int openingTime;

    @Value("${business.hour.closure}")
    private int closingTime;

    public List<GetNonDetailedCitaDto> findNextTwoAppointments(Usuario usuario) {
        List<Cita> citas = citaRepository.findFirst2ByFechaCitaAfterAndSolicitadaPorEquals(
                LocalDateTime.now(), usuario);

        if(citas.isEmpty()) {
            throw new ListEntityNotFoundException(Cita.class);
        } else {
            return citas.stream()
                    .map(citaDtoConverter::convertCitaToGetNonDetailedCitaDto)
                    .collect(Collectors.toList());
        }
    }

    public List<GetListCitaCalendarDto> findAllAppointmentsFromUsuario(Usuario usuario) {
        List<Cita> citas = citaRepository.findAllBySolicitadaPorEquals(usuario);

        if(citas.isEmpty()) {
            throw new ListEntityNotFoundException(Cita.class);
        } else {
            return citas.stream()
                    .map(citaDtoConverter::convertCitaToGetListCitaCalendarDto)
                    .collect(Collectors.toList());
        }
    }

    public GetDetailedCitaDto findCitaById(UUID citaId) {
        Optional<Cita> citaOptional = citaRepository.findByIdEquals(citaId);

        if(citaOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(Cita.class);
        } else {
            return citaDtoConverter.convertCitaToGetDetailedCitaDto(citaOptional.get());
        }
    }

    public GetDetailedCitaDto editCita(UUID citaId, EditCitaDto editCitaDto) {
        Optional<Cita> citaOptional = citaRepository.findByIdEquals(citaId);
        Optional<Servicio> servicioOptional = servicioService.findById(UUID.fromString(editCitaDto.getIdServicio()));

        if(citaOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(Cita.class);
        } else if (servicioOptional.isEmpty()) {
            throw new SingleEntityNotFoundException((Servicio.class));
        } else {
            Cita cita = citaOptional.get();
            Servicio servicio = servicioOptional.get();

            cita.setServicio(servicio);
            edit(cita);

            return citaDtoConverter.convertCitaToGetDetailedCitaDto(cita);
        }
    }

    public void deleteCita(UUID citaId) {
        Optional<Cita> citaOptional = citaRepository.findByIdEquals(citaId);

        if(citaOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(Cita.class);
        } else {
            delete(citaOptional.get());
        }
    }

    public List<GetListCitaDto> findAllList() {
        List<Cita> citas = citaRepository.findAll();

        if(citas.isEmpty()) {
            throw new ListEntityNotFoundException(Cita.class);
        } else {
            return citas.stream()
                    .map(citaDtoConverter::convertCitaToGetListCitaDto)
                    .collect(Collectors.toList());
        }
    }

    public HashMap<Integer,List<Hueco>> comprobarCalendario(UUID idServicio, int monthNumber) {
        Optional<Servicio> servicioOptional = servicioService.findById(idServicio);

        if(servicioOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(Servicio.class);
        } else {
            Servicio servicio = servicioOptional.get();
            LocalDateTime hoy = LocalDateTime.now();
            Month mesActual = Month.of(monthNumber);
            List<Hueco> huecosMes = new ArrayList<>();
            List<Hueco> huecosLibres = new ArrayList<>();
            HashMap<Integer,List<Hueco>> huecos = new HashMap<>();

            for(int day = 1;  day <= mesActual.length(hoy.toLocalDate().isLeapYear()); day++) {
                for(int hour = openingTime;
                    hour < closingTime;
                    hour += servicio.getDuracion().getHour()) {
                    huecosMes.add(Hueco.builder()
                            .fecha(LocalDate.of(hoy.getYear(), mesActual, day))
                            .horaInicio(LocalTime.of(hour, 0))
                            .horaFin(LocalTime.of(hour + servicio.getDuracion().getHour(), 0))
                            .build());
                }
                huecos.put(day, huecosMes);
                huecosMes = new ArrayList<>();
            }

            List<Hueco> citasMes = findAll().stream()
                    .filter(cita -> cita.getFechaCita()
                            .getMonth()
                            .equals(mesActual))
                    .map(citaDtoConverter::convertCitaToHueco)
                    .toList();

            for(int day = 1; day <= mesActual.length(hoy.toLocalDate().isLeapYear()); day++) {
                for(Hueco cita : citasMes) {
                    huecosLibres.addAll(huecos.get(day)
                            .stream()
                            .filter(hueco -> {
                                if(hueco.getFecha().equals(cita.getFecha())) {
                                    return !hueco.getHoraInicio().equals(cita.getHoraInicio());
                                } else {
                                    return true;
                                }
                            })
                            .filter(hueco -> {
                                if(hueco.getFecha().equals(cita.getFecha())) {
                                    return !hueco.getHoraFin().equals(cita.getHoraFin());
                                } else {
                                    return true;
                                }
                            })
                            .toList());

                    huecos.put(day, huecosLibres);
                    huecosLibres = new ArrayList<>();
                }
            }

            if(huecos.values().isEmpty()) {
                throw new ListEntityNotFoundException(Cita.class);
            } else {
                return huecos;
            }
        }
    }

    public void createCita(CreateCitaDto createCitaDto, Usuario usuario) {
        Optional<Servicio> servicioOptional = servicioService.findById(createCitaDto.getServicioId());
        List<Localizacion> localizaciones = localizacionService.findAll();

        if(servicioOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(Servicio.class);
        } else {
            Cita cita = Cita.builder()
                    .fechaCita(createCitaDto.getFechaCita())
                    .servicio(servicioOptional.get())
                    .localizacion(localizaciones.get(0))
                    .solicitadaPor(usuario)
                    .build();

            save(cita);
        }
    }

    @PreAuthorize("hasRole('EMPLEADO') or hasRole('ADMIN')")
    public Page<GetListCitaDto> findAllFiltered(LocalDateTime fechaCita,
                                                UUID idServicio,
                                                UUID idCliente,
                                                PageRequest pageRequest) {
        Page<Cita> citas = citaRepository.findAllAppointmentsWithFilters(
                                                fechaCita,
                                                idServicio,
                                                idCliente,
                                                pageRequest);
        if(citas.isEmpty()) {
            throw new ListEntityNotFoundException(Cita.class);
        } else {
            return citas.map(citaDtoConverter::convertCitaToGetListCitaDto);
        }
    }
}
