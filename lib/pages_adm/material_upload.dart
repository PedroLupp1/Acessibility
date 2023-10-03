
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:crob_project/services/midia_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config.dart' as config;

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}
 final SupabaseClient _supabaseClient = SupabaseClient(
    'https://ojysjtnqtdiosnarcfxm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
    schema: 'public',
  );

class _UploadState extends State<Upload> {
  final TextEditingController _folderNameController = TextEditingController();
  Future<void> nameFile() async {
   final userId = _supabaseClient.auth.currentUser?.id.toString();
   final result = MidiaService().pickAndUploadFile();
    if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Arquivo enviado com sucesso!")));
    } else{
      const SnackBar(content: Text("Falha ao enviar arquivo!"));
    }
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
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload"),
        backgroundColor: config.Colors.primary2,
        titleTextStyle:
            const TextStyle(color: config.Colors.primary1, fontSize: 24),
      ),
      body: SingleChildScrollView(
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
                  hoverColor: config.Colors.primary3,
                  isSelected: false,
                  onTap: _accessTurmas,
                  title: 'Turma',
                  icon: const Icon(Icons.person),
                ),
                SideMenuItemDataTile(
                  margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                  titleStyle: const TextStyle(color: config.Colors.primary2),
                  selectedTitleStyle:
                      const TextStyle(color: config.Colors.primary1),
                  highlightSelectedColor: config.Colors.primary2,
                  isSelected: true,
                  onTap: _accessUpload,
                  title: 'Material',
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
                  controller: _folderNameController,
                  decoration: InputDecoration(labelText: 'Nome da Pasta'),
                ),
                ElevatedButton(
                  onPressed: nameFile,
                  child: Text('Faça o Upload'),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
