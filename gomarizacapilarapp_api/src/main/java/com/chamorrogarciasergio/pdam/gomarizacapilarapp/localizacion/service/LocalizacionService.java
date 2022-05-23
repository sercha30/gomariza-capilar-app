package com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.service;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.general.BaseService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.model.Localizacion;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.repos.LocalizacionRepository;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class LocalizacionService extends BaseService<Localizacion, UUID, LocalizacionRepository> {
}
