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
bool mudou = false;

//String nomeDaFoto = 'nova1';

class _InicioState extends State<Inicio> {
  SupabaseClient cliente = SupabaseClient(supabaseUrl, supabaseKey);

  bool loading = true;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
//    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//    XFile? image = await _picker.pickImage(source: ImageSource.camera);

//    final _picker = ImagePicker();

    final image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1500,
      maxHeight: 960,
    );

    return image;
  }

  testa(String myPath) async {
    File compressedFile = await FlutterNativeImage.compressImage(myPath,
        quality: 80, targetWidth: 220, targetHeight: 355);
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
      setState(() {
        mudou = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Histórico'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.upload),
              onPressed: pickAndUploadImage,
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 230,
                  height: 294,
                  color: Colors.grey.shade600,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.only(top: 70),
                  child: Center(
                      child: mudou
                          ? Image.network(
                              pathThumb,
                              width: 220,
                              height: 280,
                              fit: BoxFit.cover,
                            )
                          : const Text(
                              'Aguardando !!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                          primary: Colors.red.shade700, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: texto('SalvarI'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          pickAndUploadImage();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                          primary: Colors.green.shade700, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: texto('Câmera'),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          pickAndUploadImage();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                          primary: Colors.green.shade700, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: texto('Galeria'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  texto(String texto) {
    return SizedBox(
      width: 160,
      child: Text(
        texto,
        textAlign: TextAlign.center,
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
