package org.example.services.manager;

import at.favre.lib.crypto.bcrypt.BCrypt;
import org.example.exceptions.UserNotFoundException;
import org.example.domain.entities.Token;
import org.example.domain.entities.User;
import org.example.domain.enums.UserRole;
import org.example.repository.interfaces.TokenRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.validation.UserValidator;

import java.time.LocalDateTime;
import java.util.List;


public class ManagerService{

    private final UserRepository userRepository;
    private final UserValidator userValidator;
    private TokenRepository tokenRepository;

    public ManagerService(UserRepository userRepository, UserValidator userValidator , TokenRepository tokenRepository) {
        this.userRepository = userRepository;
        this.userValidator = userValidator;
        this.tokenRepository = tokenRepository;
    }

    public void saveUser(String username, String email, String password, String role, String filName) {
        userValidator.validateUsername(username);
        userValidator.validateEmail(email);
        userValidator.validatePassword(password);

        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(UserRole.valueOf(role));
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        user.setProfile(filName);

        userRepository.save(user);
        Token token = new Token(user, 2, 1);
        tokenRepository.save(token);
    }

    public void updateUser(Long id, String username, String email) {
        User user = userRepository.findById(id);
        if (user == null) {
            throw new UserNotFoundException("User with id " + id + " not found");
        }

        userValidator.validateUsername(username);
        userValidator.validateEmail(email);

        user.setUsername(username);
        user.setEmail(email);
        userRepository.update(user);
    }

    public void deleteUser(Long id) {
        User user = userRepository.findById(id);
        if (user == null) {
            throw new UserNotFoundException("User with id " + id + " not found");
        }
        userRepository.delete(user.getId());
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getLastUsers() {
        return userRepository.findLastFoor();
    }


}
