package org.example.services.manager;

import org.example.domain.entities.Tag;
import org.example.repository.TagRepositoryImpl;
import org.example.repository.interfaces.TagRepository;

import java.util.List;

public class TagService {

    private TagRepository tagRepository;

    public TagService(TagRepository tagRepository) {
        this.tagRepository = new TagRepositoryImpl();
    }

    public Tag save(Tag tag) {
        return tagRepository.save(tag);
    }

    public Tag findTagById(Long id) {
        return tagRepository.findById(id);
    }

    public List<Tag> findAllTags() {
        return tagRepository.findAll();
    }

}
