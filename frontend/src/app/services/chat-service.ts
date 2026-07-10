import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { Client } from '@stomp/stompjs';
import SockJS from 'sockjs-client';
import { ChatMessage } from '../interfaces/chat-message';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
    private stompClient!: Client;
    private messageSubject = new Subject<ChatMessage>();

    public messages$: Observable<ChatMessage> = this.messageSubject.asObservable();

    constructor() {
        this.connect();
    }

    private connect(): void {
        this.stompClient = new Client({
            webSocketFactory: () => new SockJS('http://localhost:8080/chat'),
            onConnect: () => {
                // S'abonner directement au canal public
                this.stompClient.subscribe('/topic/public', (message) => {
                const chatMessage: ChatMessage = JSON.parse(message.body);
                this.messageSubject.next(chatMessage);
                });
            }
        });

        this.stompClient.activate();
    }

    sendMessage(sender: string, content: string): void {
        if (this.stompClient && this.stompClient.connected) {
            const chatMessage: ChatMessage = { sender, content};
            this.stompClient.publish({
                destination: '/app/chat.sendMessage',
                body: JSON.stringify(chatMessage)
            });
        }
    }
}