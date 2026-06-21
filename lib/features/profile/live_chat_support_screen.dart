import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class LiveChatSupportScreen extends StatelessWidget {
  const LiveChatSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(radius: 18, child: Icon(Icons.support_agent)),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.colorScheme.surface, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Support Agent', style: theme.textTheme.labelLarge),
                Text('Online', style: theme.textTheme.bodySmall?.copyWith(color: Colors.green, fontSize: 10)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.containerMargin),
              children: [
                _ChatMessage(
                  message: 'Hello! How can I assist you today?',
                  isMe: false,
                  time: '10:00 AM',
                ),
                _ChatMessage(
                  message: 'I have a question about my recent order #ES-94201.',
                  isMe: true,
                  time: '10:01 AM',
                ),
                _ChatMessage(
                  message: 'Sure, I can help with that. What specifically would you like to know?',
                  isMe: false,
                  time: '10:02 AM',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.2))),
            ),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.send, color: theme.colorScheme.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const _ChatMessage({required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(color: isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: (isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant).withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
