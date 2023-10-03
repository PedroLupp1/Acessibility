/*import 'package:flutter/material.dart';


class Turma {
  final String nome;
  final String storageFolder;
  final String adminId;

  Turma(this.nome, this.storageFolder, this.adminId);
}

class TurmaCreationScreen extends StatefulWidget {
  @override
  _TurmaCreationScreenState createState() => _TurmaCreationScreenState();
}

class _TurmaCreationScreenState extends State<TurmaCreationScreen> {
  final _nomeController = TextEditingController();
  final _storageFolderController = TextEditingController();
  final _auth = .instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    final user = await _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

  void _createTurma() {
    final nome = _nomeController.text;
    final storageFolder = _storageFolderController.text;
    final adminId = _user?.uid;

    if (nome.isNotEmpty && storageFolder.isNotEmpty && adminId != null) {
      // Adicione o novo documento à coleção "turmas" no Firestore
      final novaTurma = Turma(nome, storageFolder, adminId);
      // Aqui você pode usar o Firestore para adicionar o documento
      // Exemplo: Firestore.instance.collection('turmas').add(novaTurma);

      // Atualize o perfil do usuário com o "turmaId"
      // Exemplo: _user.updateProfile(displayName: turmaId);
      // Certifique-se de implementar uma maneira de associar o usuário à turma selecionada.
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }*/