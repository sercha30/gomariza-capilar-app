package com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.repos;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.model.Localizacion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface LocalizacionRepository extends JpaRepository<Localizacion, UUID> {
}
