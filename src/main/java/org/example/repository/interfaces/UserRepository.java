package org.example.repository.interfaces;

import org.example.domain.entities.User;
import org.example.domain.enums.UserRole;

import java.util.List;

public interface UserRepository {
    User save(User user);

    List<User> findAll();

    User findById(Long id);

    void update(User user);

    void delete(Long id);

    List<User> findLastFoor();

    User findByEmail(String email);

    List<User> findByRole(UserRole role);
}
