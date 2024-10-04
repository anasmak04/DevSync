package org.devsyc.controller;


import org.devsyc.domain.entities.User;
import org.devsyc.domain.enums.Role;
import org.devsyc.repository.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private UserRepository userRepository;

    @Override
    public void init() throws ServletException {
        userRepository = new UserRepository();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            Role role = Role.valueOf(req.getParameter("role"));
            User user = new User(null, firstName, lastName, email, password, role);
            userRepository.save(user);

            res.sendRedirect("users");

        } else if ("update".equals(action)) {
            Long userId = Long.valueOf(req.getParameter("id"));
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            Role role = Role.valueOf(req.getParameter("role"));
            User user = new User(userId, firstName, lastName, email, password, role);
            userRepository.update(user);

            res.sendRedirect("users");

        } else if ("delete".equals(action)) {
            Long userId = Long.valueOf(req.getParameter("id"));
            userRepository.delete(userId);

            res.sendRedirect("users");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            Long userId = Long.valueOf(req.getParameter("id"));
            User user = userRepository.findById(userId);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/editUser.jsp").forward(req, res);
        } else {
            List<User> users = userRepository.findAll();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/users.jsp").forward(req, res);
        }
    }

}
