package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.repos;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public interface CitaRepository extends JpaRepository<Cita, UUID> {

    List<Cita> findFirst2ByFechaCitaAfterAndSolicitadaPorEquals(LocalDateTime fechaActual, Usuario usuario);
}
