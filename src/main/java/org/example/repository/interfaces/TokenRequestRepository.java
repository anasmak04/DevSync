package org.example.repository.interfaces;

import org.example.domain.entities.TokenRequest;
import org.example.domain.enums.Request;

public interface TokenRequestRepository {

    TokenRequest save(TokenRequest tokenRequest);

    void updateStatus(Long id, Request status);

}
