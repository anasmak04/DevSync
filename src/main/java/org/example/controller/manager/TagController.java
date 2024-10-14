package org.example.controller.manager;



import org.example.domain.entities.Tag;
import org.example.repository.TagRepositoryImpl;
import org.example.repository.interfaces.TagRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TagController", value = "/manager/tags")
public class TagController extends HttpServlet {

    private TagRepository tagRepository;


    public TagController() {
        this.tagRepository = new TagRepositoryImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        save(request);
        response.sendRedirect(request.getContextPath() + "/manager/tasks");
        request.getSession().setAttribute("success", "Tag created successfully.");
    }

    public void save(HttpServletRequest request) {
        String name = request.getParameter("name");
        Tag tag = new Tag();
        tag.setName(name);
        tagRepository.save(tag);
    }
}
