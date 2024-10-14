package org.example.domain.entities;

import jakarta.persistence.*;
import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tags")
@Data
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;


    @ManyToMany(mappedBy = "tags", fetch = FetchType.LAZY)
    private Set<Task> tasks = new HashSet<>();
}
