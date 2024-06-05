import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final SupabaseClient _supabaseClient = SupabaseClient(
  'https://ojysjtnqtdiosnarcfxm.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
  schema: 'public',
);

class MidiaService extends ChangeNotifier {
  Future<void> pickAndUploadFile(String userId, BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final fileName = file.name;
        final fileBytes = file.bytes;
        const uuid = Uuid();
        final fileId = uuid.v4();
        final fileSex = file.extension;
        final penis = '$fileId.${fileSex!}';
       
        if (fileBytes != null && userId.isNotEmpty) {
          await _supabaseClient.storage
              .from('aula')
              .uploadBinary('/$userId/$penis', fileBytes);
          
          
          final res =
            _supabaseClient.storage.from('aula').getPublicUrl('$userId/$penis');
          if(res.isNotEmpty){
             isSuccess;
          }

          final resData = res.toString();
          await _supabaseClient.from('conteudo').insert([
          {'id': fileId, 'nome': fileName, 'userId': userId, 'url': resData},
          ]).execute();
          
        
        
        } else {
          print('Os bytes do arquivo ou o ID do usuário estão vazios.');
        }
      }
    } catch (e) {
      print(e);
    }
  }
  void isSuccess(context){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Arquivo enviado com sucesso!")));
  }
}
