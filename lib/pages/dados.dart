import 'package:crob_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config.dart' as config;
import 'package:go_router/go_router.dart';


class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}


class _DadosCadastraisState extends State<DadosCadastrais> {

final supabase = SupabaseClient(
  'https://ojysjtnqtdiosnarcfxm.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
);

Future<List<String>> getDadosCadastraisDoSupabase() async {
  final response = await supabase
      .from('user')
      .select()
      .single()
      .execute();

  /*if (response.error != null) {
    throw Exception(
      'Falha ao recuperar dados do Supabase: response.error.message,',
    );
  }*/

  final data = response.data;
  if (data == null) {
    throw Exception('Dados não encontrados no Supabase');
  }
  final nome = data['nome'] as String;
  final email = data['email'] as String;
  final telefone = data['telefone'] as String;

  final List<String> dados = [
      nome,
      email,
      telefone
    ]; 
  final lista = dados;
  return lista;
  
}



void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }


  void _back() {
  _redirecionarParaTela( "/dashboard");
    }
  void _accessDados() {
    _redirecionarParaTela('/dados');
  }
  void _accessDisciplina(){
    _redirecionarParaTela('/disciplinas');
  }
    void _exit(){
    AuthService().logout();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dados Cadastrais"),
        backgroundColor: config.Colors.primary2,
        titleTextStyle:
            const TextStyle(color: config.Colors.primary1, fontSize: 24),
      ),
     body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildDesktopLayout(); // Layout para versão desktop
          } else {
            return _buildMobileLayout(); // Layout para versão mobile
          }
        },
      ));
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
                      child: Image.asset('images/logoCrob.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                    items: [
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
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
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
                        highlightSelectedColor: config.Colors.primary2,
                        isSelected: true,
                        onTap: _accessDados,
                        title: 'Dados',
                        icon: const Icon(Icons.person),
                      ),
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
                        highlightSelectedColor: config.Colors.primary2,
                        hoverColor: config.Colors.primary3,
                        isSelected: false,
                        onTap: _accessDisciplina,
                        title: 'Disciplinas',
                        icon: const Icon(Icons.book),
                      ),
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
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
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
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
                /* Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.255,
                              child:
                              SizedBox(
                                height: 300,
                              )
                    )  ],
                          ),
                        ),*/
                      ],
                    ),
                  );
  }
        Widget _buildMobileLayout() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
                child: Center(
                  child: Text("Dados Cadastrais",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                width: 250,
                height: 250,
                child: Icon(
                  size: 250.0,
                  color: Color(0xffDD8328),
                  Icons.account_box,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "RA: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "CPF: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Curso: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(config.Colors.primary1),
                    ),
                    onPressed: _back,
                    child: const Text("Ok")),
              ),
            ],
          ),
        );
        
  
}
  }