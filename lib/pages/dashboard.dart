import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import '../config.dart' as config;



class DashBoard extends StatefulWidget {
  const DashBoard({Key? key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override

  void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }

  void _accessDados() {
    _redirecionarParaTela('/dados');
  }

  void _accessDisciplina() {
    _redirecionarParaTela('/disciplinas');
  }

  Future<void> _exit() async {
    await AuthService().logout();
    navigation();
  }

  void navigation() {

    GoRouter.of(context).pushReplacement('/login');

    _redirecionarParaTela('/login');

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Portal Educacional"),
        backgroundColor: config.Colors.primary2,
        titleTextStyle:
            const TextStyle(color: config.Colors.primary1, fontSize: 24),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildDesktopLayout(); // Layout para versão desktop
          } else {
            return _buildDesktopLayout(); // Layout para versão mobile
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
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
                hoverColor: config.Colors.primary2,
                isSelected: true,
                onTap: () {},
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
                hoverColor: config.Colors.primary3,
                isSelected: false,
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
              SideMenuItemDataTile(
                margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                titleStyle: const TextStyle(color: config.Colors.primary2),
                selectedTitleStyle:
                    const TextStyle(color: config.Colors.primary1),
                highlightSelectedColor: config.Colors.primary2,
                hoverColor: config.Colors.primary3,
                isSelected: false,
                onTap: () {
                  _exit();
                },
                title: 'Exit',
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Conteúdos: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  
                ),
               const SizedBox(
                  height: 20,
                ),
                
               
          
              ],
            ),
          ),
        ),
      ],
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
                child: Text("Continue Assistindo",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 70,
              child: Center(
                child: Text("Menu",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                onPressed: _accessDados,
                child: const Text("DADOS CADASTRAIS"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(config.Colors.primary1),
                ),
                onPressed: _accessDisciplina,
                child: const Text("DISCIPLINAS"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(config.Colors.primary1),
                ),
                onPressed: () {},
                child: const Text("AO VIVO"),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'PDFs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Inserir seus widgets de PDF aqui
          ],
        ),
      ),
    );
  }
}
