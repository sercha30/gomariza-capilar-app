package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.repos;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model.Cita;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CitaRepository extends JpaRepository<Cita, UUID>, JpaSpecificationExecutor<Cita> {

    List<Cita> findFirst2ByFechaCitaAfterAndSolicitadaPorEquals(LocalDateTime fechaActual, Usuario usuario);

    List<Cita> findAllBySolicitadaPorEquals(Usuario usuario);

    Optional<Cita> findByIdEquals(UUID citaId);

    @Query(value = """
                SELECT *
                FROM Cita c
                WHERE (:fecha IS NULL OR c.fecha_cita > CAST(CAST(:fecha AS TEXT) AS TIMESTAMP))
                    AND (:idServicio IS NULL OR c.servicio_id = CAST(CAST(:idServicio AS TEXT) AS UUID))
                    AND (:idCliente IS NULL OR c.solicitante_id = CAST(CAST(:idCliente AS TEXT) AS UUID))
            """, nativeQuery = true)
    Page<Cita> findAllAppointmentsWithFilters(@Param("fecha") LocalDateTime fechaCita,
                                              @Param("idServicio") UUID idServicio,
                                              @Param("idCliente") UUID idCliente,
                                              Pageable pageable);
}
