package com.openclassrooms.yourcaryourway.model;

/**
 * Représente un message échangé dans le chat.
 */
public class ChatModel {

    private String content;
    private String sender;

    public ChatModel() {}

    public ChatModel(String content, String sender) {
        this.content = content;
        this.sender = sender;
    }

    public String getContent() { 
        return content; 
    }

    public void setContent(String content) { 
        this.content = content; 
    }

    public String getSender() { 
        return sender; 
    }

    public void setSender(String sender) { 
        this.sender = sender; 
    }
}
