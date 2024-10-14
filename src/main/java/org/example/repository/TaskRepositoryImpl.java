package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.example.domain.entities.Task;
import org.example.domain.entities.User;
import org.example.domain.enums.Status;
import org.example.repository.interfaces.TaskRepository;

import java.util.List;

public class TaskRepositoryImpl implements TaskRepository {


    private final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

    @Override
    public void save(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }


    @Override
    public List<Task> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t ORDER BY t.id ASC", Task.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Task findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Task.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void update(Task task) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void delete(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Task task = entityManager.find(Task.class, id);
            entityManager.remove(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findLastFoor() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t ORDER BY t.id DESC", Task.class).setMaxResults(4).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t WHERE t.user.id = :userId", Task.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateUserId(Long userId, Long taskId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Task task = entityManager.find(Task.class, taskId);
            task.setUser(entityManager.find(User.class, userId));
            entityManager.merge(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateStatus(Status status, Long taskId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Task task = entityManager.find(Task.class, taskId);
            task.setStatus(status);
            entityManager.merge(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findByStatus(String status) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t WHERE t.status = :status", Task.class)
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findAllByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t WHERE t.user.id = :userId AND t.manager IS NULL", Task.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findAllByManagerId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t WHERE t.manager.id = :userId", Task.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findLastFoorByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Task t WHERE t.user.id = :userId ORDER BY t.id DESC", Task.class)
                    .setParameter("userId", userId)
                    .setMaxResults(4)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findAllAssignedTasks(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery(
                            "SELECT t FROM Task t JOIN FETCH t.user u JOIN FETCH u.tokens token " +
                                    "WHERE u.id = :userId AND t.manager IS NOT NULL", Task.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }
}
