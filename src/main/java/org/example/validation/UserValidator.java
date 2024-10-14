package org.example.validation;

import org.example.exceptions.ValidationException;

public class UserValidator {

    public void validateUsername(String username) {
        if (username == null || username.isEmpty()) {
            throw new ValidationException("Username cannot be empty");
        }
    }

    public void validateEmail(String email) {
        if (email == null || !email.contains("@")) {
            throw new ValidationException("Invalid email format");
        }
    }

    public void validatePassword(String password) {
        if (password == null || password.length() < 6) {
            throw new ValidationException("Password must be at least 6 characters long");
        }
    }
}
