package org.example.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.example.domain.entities.Tag;
import org.example.repository.interfaces.TagRepository;

import java.util.ArrayList;
import java.util.List;

public class TagRepositoryImpl implements TagRepository {

    private final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    @Override
    public Tag save(Tag tag) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(tag);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw e;
        } finally {
            entityManager.close();
        }
        return tag;
    }

    @Override
    public List<Tag> findAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Tag> tags = entityManager.createQuery("SELECT t FROM Tag t", Tag.class).getResultList();
        entityManager.close();
        return tags;
    }

    @Override
    public Tag findById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Tag tag = entityManager.find(Tag.class, id);
        entityManager.close();
        return tag;
    }

    public List<Tag> findTagsByIds(List<Long> ids) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        List<Tag> tags = new ArrayList<>();
        for (Long id : ids) {
            Tag tag = entityManager.find(Tag.class, id);
            tags.add(tag);
        }
        entityManager.close();
        return tags;
    }

    @Override
    public void update(Tag tag) {

    }

    @Override
    public void delete(Long id) {

    }
}
