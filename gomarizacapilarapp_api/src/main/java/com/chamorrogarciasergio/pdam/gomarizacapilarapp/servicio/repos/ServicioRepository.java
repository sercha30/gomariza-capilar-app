package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.repos;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ServicioRepository extends JpaRepository<Servicio, UUID> {
}
