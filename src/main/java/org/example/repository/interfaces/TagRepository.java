package org.example.repository.interfaces;

import org.example.domain.entities.Tag;

import java.util.List;

public interface TagRepository {
    Tag save(Tag tag);

    List<Tag> findAll();

    List<Tag> findTagsByIds(List<Long> ids);

    Tag findById(Long id);

    void update(Tag tag);

    void delete(Long id);
}
