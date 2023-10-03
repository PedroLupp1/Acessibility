import 'package:flutter/material.dart';
import 'package:crob_project/config.dart' as config;
import 'package:form_validator/form_validator.dart';
import '../services/auth_service.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController localController = TextEditingController();

  late AuthService authService = AuthService();


  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }
  
  
  void _exit(){
    Navigator.popAndPushNamed(context, '/login');
  }
  
  final validator1 = ValidationBuilder(requiredMessage: 'Campo obrigatório')
      .email('Email ou Senha Inválidos')
      .maxLength(50)
      .build();
  final validator2 = ValidationBuilder(requiredMessage: 'Campo obrigatório')
      .maxLength(20)
      .build();
  
  bool showProgress = false;
  final bool _isObscure = true;

  
  Future<void> singUp(String email, String senha, String nome, String local) async {
    await authService.cadastrar(email, senha, nome, local);
    _exit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: SizedBox(
              width: 300,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/logoCrobTransparente.png'),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.text,
                      controller: emailController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Senha",
                      ),
                      obscureText:
                          !_isObscure, // Use the obscureText property with the _isObscure value
                      keyboardType: TextInputType.text,
                      controller: senhaController,
                    ),
                     TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nome Completo" 
                      ),
                      controller: nomeController,
                     ),
                      TextFormField(
                      decoration: const InputDecoration(
                       hintText: "Cidade",
                      ),
                      controller: localController,
                     ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            config.Colors.primary1), // Update with your desired color
                      ),
                      onPressed: () {
                        singUp(emailController.text, senhaController.text, nomeController.text, localController.text); // Update role as needed
                      },
                      child: const Text("Cadastrar"),
                    ),
                   
                    ),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(config
                            .Colors.primary1),
                      ),
                      onPressed: _exit,
                      child: const Text("Já possuo cadastro"),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
