/*import 'package:flutter/material.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../config.dart' as config;

class Turmas extends StatefulWidget {
  const Turmas({Key? key});

  @override
  State<Turmas> createState() => _TurmasState();
}

class _TurmasState extends State<Turmas> {

final supabase = SupabaseClient(
  'https://ojysjtnqtdiosnarcfxm.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
);


  final _nomeController = TextEditingController();
  final _storageFolderController = TextEditingController();
  final _auth = _supabase.instance; //supabase
  User? _user; 
  final user = supabase.instance.currentUser;  //supabase

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
    // Gerar um ID único para a turma
    final turmaId = .instance.collection('turmas').doc().id;

    // Crie uma nova turma no Firestore com o ID único
    .instance.collection('turmas').doc(turmaId).set({  
      'id': turmaId, // Adicione o ID único à turma
      'nome': nome,
      'storageFolder': storageFolder,
      'adminId': adminId,
    });  //supabase
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dados Cadastrais"),
        backgroundColor: config.Colors.primary2,
        titleTextStyle: const TextStyle(
            color: config.Colors.primary1, fontSize: 24),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildDesktopLayout(); // Layout para versão desktop
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      child: Row(
        children: [
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
                  isSelected: true,
                  onTap: _accessTurmas,
                  title: 'Turma',
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
                  onTap: _accessUpload,
                  title: 'Material',
                  icon: const Icon(Icons.person),
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
                  onTap: () {
                    _exit(context);
                  },
                  title: 'Exit',
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome da Turma'),
                ),
                TextField(
                  controller: _storageFolderController,
                  decoration:
                      InputDecoration(labelText: 'Pasta no Firebase Storage'),
                ),
                ElevatedButton(
                  onPressed: _createTurma,
                  child: Text('Criar Turma'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  "Upload de Arquivos",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(config.Colors.primary1),
                ),
                onPressed: _handleUploadButtonPressed,
                child: const Text("Selecionar Arquivo"),
              ),
            ),
          ],
        ),
      ),
    );
  }


void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }
  void _back() {
    _redirecionarParaTela("/dashboardadm");
  }

  void _accessTurmas() {
    _redirecionarParaTela('/turmas');
  }

  void _accessUpload() {
    _redirecionarParaTela('/upload');
  }

  Future<void> _exit(BuildContext context) async {
    await context.read<AuthService>().logout();
    navigation();
  }

  void navigation() {
    _redirecionarParaTela('/login');
  }

  void _handleUploadButtonPressed() {
    // Lógica para o botão de upload
  }
}*/
