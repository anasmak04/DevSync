package org.example.controller.manager;



import org.example.exceptions.ValidationException;
import org.example.domain.entities.Tag;
import org.example.domain.entities.Task;
import org.example.domain.entities.User;
import org.example.domain.enums.Request;
import org.example.domain.enums.Status;
import org.example.domain.enums.UserRole;
import org.example.repository.TagRepositoryImpl;
import org.example.repository.TokenRequestImpl;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.TaskRepositoryImpl;
import org.example.repository.UserRepositoryImpl;
import org.example.repository.interfaces.TokenRequestRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.services.manager.TaskService;
import org.example.validation.TaskValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "TaskController", value = "/manager/tasks")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class TaskController extends HttpServlet {

    private TaskService taskService;
    private TokenRequestRepository tokenRequestRepository = new TokenRequestImpl();


    public TaskController() {
        TaskRepository taskRepository = new TaskRepositoryImpl();
        UserRepository userRepository = new UserRepositoryImpl();
        TagRepository tagRepository = new TagRepositoryImpl();
        TaskValidator taskValidator = new TaskValidator();
        this.taskService = new TaskService(taskRepository, userRepository, tagRepository, taskValidator);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Long userId = user.getId();
        List<User> users = taskService.getUsersByRole(UserRole.USER);
        List<Task> tasks = taskService.getAllTasksByManagerId(userId);
        List<Task> lastTasks = taskService.getLastTasks();
        List<Tag> tags = taskService.getAllTags();

        request.setAttribute("users", users);
        request.setAttribute("tasks", tasks);
        request.setAttribute("lastTasks", lastTasks);
        request.setAttribute("tags", tags);

        request.getRequestDispatcher("/views/manager/tasks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        try {
            if ("delete".equalsIgnoreCase(method)) {
                taskService.deleteTask(Long.parseLong(request.getParameter("id")));
            } else if (request.getParameter("userId") != null) {
                request.getSession().setAttribute("success", "Task updated successfully!");
                taskService.updateUserId(request);
            } else if (request.getParameter("status") != null) {
                request.getSession().setAttribute("success", "Task updated successfully!");
                updateStatus(request);
            }else if (request.getParameter("requestType") != null) {
                request.getSession().setAttribute("success", "Request updated successfully!");
                updateRequestStatus(request);
            }
            else {
                request.getSession().setAttribute("success", "Task saved successfully!");
                taskService.saveTask(request);
            }
            response.sendRedirect(request.getContextPath() + "/manager/tasks");
        } catch (ValidationException e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manager/tasks");
        }
    }

    private void updateStatus(HttpServletRequest request) {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        Status status = Status.valueOf(request.getParameter("status"));
        taskService.updateStatus(status, taskId);
    }

    private void updateRequestStatus(HttpServletRequest request) {
        Long requestId = Long.parseLong(request.getParameter("requestId"));
        Request status = Request.valueOf(request.getParameter("requestType"));
        tokenRequestRepository.updateStatus(requestId, status);
        removeSessionAttribute(request);
    }


    private void removeSessionAttribute(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String attributeName = "tokenRequest";

        session.removeAttribute(attributeName);
    }
}
