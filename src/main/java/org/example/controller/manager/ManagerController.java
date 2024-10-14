package org.example.controller.manager;


import org.example.exceptions.UserNotFoundException;
import org.example.exceptions.ValidationException;
import org.example.repository.TokenRepositoryImpl;
import org.example.repository.interfaces.TokenRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.repository.UserRepositoryImpl;
import org.example.services.manager.ManagerService;
import org.example.validation.UserValidator;

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
import java.time.LocalDateTime;
import java.util.List;


@WebServlet(name = "ManagerController", value = "/manager/dashboard")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class ManagerController extends HttpServlet {
    private  ManagerService managerService;

    public ManagerController() {
        UserRepository userRepository = new UserRepositoryImpl();
        UserValidator userValidator = new UserValidator();
        TokenRepository tokenRepository = new TokenRepositoryImpl();
        this.managerService = new ManagerService(userRepository, userValidator , tokenRepository);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        Long userId = request.getParameter("user_id") != null ? Long.parseLong(request.getParameter("user_id")) : null;

        try {
            if ("delete".equalsIgnoreCase(method)) {
                managerService.deleteUser(Long.parseLong(request.getParameter("id")));
            } else if (userId != null) {
                managerService.updateUser(userId, request.getParameter("username"), request.getParameter("email"));
            } else {
                save(request);
            }
            response.sendRedirect(request.getContextPath() + "/manager/dashboard");
        } catch (ValidationException | UserNotFoundException e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manager/dashboard");
        }
    }

    private void save(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("profile");
        String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        Path uploadPath = Paths.get(request.getServletContext().getRealPath("public/uploads"));
        Files.createDirectories(uploadPath);
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(filePart.getInputStream(), filePath);

        managerService.saveUser(
                request.getParameter("username"),
                request.getParameter("email"),
                request.getParameter("password"),
                request.getParameter("role"),
                "public/uploads/" + fileName
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("users", managerService.getAllUsers());
        request.setAttribute("last_users", managerService.getLastUsers());
        request.getRequestDispatcher("/views/manager/dashboard.jsp").forward(request, response);
    }
}
