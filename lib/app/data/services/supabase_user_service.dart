import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> createUser(User user, {String? name}) async {
    try {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'name': name ?? user.userMetadata?['name'] ?? 'No name provided',
        'email': user.email ?? 'No email provided',
        'avatar_url': user.userMetadata?['avatar_url'],
        // 'avatar_path': null, // New field
        'image_urls': [], // Initialize empty array
        'updated_at': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to save user to Supabase: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final response =
          await _supabase.from('profiles').select().eq('id', userId).single();
      return response;
    } catch (e) {
      throw Exception('Failed to get user from Supabase: $e');
    }
  }
}
