import { Component, OnInit, OnDestroy, signal } from '@angular/core';
import { Subscription } from 'rxjs';
import { ChatService } from '../../services/chat-service';
import { ChatMessage } from '../../interfaces/chat-message';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './chat-component.html'
})
export class ChatComponent implements OnInit, OnDestroy {
  sender = 'Client'; // Identifiant par défaut pour le PoC
  messageContent = '';
  messages = signal<ChatMessage[]>([]);
  
  private messageSub!: Subscription;

  constructor(private chatService: ChatService) {}

  ngOnInit(): void {
    this.messageSub = this.chatService.messages$.subscribe((message) => {
      this.messages.update((prev) => [...prev, message]);
    });
  }

  send(): void {
    if (this.messageContent.trim()) {
      this.chatService.sendMessage(this.sender, this.messageContent);
      this.messageContent = '';
    }
  }

  ngOnDestroy(): void {
    if (this.messageSub) {
      this.messageSub.unsubscribe();
    }
  }
}