import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserState extends ChangeNotifier {
  User? _usuario;

  User? get usuario => _usuario;

  void setUsuario(User? usuario) {
    _usuario = usuario;
    notifyListeners();
  }
}
