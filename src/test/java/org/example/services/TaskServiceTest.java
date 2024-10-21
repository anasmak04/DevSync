package org.example.services;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.example.exceptions.TagNotFoundException;
import org.example.exceptions.UserNotFoundException;
import org.example.models.Tag;
import org.example.models.Task;
import org.example.models.User;
import org.example.models.enums.Status;
import org.example.models.enums.UserRole;
import org.example.repository.TagRepositoryImpl;
import org.example.repository.TaskRepositoryImpl;
import org.example.repository.UserRepositoryImpl;
import org.example.repository.interfaces.TagRepository;
import org.example.repository.interfaces.TaskRepository;
import org.example.repository.interfaces.UserRepository;
import org.example.services.manager.TaskService;
import org.example.validation.TaskValidator;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class TaskServiceTest {

    @Mock
    private TaskRepository taskRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private TagRepository tagRepository;

    @Mock
    private HttpServletRequest request;

    @Mock
    private TaskValidator taskValidator;

    @Mock
    private HttpSession session;

    @Mock
    private Part filePart;

    @InjectMocks
    private TaskService taskService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }


    void requestParametres() {
        when(request.getParameter("title")).thenReturn("Sample Task");
        when(request.getParameter("description")).thenReturn("Task description");
        when(request.getParameter("start_date")).thenReturn("2024-10-15");
        when(request.getParameter("end_date")).thenReturn("2024-10-20");
        when(request.getParameter("manager_id")).thenReturn("1");
        when(request.getParameter("user_id")).thenReturn("2");
        when(request.getParameterValues("tags[]")).thenReturn(new String[] {"1", "2"});
    }

    @Test
    void testSaveTask_Success() throws ServletException, IOException {
        requestParametres();
        User manager = new User();
        manager.setId(1L);
        User user = new User();
        user.setId(2L);
        when(userRepository.findById(1L)).thenReturn(manager);
        when(userRepository.findById(2L)).thenReturn(user);

        Tag tag1 = new Tag();
        tag1.setId(1L);
        Tag tag2 = new Tag();
        tag2.setId(2L);
        when(tagRepository.findById(1L)).thenReturn(tag1);
        when(tagRepository.findById(2L)).thenReturn(tag2);

        when(request.getSession()).thenReturn(session);

        taskService.saveTask(request);

        verify(taskRepository, times(1)).save(any(Task.class));
        verify(session, times(1)).setAttribute("success", "Task created successfully!");
    }

    @Test
    void testSaveTask_InvalidUser() {
       requestParametres();

        User manager = new User();
        manager.setId(1L);
        when(userRepository.findById(1L)).thenReturn(manager);
        when(userRepository.findById(2L)).thenThrow(new UserNotFoundException("User not found"));

        assertThrows(UserNotFoundException.class, () -> taskService.saveTask(request));
    }

    @Test
    void testSaveTask_InvalidTag() {
        requestParametres();

        User manager = new User();
        manager.setId(1L);
        User user = new User();
        user.setId(2L);
        when(userRepository.findById(1L)).thenReturn(manager);
        when(userRepository.findById(2L)).thenReturn(user);
        when(tagRepository.findById(1L)).thenReturn(new Tag());
        when(tagRepository.findById(2L)).thenThrow(new TagNotFoundException("Tag not found"));

        assertThrows(TagNotFoundException.class, () -> taskService.saveTask(request));
    }

    @Test
    void testSaveTask_InvalidDate() {
        requestParametres();
        User manager = new User();
        manager.setId(1L);
        User user = new User();
        user.setId(2L);
        when(userRepository.findById(1L)).thenReturn(manager);
        when(userRepository.findById(2L)).thenReturn(user);
        when(tagRepository.findById(1L)).thenReturn(new Tag());
        when(tagRepository.findById(2L)).thenReturn(new Tag());

        assertThrows(IllegalArgumentException.class, () -> taskService.saveTask(request));
    }

    @Test
    void testUpdateTask_Success() throws ServletException, IOException {
        when(request.getParameter("title")).thenReturn("Updated Task");
        when(request.getParameter("description")).thenReturn("Updated description");
        when(request.getParameter("start_date")).thenReturn("2024-10-20");
        when(request.getParameter("end_date")).thenReturn("2024-10-25");
        when(request.getParameter("manager_id")).thenReturn("1");
        when(request.getParameter("user_id")).thenReturn("2");

        Task task = new Task();
        task.setId(1L);
        task.setTitle("Original Task");
        when(taskRepository.findById(1L)).thenReturn(task);

        taskService.updateTask(request);

        verify(taskRepository, times(1)).update(any(Task.class));
    }

    @Test
    void testUpdateUserId_Success() {
        Long taskId = 1L;
        Long userId = 2L;

        when(request.getParameter("task_id")).thenReturn(taskId.toString());
        when(request.getParameter("userId")).thenReturn(userId.toString());

        Task task = new Task();
        task.setId(taskId);
        User user = new User();
        user.setId(userId);

        when(taskRepository.findById(taskId)).thenReturn(task);
        when(userRepository.findById(userId)).thenReturn(user);

        taskService.updateUserId(request);

        verify(taskRepository, times(1)).updateUserId(userId, taskId);
    }

    @Test
    void testUpdateStatus_Success() {
        Long taskId = 1L;
        Status status = Status.DONE;

        taskService.updateStatus(status, taskId);

        verify(taskRepository, times(1)).updateStatus(status, taskId);
    }

    @Test
    void testDeleteTask_Success() {
        Long taskId = 1L;

        taskService.deleteTask(taskId);

        verify(taskRepository, times(1)).delete(taskId);
    }
}