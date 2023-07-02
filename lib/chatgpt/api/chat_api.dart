import '../secrets_example.dart';
import '../models/chat_message.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart' as chat_sdk;
import 'package:dart_openai/dart_openai.dart' as openai_sdk;
class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = openAiApiKey;
    OpenAI.organization = openAiOrg;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
