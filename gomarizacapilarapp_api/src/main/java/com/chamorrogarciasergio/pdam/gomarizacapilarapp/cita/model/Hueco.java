package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Hueco implements Serializable {

    private LocalDate fecha;
    private LocalTime horaInicio;
    private LocalTime horaFin;
}
