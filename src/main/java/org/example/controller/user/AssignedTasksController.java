package org.example.controller.user;

import org.example.domain.entities.Task;
import org.example.domain.entities.Token;
import org.example.domain.entities.TokenRequest;
import org.example.domain.entities.User;
import org.example.domain.enums.Request;
import org.example.domain.enums.Status;
import org.example.domain.enums.TokenType;
import org.example.repository.TaskRepositoryImpl;
import org.example.repository.TokenRepositoryImpl;
import org.example.repository.TokenRequestImpl;
import org.example.repository.UserRepositoryImpl;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.TokenRepository;
import org.example.repository.interfaces.TokenRequestRepository;
import org.example.repository.interfaces.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "AssignedTasksController", value = "/user/assigned-tasks")
public class AssignedTasksController extends HttpServlet {


    private TaskRepository taskRepository = new TaskRepositoryImpl();

    private TokenRequestRepository tokenRequestRepository = new TokenRequestImpl();

    private TokenRepository tokenRepository = new TokenRepositoryImpl();

    private UserRepository userRepository = new UserRepositoryImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Long userId = user.getId();
        List<Task> tasks = taskRepository.findAllAssignedTasks(userId);
        List<Task> lastTasks = taskRepository.findLastFoorByUserId(userId);
        List<Token> tokens = tokenRepository.findTokenByUserId(userId);
        request.setAttribute("tasks", tasks);
        request.setAttribute("lastTasks", lastTasks);
        request.setAttribute("tokens", tokens);
        request.getRequestDispatcher("/views/user/assignedTasks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("task_id") != null) {
            request.getSession().setAttribute("success", "Task updated successfully!");
            updateStatus(request);
        } else{
            request.getSession().setAttribute("success", "Request for token sent successfully!");
            makeRequestForToken(request, response);
        }
        response.sendRedirect(request.getContextPath() + "/user/assigned-tasks");
    }

    private void updateStatus(HttpServletRequest request) {
        Long taskId = Long.parseLong(request.getParameter("task_id"));
        Status status = Status.valueOf(request.getParameter("status"));
        taskRepository.updateStatus(status, taskId);
    }

    private void makeRequestForToken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        TokenRequest tokenRequest = new TokenRequest();
        tokenRequest.setTask(taskRepository.findById(Long.parseLong(request.getParameter("taskId"))));
        tokenRequest.setUser(userRepository.findById(Long.parseLong(request.getParameter("user_id"))));
        tokenRequest.setRequestType(Request.PENDING);
        tokenRequest.setTokenType(TokenType.MODIFY);
        tokenRequest.setMessage(request.getParameter("message"));
        tokenRequestRepository.save(tokenRequest);
        request.getSession().setAttribute("tokenRequest", tokenRequest);
    }
}
