import 'package:flutter/material.dart';
import 'package:german_tutor/components/gptMessage.dart';
import 'package:german_tutor/models/conversation.dart';
import 'package:german_tutor/services/CoversationsService.dart';
import 'package:german_tutor/views/settings.dart';

import '../components/userMessage.dart';
import '../models/message.dart';

class ConversationPage extends StatefulWidget {
  final String title;
  final int id;
  final String topic;

  const ConversationPage({
    super.key,
    required this.title,
    required this.id,
    required this.topic,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _newMessageController = TextEditingController();
  bool loadingMessages = false;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  Future<void> _getMessages() async {}

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<Message> gptMessages = [
      Message(
        id: 1,
        content: 'Hallo, wie geht es dir?',
        correction: 'Hallo, wie geht es Ihnen?',
        translation: 'Hello, how are you?',
        conversationId: 1,
        isUserMessage: false,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
      Message(
        id: 2,
        content: 'Mir geht es gut, danke.',
        correction: 'Mir geht es gut, danke.',
        translation: 'I\'m fine, thank you.',
        conversationId: 1,
        isUserMessage: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
      Message(
        id: 3,
        content: 'Wie geht es dir?',
        correction: 'Wie geht es Ihnen?',
        conversationId: 1,
        isUserMessage: false,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    ];

    List<Message> userMessages = [
      Message(
        id: 4,
        content: 'Mir geht es gut, danke.',
        translation: 'I\'m fine, thank you.',
        conversationId: 1,
        isUserMessage: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
      Message(
        id: 5,
        content: 'Wie geht es dir?',
        correction: 'Wie geht es Ihnen?',
        conversationId: 1,
        isUserMessage: false,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: theme.textTheme.headlineLarge!.copyWith(
              color: theme.colorScheme.tertiary,
            ),
          ),
        ),
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(title: widget.title)),
              )
            },
            icon: Icon(
              Icons.settings,
              color: theme.colorScheme.onPrimary,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Text(
                  'Conversations',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 90),
                  child: ListView(
                    shrinkWrap: false,
                    children: [
                      for (var message in gptMessages)
                        GPTMessage(
                          message: message,
                        ),
                      for (var message in userMessages)
                        UserMessage(
                          message: message,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // send message
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: theme.colorScheme.surface,
                        ),
                      ),
                      child: TextField(
                        controller: _newMessageController,
                        cursorColor: theme.colorScheme.onPrimary,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                        maxLines: 4,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: theme.colorScheme.primary,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Enter a message',
                          hintStyle: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onPrimary.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
