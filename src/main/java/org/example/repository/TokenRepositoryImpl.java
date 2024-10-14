package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.example.domain.entities.Token;
import org.example.repository.interfaces.TokenRepository;

import java.util.List;

public class TokenRepositoryImpl implements TokenRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");


    @Override
    public Token save(Token token) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(token);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }

        return token;

    }

    public List<Token> findTokenByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Token t WHERE t.user.id = :userId", Token.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    public List<Token> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT t FROM Token t", Token.class).getResultList();
        } finally {
            entityManager.close();
        }
    }



    @Override
    public Token findByUserId(Long userId) {
        return null;
    }

    @Override
    public void update(Token token) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(token);
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

    }
}
