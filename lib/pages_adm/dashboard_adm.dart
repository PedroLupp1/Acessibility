import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config.dart' as config;

class DashBoardAdm extends StatefulWidget {
  const DashBoardAdm({super.key});

  @override
  State<DashBoardAdm> createState() => _DashBoardAdmState();
}

class _DashBoardAdmState extends State<DashBoardAdm> {
 
   final List<String> imgList = [
    "images/playIcon.png", 
    "images/playIcon.png",
    "images/playIcon.png",
    "images/playIcon.png",
    "images/playIcon.png",            
  ];
 
 void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }

  void _accessTurmas() {
    _redirecionarParaTela('/turmas');
  }
  void _accessUpload(){
    _redirecionarParaTela('/upload');
    final sexo = AuthService().getUserUid();
    print(sexo);    
  }
  void navigation(){
    GoRouter.of(context).pushReplacement('/');
}
  Future<void> _exit(BuildContext context) async {
    print("merda");
    await context.read<AuthService>().logout();
    print("bosta");
    navigation();
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
        body: SingleChildScrollView(
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
                         hoverColor: config.Colors.primary2, 
                        isSelected: true,
                        onTap: () {},
                        title: 'Home',
                        icon: const Icon(Icons.home),
                      ),
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
                        highlightSelectedColor: config.Colors.primary2,
                        hoverColor: config.Colors.primary3,
                        isSelected: false,
                        onTap: _accessTurmas,
                        title: 'Turmas',
                        icon: const Icon(Icons.person),
                      ),
                      SideMenuItemDataTile(
                        margin: const EdgeInsetsDirectional.only(top: 7, bottom: 7),
                        titleStyle: const TextStyle(color: config.Colors.primary2),
                        selectedTitleStyle: const TextStyle(color: config.Colors.primary1),
                        highlightSelectedColor: config.Colors.primary2,
                        hoverColor: config.Colors.primary3,
                        isSelected: false,
                        onTap: _accessUpload,
                        title: 'Material',
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
                        onTap: (){
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text('Continue assistindo:'),
                            Container(
                              margin: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.255,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    pauseAutoPlayOnTouch: true,
                                    height: MediaQuery.of(context).size.height * 0.3,
                                    autoPlay: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                  ),
                                  items: imgList.map((String imagePath) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          margin: const EdgeInsets.symmetric(horizontal: 0.1),
                                          decoration: const BoxDecoration(
                                              color: config.Colors.primary2),
                                          child: Image(
                                            image: AssetImage(imagePath),
                                            fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 300,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
  }

}