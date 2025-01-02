import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Save or update a user in the `users` table
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      // Ensure name and email have valid values
      final updatedUserData = {
        ...userData,
        'name': userData['name'] ?? 'Anonymous', // Default name
        'email': userData['email'] ?? 'No Email Provided', // Fallback email
        'avatar_url': userData['avatar_url'] ?? null, // Profile picture
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Insert or update the user in the `users` table
      final response = await _supabase.from('users').upsert(updatedUserData).select();

      if (response.isEmpty) {
        throw Exception('Failed to save user: No data returned.');
      }
    } catch (e) {
      throw Exception('Failed to save user to Supabase: $e');
    }
  }

  /// Fetch a user from the `users` table by user ID
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final response = await _supabase.from('users').select('*').eq('id', userId).maybeSingle();

      if (response != null) {
        return response;
      } else {
        throw Exception('User not found for the provided ID.');
      }
    } catch (e) {
      throw Exception('Failed to get user from Supabase: $e');
    }
  }
}
