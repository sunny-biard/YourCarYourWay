import { Component, OnInit, OnDestroy, signal } from '@angular/core';
import { Subscription } from 'rxjs';
import { ChatService } from '../../services/chat-service';
import { ChatMessage, SenderRole } from '../../interfaces/chat-message';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './chat-component.html'
})
export class ChatComponent implements OnInit, OnDestroy {
  // Sélection du rôle à l'arrivée sur le chat (suffisant pour les besoins du PoC).
  role = signal<SenderRole | null>(null);
  roles = SenderRole;
  messageContent = '';
  messages = signal<ChatMessage[]>([]);
  
  private messageSub!: Subscription;

  constructor(private chatService: ChatService) {}

  ngOnInit(): void {
    this.messageSub = this.chatService.messages$.subscribe((message) => {
      this.messages.update((prev) => [...prev, message]);
    });
  }

  chooseRole(role: SenderRole): void {
    this.role.set(role);
  }

  send(): void {
    const currentRole = this.role();
    if (this.messageContent.trim() && currentRole) {
      this.chatService.sendMessage(currentRole, this.messageContent);
      this.messageContent = '';
    }
  }

  ngOnDestroy(): void {
    if (this.messageSub) {
      this.messageSub.unsubscribe();
    }
  }
}