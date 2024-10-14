package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.example.domain.entities.Token;
import org.example.domain.entities.TokenRequest;
import org.example.domain.enums.Request;
import org.example.repository.interfaces.TokenRequestRepository;

import java.util.List;

public class TokenRequestImpl implements TokenRequestRepository {

    private final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

    @Override
    public TokenRequest save(TokenRequest tokenRequest) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(tokenRequest);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
        return tokenRequest;
    }

    @Override
    public void updateStatus(Long id, Request status) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            TokenRequest tokenRequest = entityManager.find(TokenRequest.class, id);
            tokenRequest.setRequestType(status);
            entityManager.merge(tokenRequest);

            if (status == Request.ACCEPTED) {
                Token token = entityManager.find(Token.class, tokenRequest.getUser().getId());
                token.setModifyTokenCount(token.getModifyTokenCount() - 1);
                entityManager.merge(token);
            }

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

    public List<TokenRequest> findByUserId(Long userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT tr FROM TokenRequest tr WHERE tr.user.id = :userId", TokenRequest.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }
}
