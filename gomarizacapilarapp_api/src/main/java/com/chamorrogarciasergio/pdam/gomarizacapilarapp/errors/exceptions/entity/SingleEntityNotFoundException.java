package com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity;

public class SingleEntityNotFoundException extends EntityNotFoundException{

    public SingleEntityNotFoundException(Class clazz) {
        super(String.format("No se pueden encontrar la entidad del tipo %s ", clazz.getName()));
    }
}
