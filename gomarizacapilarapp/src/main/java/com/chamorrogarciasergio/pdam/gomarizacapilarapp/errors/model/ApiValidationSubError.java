package com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@SuperBuilder
public class ApiValidationSubError extends ApiSubError{

    private String objeto;
    private String campo;
    private String mensaje;
    private Object valorRechazado;
}
