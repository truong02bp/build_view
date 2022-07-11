package com.example.data.entities;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "users")
@Getter
@Setter
public class User extends BaseEntity {

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "name")
    private String name;

    @Column(name = "username")
    private String username;

    @ManyToOne
    @JoinColumn(name = "media_id")
    @Schema(hidden = true)
    private Media avatar;

    private String address;

    @Column(name = "phone", unique = true)
    private String phone;

}
