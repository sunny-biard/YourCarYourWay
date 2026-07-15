# YourCarYourWay – PoC Chat Support

Preuve de concept (PoC) validant la faisabilité technique de la fonctionnalité d'échange en temps réel avec le service client, via WebSocket/STOMP, conformément aux documents *Business Requirements*, *Architecture Definition* et *Compliance Assessment* du projet.

> Ce PoC couvre **uniquement** la fonctionnalité de chat. Les autres domaines métier (Utilisateur, Agence, Véhicule, Offre, Réservation, Paiement) ne sont pas implémentés à ce stade.

## Stack technique

- **Backend** : Java 17, Spring Boot 4.1 (Spring Web, Spring WebSocket/STOMP)
- **Frontend** : Angular 22, `@stomp/stompjs`, `sockjs-client`
- Aucune base de données n'est nécessaire pour ce PoC

## Installation

### Backend

```bash
cd back
./mvnw clean install
```

### Frontend

```bash
cd front
npm install
```

## Démarrage de l'application

### Backend

```bash
cd back
./mvnw spring-boot:run
```

Le serveur démarre par défaut sur **http://localhost:8080**, avec l'endpoint STOMP exposé sur `/chat`.

### Frontend

```bash
cd front
ng serve
```

L'application est ensuite accessible sur **http://localhost:4200**.

## Vérifier le bon fonctionnement du chat

1. Démarrer le backend, puis le frontend.
2. Ouvrir **http://localhost:4200** dans le navigateur : l'écran de sélection de rôle doit s'afficher.
3. Sélectionner un rôle, puis attendre que le composant *PoC Chat Support* s'affiche.
4. Saisir un message dans le champ texte et cliquer sur **Envoyer** (ou appuyer sur `Entrée`) : le message doit apparaître immédiatement dans la liste des messages, précédé de l'expéditeur (`Client` par défaut).
5. Pour valider l'aspect **temps réel**, ouvrir une seconde fenêtre (ou un onglet en navigation privée) sur **http://localhost:4200** : un message envoyé depuis l'une des deux fenêtres doit apparaître instantanément dans l'autre, confirmant la diffusion via le broker STOMP (`/topic/public`).

## Structure du projet

```
backend/
  src/main/java/com/openclassrooms/yourcaryourway/
    configuration/WebSocketConfig.java   # Configuration STOMP (endpoint /chat, broker /topic)
    controller/ChatController.java       # Réception des messages (/app/chat.sendMessage)
    service/ChatService.java             # Validation du contenu du message
    model/ChatModel.java                 # Modèle du message échangé

frontend/
  src/app/
    components/chat-component/           # Interface de chat (liste des messages + envoi)
    services/chat-service.ts             # Connexion STOMP/SockJS et abonnement au canal
    interfaces/chat-message.ts           # Contrat de données du message
```
