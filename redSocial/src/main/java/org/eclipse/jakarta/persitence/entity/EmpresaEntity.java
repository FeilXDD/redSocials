package org.eclipse.jakarta.persitence.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "Empresas")
public class EmpresaEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "empresa_id", nullable = false)
    private Integer empresa_id;

    @Column(nullable = false)
    private String nombre;

    @Column(nullable = false)
    private String industria;

    @Column(nullable = false, columnDefinition = "DATETIME")
    private LocalDateTime fecha_fundacion;

    @Column(nullable = false)
    private String direccion;

    @Column(nullable = false)
    private String sitio_web;

    @Column(nullable = false, length = 20)
    private String telefono;

    @Column(nullable = false, unique = true)
    private String email;
}
