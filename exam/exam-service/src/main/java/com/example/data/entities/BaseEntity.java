package com.example.data.entities;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@MappedSuperclass
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreationTimestamp
    @Column(name = "created_date", columnDefinition = "timestamp with time zone")
    @Schema(hidden = true)
    private LocalDateTime createdDate;

    @UpdateTimestamp
    @Column(name = "updated_date", columnDefinition = "timestamp with time zone")
    @Schema(hidden = true)
    private LocalDateTime updatedDate;
}
