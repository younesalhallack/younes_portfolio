import 'dart:convert';
import 'package:http/http.dart' as http;

enum ContactFormResult { success, failure }

class ContactFormService {
  ContactFormService._();

  static const String _formEndpoint = 'https://formspree.io/f/xjygvvbl';

  static Future<ContactFormResult> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_formEndpoint),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name, 'email': email, 'message': message}),
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        return ContactFormResult.success;
      }
      return ContactFormResult.failure;
    } catch (_) {
      return ContactFormResult.failure;
    }
  }
}
