/*import 'package:flutter/material.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../config.dart' as config;

class MinhasTurmas extends StatefulWidget {
  const MinhasTurmas({super.key});

  @override
  State<MinhasTurmas> createState() => _MinhasTurmasState();
}
  Future<void> addUserToTurma(String userId, String turmaId) async {
    try {
      final userRef =
        .instance.collection('users').doc(userId);  //supabase

      // Primeiro, verifique se o usuário já está na turma
      final userDoc = await userRef.get();
      final turmas = userDoc.get('turmas') ?? <String>[];

      if (!turmas.contains(turmaId)) {
        // Se o usuário não estiver na turma, adicione o ID da turma à lista de turmas do usuário
        turmas.add(turmaId);
        await userRef.update({'turmas': turmas});
      }
    } catch (e) {
      print('Erro ao adicionar usuário à turma: $e');
      throw e;
    }
  }

class _MinhasTurmasState extends State<MinhasTurmas> {
  void _back() {
    Navigator.popAndPushNamed(context, "/dashboard");
  }

  void _accessDados() {
    Navigator.popAndPushNamed(context, '/dados');
  }

  void _accessDisciplina() {
    Navigator.popAndPushNamed(context, '/disciplinas');
  }

  void _exit() {
    AuthService().logout();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Disciplinas"),
          backgroundColor: const Color(0xffd9d9d9),
          titleTextStyle:
              const TextStyle(color: Color(0xff325CA9), fontSize: 24),
        ),
        body: Row(children: [
      SideMenu(
        mode: SideMenuMode.auto,
        backgroundColor: config.Colors.primary1,
        builder: (data) => SideMenuData(
          header: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Image.asset(
              'images/logoCrob.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          items: [
            SideMenuItemDataTile(
              margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
              titleStyle: const TextStyle(color: config.Colors.primary2),
              selectedTitleStyle:
                  const TextStyle(color: config.Colors.primary1),
              highlightSelectedColor: config.Colors.primary2,
              hoverColor: config.Colors.primary3,
              isSelected: false,
              onTap: _back,
              title: 'Home',
              icon: const Icon(Icons.home),
            ),
            SideMenuItemDataTile(
              margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
              titleStyle: const TextStyle(color: config.Colors.primary2),
              selectedTitleStyle:
                  const TextStyle(color: config.Colors.primary1),
              highlightSelectedColor: config.Colors.primary2,
              hoverColor: config.Colors.primary3,
              isSelected: false,
              onTap: _accessDados,
              title: 'Dados',
              icon: const Icon(Icons.person),
            ),
            SideMenuItemDataTile(
              margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
              titleStyle: const TextStyle(color: config.Colors.primary2),
              selectedTitleStyle:
                  const TextStyle(color: config.Colors.primary1),
              highlightSelectedColor: config.Colors.primary2,
              isSelected: true,
              onTap: _accessDisciplina,
              title: 'Disciplinas',
              icon: const Icon(Icons.book),
            ),
            SideMenuItemDataTile(
              margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
              titleStyle: const TextStyle(color: config.Colors.primary2),
              selectedTitleStyle:
                  const TextStyle(color: config.Colors.primary1),
              highlightSelectedColor: config.Colors.primary2,
              hoverColor: config.Colors.primary3,
              isSelected: false,
              onTap: () {},
              title: 'AO VIVO',
              icon: const Icon(Icons.live_tv),
            ),
            /* SideMenuItemDataTile(
                    isSelected: true,
                    onTap: () {},
                    title: 'Settings',
                    icon: const Icon(Icons.settings),
                  ),*/
            SideMenuItemDataTile(
              margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
              titleStyle: const TextStyle(color: config.Colors.primary2),
              selectedTitleStyle:
                  const TextStyle(color: config.Colors.primary1),
              highlightSelectedColor: config.Colors.primary2,
              hoverColor: config.Colors.primary3,
              isSelected: false,
              onTap: _exit,
              title: 'Exit',
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.7, // Defina a largura desejada para o vídeo
                height: MediaQuery.of(context).size.height *
                    0.7, // Defina a altura desejada para o vídeo

              ),
            ],
          ),
        ),
      )
    ]));
  }
}*/