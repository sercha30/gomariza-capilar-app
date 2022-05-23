package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.service;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto.CitaDtoConverter;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.dto.GetNonDetailedCitaDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.repos.CitaRepository;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.ListEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.general.BaseService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CitaService extends BaseService<Cita, UUID, CitaRepository> {

    private final CitaRepository citaRepository;
    private final CitaDtoConverter citaDtoConverter;

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


    /*
    Un método que devuelva un conjunto de "huecos" disponibles, que no es más que una fecha, una hora de inicio y una de fin

    - Fecha de hoy, coger solo el mes.
    - Recorrer el mes recogiendo todos los huecos posibles de ese mes en base a los parámetros dados.
    - Estos huecos se guardarán en hash map de la forma dia : lista de huecos libres.
    - Recorrer la lista de citas filtrando aquellas que coincidan con el mes actual.
    - Recorrer el hash map de huecos comparando con la lista de citas para eliminar aquellos huecos que coincida
        con alguna de las citas de la lista.

    List<HuecoDisponible> comprobarCalendario() {

     1. Generar los huecos del mes a consultar. Acuérdate de no generar los huecos para fechas pasadas.
        Estos huecos tendrán como duración la duración del servicio que se pase como argumento.
     2. Consultar las citas, con duración, del mes actual (desde el día de hoy, si es el mes actual).
     3. Recorrer la colección de citas, e ir quitando de la colección de huecos, aquellos que coinciden con las citas.
     4. Como resultado, tendremos una colección de los huecos no ocupados del mes actual.
    }
     */



}
