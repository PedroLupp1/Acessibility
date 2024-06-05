import 'package:crob_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:provider/provider.dart';
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

List? dadosAluno;
Future<void> getDadosCadastraisDoSupabase() async {
  
  final user = context.read<AuthService>().getUserUid();
  final response = await supabase
      .from('user')
      .select('nome, email')
      .eq('id', 'user')
      .execute();

  final data = response.data;
  if (data == null) {
    throw Exception('Dados não encontrados no Supabase');
  }
  final responseData = response.data;
  setState(() {
    dadosAluno = responseData.toList();
  });
  
}



void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }

void _accessCampus(){
    _redirecionarParaTela('/campus');
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
     body:SingleChildScrollView(
      child: Row(
          children: [
               SideMenu(
                mode: SideMenuMode.auto,
                backgroundColor: config.Colors.primary1,
                  builder: (data) => SideMenuData(
                    header: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Image.asset('images/logo-pim.png',
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
                        title: 'Suas Disciplinas',
                        icon: const Icon(Icons.book),
                      ),
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
                        highlightSelectedColor: config.Colors.primary2,
                        hoverColor: config.Colors.primary3,
                        isSelected: false,
                        onTap: _accessCampus,
                        title: 'Outros Campus',
                        icon: const Icon(Icons.map),
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
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: getDadosCadastraisDoSupabase, child: Text('Mostrar Dados')),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: 
                                 dadosAluno != null
                                    ? SingleChildScrollView(
                                      child: DataTable(
                                          columns: const [
                                            DataColumn(label: Text('Nome')),
                                            DataColumn(label: Text('Email')),
                                          
                                          ],
                                          rows: dadosAluno?.map((item) {
                                                return DataRow(
                                                  cells: [
                                                    DataCell(
                                                        Text(item['nome'].toString())),
                                                    DataCell(Text(
                                                        item['email'].toString())),
                                                  ],
                                                );
                                              })?.toList() ??
                                              <DataRow>[],
                                        ),
                                    )
                                    : const Text('No Data Found'),
                              ),  ],
                            ),
                  ),
                        ),
                      ],
                    ),
                  ));
  }
      
  
}