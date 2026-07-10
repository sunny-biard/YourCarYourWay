package com.openclassrooms.yourcaryourway.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.openclassrooms.yourcaryourway.model.ChatModel;
import com.openclassrooms.yourcaryourway.service.ChatService;

@Controller
public class ChatController {

private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    // Réception d'un message : destination /app/chat.sendMessage
    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatModel sendMessage(ChatModel message) {
        return chatService.processMessage(message);
    }
}
