import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

var dnow = DateTime.now();
var formatter = DateFormat('yyyy.MM.dd.hh.mm.ss');
var nomeFoto = 'id1' + formatter.format(dnow) + '.jpg';
var pathFoto = '';
var pathServidor = '';
var pathThumb = '';
File thumbs = '' as File;

//String nomeDaFoto = 'nova1';

class _InicioState extends State<Inicio> {
  SupabaseClient cliente = SupabaseClient(supabaseUrl, supabaseKey);

  bool loading = true;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
//    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  testa(String myPath) async {
    File compressedFile = await FlutterNativeImage.compressImage(myPath,
        quality: 80, targetWidth: 250, targetHeight: 160);
    thumbs = compressedFile;
  }

  gravaFoto(nomeDaFoto, storedImage) async {
    await cliente.storage.from('pronto').upload(nomeDaFoto, storedImage).then(
      (value) {
        var response = cliente.storage.from('pronto').getPublicUrl(nomeDaFoto);
        pathFoto = response.data.toString();
      },
    );
  }

  pickAndUploadImage() async {
    var dnow = DateTime.now();
    var formatter = DateFormat('yyyy.MM.dd.hh.mm.ss');
    var nomeFoto = 'id1' + formatter.format(dnow) + '.jpg';
    XFile? file = await getImage();
    if (file != null) {
      var nomeDaFoto = nomeFoto;
      File storedImage = File(file.path);
      await gravaFoto(nomeDaFoto, storedImage);
      pathServidor = pathFoto;
      await testa(file.path.toString());

      // ignore: avoid_print
      print('Path do Servidor : $pathServidor');
      nomeDaFoto = 'thumb-' + nomeDaFoto;
      await gravaFoto(nomeDaFoto, thumbs);
      pathThumb = pathFoto;
      // ignore: avoid_print
      print('Path da Thumb : $pathThumb');
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
      body: Text(pathServidor),
    );
  }

  texto(teste) {
    Text(
      teste,
      style: const TextStyle(
        color: Colors.black,
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

 
 /*
       // ignore: avoid_print
      print('STORED = $storedImage');
      // ignore: avoid_print
      print('PATH = ${file.path}');
      // ignore: avoid_print
      print('NAME = ${file.name}');
      // ignore: avoid_print
      print('File = $file');

        // ignore: avoid_print
        print('VOLTA DO BUCKET TESTE = ${teste.data}');

        // ignore: avoid_print
        print('VOLTA DO BUCKET 1 = $value');
        // ignore: avoid_print
        print('VOLTA DO BUCKET 2 = ${value.data.toString()}');
        // ignore: avoid_print
        print('VOLTA DO BUCKET 2 = ${value.data.toString()}');
        // ignore: avoid_print
        print('STORED = $storedImage');
        // ignore: avoid_print
        print('PATH = ${file.path}');
        // ignore: avoid_print
        print('NAME = ${file.name}');
        // ignore: avoid_print
        print('File = $file');




    // ignore: avoid_print
    print('.');
    // ignore: avoid_print
    print('Atual Height : ${properties.height}');
    // ignore: avoid_print
    print('Atual Width : ${properties.width}');
    // ignore: avoid_print
    print('Atual Height : ${properties2.height}');
    // ignore: avoid_print
    print('Atual Width : ${properties2.width}');
    // ignore: avoid_print
    print('Atual Width : ${compressedFile.path}');
    // ignore: avoid_print
    print('.');


*/
