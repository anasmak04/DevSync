package org.example.validation;

import org.example.exceptions.ValidationException;
import org.example.domain.entities.Task;

public class TaskValidator {

    public void validate(Task task) throws ValidationException {
        if (task.getTitle() == null || task.getTitle().isEmpty()) {
            throw new ValidationException("Title cannot be empty.");
        }
        if (task.getStartDate() != null && task.getEndDate() != null && task.getEndDate().isBefore(task.getStartDate())) {
            throw new ValidationException("End date cannot be before start date.");
        }
        if (task.getManager() == null) {
            throw new ValidationException("Manager cannot be empty.");
        }
    }
}
