package org.example.controller.user;


import org.example.domain.entities.Tag;
import org.example.domain.entities.Task;
import org.example.domain.entities.User;
import org.example.domain.enums.Status;
import org.example.repository.TagRepositoryImpl;
import org.example.repository.TaskRepositoryImpl;
import org.example.repository.UserRepositoryImpl;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

@WebServlet(name = "UserController", value = "/user/dashboard")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class UserController extends HttpServlet {


    private TaskRepository taskRepository = new TaskRepositoryImpl();
    private UserRepository userRepository = new UserRepositoryImpl();
    private TagRepository tagRepository = new TagRepositoryImpl();



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Long userId = user.getId();
        List<Task> tasks = taskRepository.findAllByUserId(userId);
        List<Task> lastTasks = taskRepository.findLastFoorByUserId(userId);
        List<Tag> tags = tagRepository.findAll();
        request.setAttribute("tasks", tasks);
        request.setAttribute("lastTasks", lastTasks);
        request.setAttribute("tags", tags);
        request.getRequestDispatcher("/views/user/dashboard.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("status") != null) {
            request.getSession().setAttribute("success", "Task updated successfully!");
            updateStatus(request);
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
        else {
            save(request, response);
        }
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate startDate = LocalDate.parse(request.getParameter("start_date"));
        LocalDate endDate = LocalDate.parse(request.getParameter("end_date"));

        // Retrieve user_id from session and request parameters
        Long userId = (Long) request.getSession().getAttribute("user_id");
        if (request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()) {
            userId = Long.parseLong(request.getParameter("user_id"));
        }

        // Check if manager_id is provided in the request parameter
        Long managerId = null;
        String managerIdParam = request.getParameter("manager_id");
        if (managerIdParam != null && !managerIdParam.isEmpty()) {
            managerId = Long.parseLong(managerIdParam);
        }

        Part filePart = request.getPart("file");
        String filePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            Path uploadPath = Paths.get(getServletContext().getRealPath("public/uploads"));
            Files.createDirectories(uploadPath);
            filePath = "public/uploads/" + fileName;
            Files.copy(filePart.getInputStream(), uploadPath.resolve(fileName));
        }

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(Status.TODO);
        task.setStartDate(startDate);
        task.setEndDate(endDate);
        task.setUser(userId != null ? userRepository.findById(userId) : null);

        task.setManager(managerId != null ? userRepository.findById(managerId) : null);
        task.setFile(filePath);
        String[] tagIds = request.getParameterValues("tags[]");
        if (tagIds != null) {
            Set<Tag> tags = Arrays.stream(tagIds)
                    .map(Long::parseLong)
                    .map(tagRepository::findById)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());
            task.setTags(tags);
        }
        taskRepository.save(task);
        request.getSession().setAttribute("success", "Task created successfully!");

        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }


    public void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("task_id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate startDate = LocalDate.parse(request.getParameter("start_date"));
        LocalDate endDate = LocalDate.parse(request.getParameter("end_date"));

        Long userId = null;
        String userIdStr = request.getParameter("userId");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            userId = Long.parseLong(userIdStr);
        }

        Long managerId = Long.parseLong(request.getParameter("manager_id"));

        Task task = taskRepository.findById(id);
        task.setTitle(title);
        task.setDescription(description);
        task.setStartDate(startDate);
        task.setEndDate(endDate);
        task.setUser(userId != null ? userRepository.findById(userId) : null);
        task.setManager(userRepository.findById(managerId));

        taskRepository.update(task);
        request.getSession().setAttribute("success", "Task updated successfully!");

        response.sendRedirect(request.getContextPath() + "/manager/tasks");
    }

    public void updatedUserId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        String userIdParam = request.getParameter("userId");

        Task task = taskRepository.findById(taskId);

        if (userIdParam != null && !userIdParam.isEmpty()) {
            Long userId = Long.parseLong(userIdParam);
            User user = userRepository.findById(userId);
            task.setUser(user);
        } else {
            task.setUser(null);
        }

        taskRepository.updateUserId(task.getUser() != null ? task.getUser().getId() : null, taskId);
        request.getSession().setAttribute("success", "Assignment updated successfully!");

        response.sendRedirect(request.getContextPath() + "/manager/tasks");
    }


    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        taskRepository.delete(id);
        request.getSession().setAttribute("success", "Task deleted successfully!");
        response.sendRedirect(request.getContextPath() + "/manager/tasks");
    }

    private void updateStatus(HttpServletRequest request) {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        Status status = Status.valueOf(request.getParameter("status"));
        taskRepository.updateStatus(status, taskId);
    }


}
