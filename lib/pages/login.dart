import 'package:crob_project/main.dart';
import 'package:crob_project/services/midia_service.dart';
import 'package:flutter/material.dart';
import 'package:crob_project/config.dart' as config;
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crob_project/services/auth_service.dart';


class LoginAcessibility extends StatefulWidget {
  LoginAcessibility({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<LoginAcessibility> createState() => _LoginAcessibilityState();
}

class _LoginAcessibilityState extends State<LoginAcessibility> {
    
    final SupabaseClient _supabaseClient = SupabaseClient(
    'https://ojysjtnqtdiosnarcfxm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
  );

  final _formKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  final validator1 = ValidationBuilder(requiredMessage: 'Campo obrigatório')
      .email('Email ou Senha Inválidos')
      .maxLength(50)
      .build();
  final validator2 = ValidationBuilder(requiredMessage: 'Campo obrigatório')
      .maxLength(20)
      .build();

  void _cadastrar() {
   GoRouter.of(context).push('/cadastro');
  }
    void _redirecionarParaTela(String rota) {
  GoRouter.of(context).pushReplacement(rota);
  }



Future<void> _fazerLogin(String email, String senha) async {
  final authService = context.read<AuthService>();

  await authService.login(email, senha);

  final role = await authService.getUserRole();
  authService.getUserUid();
  if (role == 'admin') {
    _redirecionarParaTela('/dashboardadm');
  } else if (role == 'user_comum') {
    _redirecionarParaTela('/dashboard');
  } else if (role == 'ger'){
    _redirecionarParaTela('/dashboardger');
  }
}


Future<String> getSenhaUser() async {
  final response = await supabase
      .from('user') 
      .select('senha') 
      .single()
      .execute();

  if (response.status == 200) {
    final senha = response.data?[0]['senha'] as String;
    return senha;
  } else {
   final errorMessage = response.data!.message;
    throw Exception('Falha ao obter a senha do Supabase: $errorMessage');
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: SizedBox(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/logo-pim.png'),
                      TextFormField(
                        validator: validator1,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        keyboardType: TextInputType.text,
                        controller: loginController,
                      ),
                      TextFormField(
                        validator: validator2,
                        decoration: const InputDecoration(
                          hintText: "Senha",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: senhaController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          elevation: 18.0,
                          color: config.Colors.primary1,
                          child: MaterialButton(
                            onPressed: () {
                              _fazerLogin(loginController.text, senhaController.text );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Senha Incorreta!")),
                              );
                            },
                            child: const Text("Login",
                            style: TextStyle(color: config.Colors.primary2),),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _cadastrar,
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(config.Colors.primary1),
                          shadowColor:
                              MaterialStatePropertyAll(config.Colors.primary2),
                          textStyle: MaterialStatePropertyAll(
                              TextStyle(color: config.Colors.primary4)),
                        ),
                        child: const Text(
                          "Não possui uma conta? Cadastre-se!",
                          style: TextStyle(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /*Row(
                        children: [
                          Checkbox(
                            activeColor: config.Colors.primary1,
                            checkColor: config.Colors.primary2,
                            value: _rememberLogin,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberLogin = value ?? false;
                              });
                            },
                          ),
                          const Text("Manter-me Conectado"),
                        ],
                      ),*/
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
