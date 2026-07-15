package com.openclassrooms.yourcaryourway.service;

import java.util.Set;

import org.springframework.stereotype.Service;

import com.openclassrooms.yourcaryourway.model.ChatModel;

@Service
public class ChatService {

    private static final Set<String> ALLOWED_SENDERS = Set.of("CLIENT", "SUPPORT");

    public ChatModel processMessage(ChatModel message) {
        // Validation du contenu
        if (message.getContent() == null || message.getContent().isBlank()) {
            throw new IllegalArgumentException("Le contenu du message ne peut pas être vide");
        }

        if (message.getSender() == null || !ALLOWED_SENDERS.contains(message.getSender())) {
            throw new IllegalArgumentException("Expéditeur invalide : doit être CLIENT ou SUPPORT");
        }

        return message;
    }
}
