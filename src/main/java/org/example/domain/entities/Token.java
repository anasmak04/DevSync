package org.example.domain.entities;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "tokens")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "modify_token_count", nullable = false)
    private int modifyTokenCount;

    @Column(name = "delete_token_count", nullable = false)
    private int deleteTokenCount;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Token(User user, int modifyTokenCount, int deleteTokenCount) {
        this.user = user;
        this.modifyTokenCount = modifyTokenCount;
        this.deleteTokenCount = deleteTokenCount;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public Token(User user) {
        this(user, 2, 1);
    }

    public Token(User user,int modifyTokenCount, int deleteTokenCount, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.user = user;
        this.modifyTokenCount = modifyTokenCount;
        this.deleteTokenCount = deleteTokenCount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Token{" +
                "id=" + id +
                // Exclude user to prevent circular reference
                ", modifyTokenCount=" + modifyTokenCount +
                ", deleteTokenCount=" + deleteTokenCount +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
