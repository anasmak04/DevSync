package org.example.scheduler;

import org.example.domain.entities.Token;
import org.example.domain.entities.TokenRequest;
import org.example.domain.enums.Request;
import org.example.repository.TokenRepositoryImpl;
import org.example.repository.TokenRequestImpl;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TokenModifyScheduler {

    private final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
    private final TokenRepositoryImpl tokenRepository;
    private final TokenRequestImpl tokenRequestRepository;

    public TokenModifyScheduler() {
        this.tokenRepository = new TokenRepositoryImpl();
        this.tokenRequestRepository = new TokenRequestImpl();
    }

    public void startScheduler() {
        scheduler.scheduleAtFixedRate(this::checkAndUpdateTokenCount, 0, 1, TimeUnit.DAYS);
    }

    private void checkAndUpdateTokenCount() {
        try {
            List<Token> tokens = tokenRepository.findAll();
            for (Token token : tokens) {
                List<TokenRequest> requests = tokenRequestRepository.findByUserId(token.getUser().getId());

                boolean hasPendingRequests = requests.stream().anyMatch(request -> request.getRequestType() == Request.PENDING);

                if (hasPendingRequests) {
                    token.setModifyTokenCount(token.getModifyTokenCount() * 2);
                } else {
                    token.setModifyTokenCount(2);
                }

                tokenRepository.update(token);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void stopScheduler() {
        scheduler.shutdown();
    }
}
