/*import 'package:crob_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:chewie/chewie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';
import '../config.dart' as config;

class Disciplinas extends StatefulWidget {
  const Disciplinas({Key? key}) : super(key: key);

  @override
  State<Disciplinas> createState() => _DisciplinasState();
}

class _DisciplinasState extends State<Disciplinas> {
  final user = _supabase.instance.currentUser; //inserir supabase
  late VideoPlayerController videoController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

   videoController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/portal-crob.appspot.com/o/4.%20Ass%C3%ADncrono%20-%20Na%20educa%C3%A7%C3%A3o%20infantil%20%C3%A9%20preciso%20escutar.mp4?alt=media&token=672fab0a-df13-4d50-a837-9d30354dadf4');

    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: false,
      aspectRatio: 2.0,
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }

  void _back() {
    _redirecionarParaTela("/dashboard");
  }

  void _accessDados() {
    _redirecionarParaTela('/dados');
  }

  void _accessDisciplina() {
    _redirecionarParaTela('/disciplinas');
  }

  void _exit() {
    AuthService().logout();
  }

  Future<void> addUserToTurma(String userId, String turmaId) async {
    try {
      final userRef =
          Supabase.instance.role('user').doc(userId);

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

    }
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
                child: Chewie(
                  controller: chewieController,
                ), // Adicione o Chewie aqui
              ),
            ],
          ),
        ),
      )
    ]));
*/  
/*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
}
/**/ */
