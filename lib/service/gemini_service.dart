import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GeminiService {
  final GenerativeModel _model;

  GeminiService(String apiKey)
    : _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

  Future<String> generateResponse(String prompt, {XFile? image}) async {
    try {
      final content = Content.multi([
        TextPart('''
        Anda adalah ahli agrikultur dan ekspor hasil pertanian. 
        Berikan jawaban detail dengan format:
        - Langkah-langkah konkret
        - Persyaratan dokumen
        - Contoh praktis
        - Referensi regulasi terbaru
        
        Pertanyaan: $prompt'''),
        if (image != null)
          DataPart('image/jpeg', await File(image.path).readAsBytes()),
      ]);

      final response = await _model.generateContent([content]);
      return response.text ??
          "Tidak dapat menghasilkan jawaban. Silakan coba lagi.";
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
