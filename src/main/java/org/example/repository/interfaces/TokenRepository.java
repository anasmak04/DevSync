package org.example.repository.interfaces;

import org.example.domain.entities.Token;

import java.util.List;

public interface TokenRepository {

    Token save(Token token);

    Token findByUserId(Long userId);

    void update(Token token);

    void delete(Long id);

    List<Token> findTokenByUserId(Long userId);
}
