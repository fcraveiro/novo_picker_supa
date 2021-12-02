import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase/supabase.dart';
import 'dart:io';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

String supabaseUrl = 'https://xrhyhsbetlnzksauwrvi.supabase.co';
String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODA3NTI4MywiZXhwIjoxOTUzNjUxMjgzfQ.gsz31qxeQ_h6R_93rthZwynvz1i8jNrXLz30JaFprqA';

class _InicioState extends State<Inicio> {
  SupabaseClient cliente = SupabaseClient(supabaseUrl, supabaseKey);

  List<String> arquivos = [];
  bool loading = true;
  bool uploading = false;
  double total = 0;
  var meupath = 'bucket/';

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();

    if (file != null) {
      File storedImage = File(file.path);
      meupath = '(bucket_id)';

      await cliente.storage
          .from('prontoodonto')
          .upload(file.name, storedImage)
          .then((value) {
        // ignore: avoid_print
        print('VOLTA DO BUCKET = $value');
      });

      // ignore: avoid_print
      print('STORED = $storedImage');
      // ignore: avoid_print
      print('PATH = ${file.path}');
      // ignore: avoid_print
      print('NAME = ${file.name}');
      // ignore: avoid_print
      print('File = $file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('aa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: pickAndUploadImage,
          )
        ],
      ),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}












//  Future<UploadTask> upload(String path) async {
//    File file = File(path);
//    try {
//      String ref = 'images/img-${DateTime.now().toString()}.jpg';
//      return storage.ref(ref).putFile(file);
//    } on FirebaseException catch (e) {
//      throw Exception('Erro no upload: ${e.code}');
//   }
//  }

  //loadImages() async {
  //  refs = (await storage.ref('images').listAll()).items;
  //  for (var ref in refs) {
  //    arquivos.add(await ref.getDownloadURL());
  //  }
  //  setState(() => loading = false);
  //}

  //deleteImage(int index) async {
  //  await storage.ref(refs[index].fullPath).delete();
  //  arquivos.removeAt(index);
  //  refs.removeAt(index);
  //  setState(() {});
  //}

 
