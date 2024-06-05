import 'package:crob_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';
import '../config.dart' as config;

class Campus extends StatefulWidget {
  const Campus({Key? key}) : super(key: key);

  @override
  State<Campus> createState() => _CampusState();
}

class _CampusState extends State<Campus> {
  final supabase = SupabaseClient(
    'https://ojysjtnqtdiosnarcfxm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
  );

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  List<Map<String, dynamic>> turmas = []; // Lista de turmas
  bool isLoading = true; // Variável para controlar o estado de carregamento

  @override
  void initState() {
    super.initState();
    minhasTurmas();
  }

  Future<void> minhasTurmas() async {
    final user = context.read<AuthService>().getUserUid().toString();
    final response = await supabase
        .from('aluno')
        .select('id_turma')
        .eq('aluno_id', user)
        .execute();
        print(response.data);
    if (response.data.isNotEmpty) {
      for (final data in response.data) {
        final turmaId = data['id_turma'];

        final turma = await supabase
            .from('turma')
            .select('id, nome')
            .eq('id', turmaId)
            .execute();
            print(turma.data);

        if (turma.data.isNotEmpty) {
          turmas.add(turma.data[0]);
        }
      }
    }

    
    setState(() {
      isLoading = false;
    });
  }

  void _redirecionarParaTelaTurma(String rota, int turmaId) {
    GoRouter.of(context).pushReplacement("$rota/$turmaId");
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

  void _accessCampus(){
    _redirecionarParaTela('/campus');
  }

  void _accessDisciplina() {
    _redirecionarParaTela('/disciplinas');
  }

  void _accessPlayer() {
    _redirecionarParaTela('/player');
  }

  void _exit() {
    AuthService().logout();
    _redirecionarParaTela('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Outro Campus"),
        backgroundColor: const Color(0xffd9d9d9),
        titleTextStyle: const TextStyle(color: Color.fromARGB(255, 231, 95, 4), fontSize: 24),
      ),
      body: FutureBuilder<String>(
          future: _calculation,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text(
                  'Sem Dados'); // Exibe uma mensagem para "Sem Dados"
            } else {
              return Row(
                children: [
                  SideMenu(
                    mode: SideMenuMode.auto,
                    backgroundColor: config.Colors.primary1,
                    builder: (data) => SideMenuData(
                      header: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Image.asset(
                          'images/logo-pim.png',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      items: [
                        SideMenuItemDataTile(
                          margin: const EdgeInsetsDirectional.only(
                              top: 7, bottom: 7),
                          titleStyle:
                              const TextStyle(color: config.Colors.primary2),
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
                          margin: const EdgeInsetsDirectional.only(
                              top: 7, bottom: 7),
                          titleStyle:
                              const TextStyle(color: config.Colors.primary2),
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
                          margin: const EdgeInsetsDirectional.only(
                              top: 7, bottom: 7),
                          titleStyle:
                              const TextStyle(color: config.Colors.primary2),
                          selectedTitleStyle:
                              const TextStyle(color: config.Colors.primary1),
                          highlightSelectedColor: config.Colors.primary2,
                          isSelected: true,
                          onTap: _accessDisciplina,
                          title: 'Suas Disciplinas',
                          icon: const Icon(Icons.book),
                        ),
                        SideMenuItemDataTile(
                          margin: const EdgeInsetsDirectional.only(
                              top: 7, bottom: 7),
                          titleStyle:
                              const TextStyle(color: config.Colors.primary2),
                          selectedTitleStyle:
                              const TextStyle(color: config.Colors.primary1),
                          highlightSelectedColor: config.Colors.primary2,
                          hoverColor: config.Colors.primary3,
                          isSelected: false,
                          onTap: _accessCampus,
                          title: 'Outros Campus',
                          icon: const Icon(Icons.map),
                        ),
                        SideMenuItemDataTile(
                          margin: const EdgeInsetsDirectional.only(
                              top: 7, bottom: 7),
                          titleStyle:
                              const TextStyle(color: config.Colors.primary2),
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
    child: Padding(
      padding: const EdgeInsets.only(right: 50, left: 50),
      child: Column(
        children: [
          SizedBox(
            width: 200, // Defina a largura desejada para os botões
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: config.Colors.primary1,
                onPrimary: config.Colors.primary2,
              ),
              onPressed: _accessPlayer,
              child: Text('Campus Barcelona'), // Texto personalizável
            ),
          ),
          const SizedBox(height: 10), // Espaçamento entre os botões
          SizedBox(
            width: 200, // Defina a largura desejada para os botões
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: config.Colors.primary1,
                onPrimary: config.Colors.primary2,
              ),
              onPressed: _accessPlayer,
              child: Text('Campus Centro'), // Texto personalizável
            ),
          ),
        ],
      ),
    ),
  ),
)

                ],
              );
            }
          }),
    );
  }
}
