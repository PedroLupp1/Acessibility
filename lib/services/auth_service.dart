import 'package:crob_project/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabaseClient = SupabaseClient(
    'https://ojysjtnqtdiosnarcfxm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
    schema: 'public',
  );

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  Future<void> _authCheck() async {
    try {
      await _supabaseClient.auth.onAuthStateChange.listen((_) {
        _getUser();
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw AuthException('Erro ao verificar o estado de autenticação: $e');
    }
  }

  Future<User?> cadastrar(String email, String senha, String nome, String local) async {
  try {
    final AuthResponse res = await _supabaseClient.auth.signUp(
      email: email,
      password: senha,
    );

    final Session? session = res.session;
    final User? usuario = res.user;

    if (session != null && usuario != null) {
      final String userId = session.user.id; 

      await _supabaseClient.from('user').insert([
        {
          'id': userId, 
          'email': email,
          'senha': senha,
          'role': 'user_comum',
          'nome': nome,
          'local': local,
        },
      ]).execute();
    }

    return usuario;
  } catch (e) {
    throw AuthException('Erro durante o cadastro: $e');
  }
}


  Future<void> login(String email, String senha) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: senha,
      );
    } catch (e) {
      throw AuthException('Erro durante o login. Tente novamente mais tarde.');
    }
  }

  Future<void> logout() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw AuthException('Erro durante o logout. Tente novamente mais tarde.');
    }
  }

  Future<void> _getUser() async {
    usuario = _supabaseClient.auth.currentUser;
    notifyListeners();
  }

Future<String?> getUserRole() async {
  try {
    final usuario = _supabaseClient.auth.currentUser;
    if (usuario != null) {
      final userId = usuario.id.toString();

      final response = await _supabaseClient
          .from('user')
          .select('role')
          .eq('id', userId) 
          .execute();
          print(userId);
          print(response.data);

      if (response.data != null && response.data.isNotEmpty) {
        dynamic role = response.data[0]['role'];
        print(response.data);
        print('role');

        if (role is String && (role == 'user_comum' || role == 'admin')) {
          return role;
        }
      }
    }
  } catch (e) {
    print('Erro ao obter o papel do usuário: $e');
  }

  return 'user_comum';
}




  Future<String?> getUserUid() async {
    final user = _supabaseClient.auth.currentUser;
    return user?.id.toString();
  }

}
