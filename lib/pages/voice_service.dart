import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText speech = SpeechToText();

  Future<bool> startListening(Function(String) onResult) async {
    bool available = await speech.initialize();
    if (!available) return false;

    speech.listen(
      onResult: (result) {
        String spokenText = result.recognizedWords.toLowerCase();
        onResult(spokenText);
      },
      listenFor: Duration(seconds: 10), // Adjust for continuous listening
    );

    return true;
  }

  void stopListening() {
    speech.stop();
  }
}
