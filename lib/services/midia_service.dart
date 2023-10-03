import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';


final SupabaseClient _supabaseClient = SupabaseClient(
    'https://ojysjtnqtdiosnarcfxm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qeXNqdG5xdGRpb3NuYXJjZnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2MjU3MjksImV4cCI6MjAxMDIwMTcyOX0.pfELcLPTN0-OgrsCVcXQ27NfhHiH6SsS1aDxtwoHDSM',
    schema: 'public',
  );

  Future<String?> getUser () async{

  try {
    final usuario = _supabaseClient.auth.currentUser;
    if (usuario != null) {
      final userId = usuario.id.toString();
 }
 } catch (e){
  print("wiqdnjsokpd");
 }
 return "sexo";
 }
 

class MidiaService extends ChangeNotifier {
 

Future<void> pickAndUploadFile() async {
  try {
    
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    print(result);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final fileName = file.name;
      final fileBytes = file.bytes;
      final userId = await getUser(); 
      if (fileBytes != null && userId != null) {
        await _supabaseClient.storage.from('aula').uploadBinary(
          '/turma/$userId',
          fileBytes,
        );
        print(userId);
        print('Arquivo enviado com sucesso!');
      } else {
        print('Os bytes do arquivo ou o ID do usuário estão vazios.');
      }
    }
  } catch (e) {
    print(e);
  }
}


}