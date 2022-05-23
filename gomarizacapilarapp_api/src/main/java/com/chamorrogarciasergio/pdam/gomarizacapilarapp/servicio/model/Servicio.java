package com.chamorrogarciasergio.pdam.gomarizacapilarapp.servicio.model;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Servicio implements Serializable {

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

    private String nombre;

    private LocalTime duracion;

    private String precio;

    private String foto;

    @ManyToMany()
    @JoinTable(joinColumns = @JoinColumn(name = "servicio_id",
                            foreignKey = @ForeignKey(name = "FK_ASIGNACION_SERVICIO")),
                inverseJoinColumns = @JoinColumn(name = "usuario_id",
                foreignKey = @ForeignKey(name = "FK_ASIGNACION_PROFESIONAL")),
            name = "asignaciones"
    )
    @Builder.Default
    private List<Usuario> profesionalesAsignados = new ArrayList<>();
}
