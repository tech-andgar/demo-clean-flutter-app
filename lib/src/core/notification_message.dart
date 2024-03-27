class NotificationMessage {
  NotificationMessage(this.type, this.message);

  final String message;
  final NotificationType type;
}

enum NotificationType {
  error,
  success,
}
