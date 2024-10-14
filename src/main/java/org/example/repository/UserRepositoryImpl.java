package org.example.repository;



import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import lombok.NoArgsConstructor;
import org.example.domain.entities.User;
import org.example.domain.enums.UserRole;
import org.example.repository.interfaces.UserRepository;

import java.util.List;

@NoArgsConstructor
public class UserRepositoryImpl implements UserRepository {


    private final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");


    @Override
    public User save(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }

        return user;
    }


    @Override
    public List<User> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT u FROM User u", User.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(User.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(user);
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
            User user = entityManager.find(User.class, id);
            entityManager.remove(user);
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
    public List<User> findLastFoor() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<User> users = null;
        try {
            users = entityManager.createQuery("SELECT u FROM User u ORDER BY u.id DESC", User.class)
                    .setMaxResults(4)
                    .getResultList();
        } finally {
            entityManager.close();
        }
        return users;
    }

    @Override
    public User findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<User> findByRole(UserRole role) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT u FROM User u WHERE u.role = :role", User.class)
                    .setParameter("role", role)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }



}
