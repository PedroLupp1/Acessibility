/*import 'package:crob_project/main.dart';
import 'package:crob_project/pages/player.dart';
import 'package:crob_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

 
  @override
  PlayerListState createState() => PlayerListState();
}

class PlayerListState extends State<PlayerList> {
  late List<String> videoUrls;

  @override
  void initState() {
    super.initState();
    // Recupere os URLs dos vídeos com base nas informações da turma do aluno
  }

  Future<List<String>> getVideoUrlsForTurma(String alunoId, List<Map<String, dynamic>> grupo) async {
    final userId =  context.read<AuthService>().getUserUid();
    final aluno = await supabase.from('aluno').select('id_turma').eq('userId', userId ).execute();
    final turma = await supabase.from('turma').select('grupo').eq('id', aluno ).execute();
    final grupoData = await supabase
      .from('grupo')
      .select('educ1, educ2, educ3')
      .eq('id', turma)
      .execute();

  final educ1Id = grupoData.data[0]['educ1'];
  final educ2Id = grupoData.data[0]['educ2'];
  final educ3Id = grupoData.data[0]['educ3'];

  // Consulte a tabela 'conteudo' para obter URLs com base nos 3 IDs finais
  final urlData = await supabase
      .from('conteudo')
      .select('url')
      .in_('userid', [educ1Id, educ2Id, educ3Id])
      .execute();

  // Extraia os URLs da consulta
  final urls = urlData.data.map((row) => row['url'].toString()).toList();

  return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Aulas"),
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerWidget(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}*/