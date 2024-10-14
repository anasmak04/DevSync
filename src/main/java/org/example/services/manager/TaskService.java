package org.example.services.manager;


import org.example.domain.entities.Tag;
import org.example.domain.entities.Task;
import org.example.domain.entities.User;
import org.example.domain.enums.Status;
import org.example.domain.enums.UserRole;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.validation.TaskValidator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

public class TaskService {


    private final TaskRepository taskRepository;
    private final UserRepository userRepository;
    private final TagRepository tagRepository;
    private final TaskValidator taskValidator;


    public TaskService(TaskRepository taskRepository, UserRepository userRepository, TagRepository tagRepository, TaskValidator taskValidator) {
        this.taskRepository = taskRepository;
        this.userRepository = userRepository;
        this.tagRepository = tagRepository;
        this.taskValidator = taskValidator;

    }

    public List<User> getUsersByRole(UserRole role) {
        return userRepository.findByRole(role);
    }

    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    public List<Task> getAllTasksByManagerId(Long userId) {
        return taskRepository.findAllByManagerId(userId);
    }

    public List<Task> getLastTasks() {
        return taskRepository.findLastFoor();
    }

    public List<Task> getAssignedTasks(User user) {
        return taskRepository.findAllAssignedTasks(user.getId());
    }



    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    public void saveTask(HttpServletRequest request) throws IOException, ServletException {
        Task task = buildTaskFromRequest(request);
        taskValidator.validate(task);
        taskRepository.save(task);
        request.getSession().setAttribute("success", "Task created successfully!");
    }

    public void updateTask(HttpServletRequest request) throws ServletException, IOException {
        Task task = buildTaskFromRequest(request);
        taskValidator.validate(task);
        taskRepository.update(task);
    }

    public void updateUserId(HttpServletRequest request) {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        String userIdParam = request.getParameter("userId");

        Task task = taskRepository.findById(taskId);
        User user = (userIdParam != null && !userIdParam.isEmpty()) ? userRepository.findById(Long.parseLong(userIdParam)) : null;
        task.setUser(user);
        taskRepository.updateUserId(task.getUser() != null ? task.getUser().getId() : null, taskId);
    }

    public void updateStatus(Status status, Long taskId) {
        taskRepository.updateStatus(status, taskId);
    }

    public void deleteTask(Long id) {
        taskRepository.delete(id);
    }

    private Task buildTaskFromRequest(HttpServletRequest request) throws IOException, ServletException {
        Task task = new Task();
        task.setTitle(request.getParameter("title"));
        task.setDescription(request.getParameter("description"));
        task.setStartDate(LocalDate.parse(request.getParameter("start_date")));
        task.setEndDate(LocalDate.parse(request.getParameter("end_date")));
        task.setStatus(Status.TODO);
        task.setManager(userRepository.findById(Long.parseLong(request.getParameter("manager_id"))));
        task.setUser(getUserFromRequest(request));

        String[] tagIds = request.getParameterValues("tags[]");
        if (tagIds != null) {
            Set<Tag> tags = Arrays.stream(tagIds)
                    .map(Long::parseLong)
                    .map(tagRepository::findById)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());
            task.setTags(tags);
        }

        task.setFile(saveUploadedFile(request));

        return task;
    }

    private User getUserFromRequest(HttpServletRequest request) {
        String userIdStr = request.getParameter("user_id");
        return (userIdStr != null && !userIdStr.isEmpty()) ? userRepository.findById(Long.parseLong(userIdStr)) : null;
    }

    private String saveUploadedFile(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            Path uploadPath = Paths.get(request.getServletContext().getRealPath("public/uploads"));
            Files.createDirectories(uploadPath);
            Files.copy(filePart.getInputStream(), uploadPath.resolve(fileName));
            return "public/uploads/" + fileName;
        }
        return null;
    }

}
