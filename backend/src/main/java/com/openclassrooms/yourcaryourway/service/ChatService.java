package com.openclassrooms.yourcaryourway.service;

import org.springframework.stereotype.Service;

import com.openclassrooms.yourcaryourway.model.ChatModel;

@Service
public class ChatService {

    public ChatModel processMessage(ChatModel message) {
        // Validation du contenu
        if (message.getContent() == null || message.getContent().isBlank()) {
            throw new IllegalArgumentException("Le contenu du message ne peut pas être vide");
        }

        return message;
    }
}
