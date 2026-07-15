export enum SenderRole {
  CLIENT = 'CLIENT',
  SUPPORT = 'SUPPORT'
}

export interface ChatMessage {
  sender: SenderRole;
  content: string;
}