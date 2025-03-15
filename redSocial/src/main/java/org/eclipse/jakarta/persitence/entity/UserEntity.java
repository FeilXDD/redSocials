package org.eclipse.jakarta.persitence.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "Usuarios")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usuario_id", nullable = false)
    private Integer usuario_id;

    @Column(nullable = false)
    private Integer empresa_id;

    @Column(nullable = false)
    private String nombre;

    @Column(nullable = false)
    private String apellido;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String contrasena_hash;

    @Column(nullable = false)
    private String rol;

    @Column(nullable = false, columnDefinition = "DATETIME")
    private LocalDateTime fecha_registro;

    public UserEntity(Integer usuario_id, Integer empresa_id, String nombre, String apellido, String email, String contrasena_hash, String rol, LocalDateTime fecha_registro) {
        this.usuario_id = usuario_id;
        this.empresa_id = empresa_id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contrasena_hash = contrasena_hash;
        this.rol = rol;
        this.fecha_registro = fecha_registro;
    }

    public UserEntity() {
    }

    public Integer getUsuario_id() {
        return usuario_id;
    }

    public void setUsuario_id(Integer usuario_id) {
        this.usuario_id = usuario_id;
    }

    public Integer getEmpresa_id() {
        return empresa_id;
    }

    public void setEmpresa_id(Integer empresa_id) {
        this.empresa_id = empresa_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContrasena_hash() {
        return contrasena_hash;
    }

    public void setContrasena_hash(String contrasena_hash) {
        this.contrasena_hash = contrasena_hash;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public LocalDateTime getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(LocalDateTime fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof UserEntity that)) return false;
        return Objects.equals(getUsuario_id(), that.getUsuario_id()) && Objects.equals(getEmpresa_id(), that.getEmpresa_id()) && Objects.equals(getNombre(), that.getNombre()) && Objects.equals(getApellido(), that.getApellido()) && Objects.equals(getEmail(), that.getEmail()) && Objects.equals(getContrasena_hash(), that.getContrasena_hash()) && Objects.equals(getRol(), that.getRol()) && Objects.equals(getFecha_registro(), that.getFecha_registro());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getUsuario_id(), getEmpresa_id(), getNombre(), getApellido(), getEmail(), getContrasena_hash(), getRol(), getFecha_registro());
    }
}
