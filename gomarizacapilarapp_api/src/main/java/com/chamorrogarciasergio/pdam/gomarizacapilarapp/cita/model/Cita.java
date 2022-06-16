package com.chamorrogarciasergio.pdam.gomarizacapilarapp.cita.model;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.localizacion.model.Localizacion;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model.Servicio;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Cita implements Serializable {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    private UUID id;

    @ManyToOne()
    @JoinColumn(name = "localizacion_id", foreignKey = @ForeignKey(name = "FK_CITA_LOCALIZACION"))
    private Localizacion localizacion;

    @ManyToOne
    @JoinColumn(name = "servicio_id", foreignKey = @ForeignKey(name = "FK_CITA_SERVICIO"))
    private Servicio servicio;

    private LocalDateTime fechaCita;

    @CreatedDate
    private LocalDateTime fechaSolicitada;

    @ManyToOne
    @JoinColumn(name = "solicitante_id", foreignKey = @ForeignKey(name = "FK_CITA_SOLICITANTE"))
    private Usuario solicitadaPor;

    private boolean isModificada;

    @LastModifiedDate
    private LocalDateTime fechaModificacion;
}
