import 'dart:io';

import 'package:africasa_mecano/core/components/dialog_alert.dart';
import 'package:africasa_mecano/core/components/network_error_dialog.dart';
import 'package:africasa_mecano/core/utils/check_network.dart';
import 'package:africasa_mecano/list_catalogue_page.dart';
import 'package:africasa_mecano/provider/catalogue_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'profil_page.dart';

class CataloguePage extends ConsumerStatefulWidget {
  const CataloguePage({super.key, this.id});
  final int? id;

  @override
  ConsumerState<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends ConsumerState<CataloguePage> {
  late CatalogueProvider _catalogueProvider = CatalogueProvider();

  File? _imageFile; // Pour stocker l'image sélectionnée

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image : $e');
    }
  }

  @override
  void initState() {
    _catalogueProvider = ref.read(catalogueProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        title: Text('Ajout Catalogue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200, // Couleur par défaut
                        image: _imageFile != null
                            ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                            : null,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _imageFile == null
                          ? const Icon(Icons.image, size: 80, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.blue.shade500,
                            size: 30,
                          ),
                          iconSize: 30,
                          splashRadius: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                changeButton()
              ],
            ),)),
    );
  }

  Widget changeButton(){
    return InkWell(
      onTap: (){
        checkUpload();
      },
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
            color: Colors.blue.shade500,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text("Valider", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
      ),
    );
  }

  void uploadSubmit(int mecanicienId, File picture) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _catalogueProvider.updloadCatalogue(mecanicienId: mecanicienId, fichier:picture);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ListCataloguePage()),
              (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(dataResponse.message.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(dataResponse.message.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))));
        //codePin.clear();
        Navigator.of(context).pop();
      }
    }


    else {
      showDialog(
          context: context, builder: (context) => const NetworkErrorDialog());
    }
  }

  void checkUpload() {
    if (_imageFile != null ) {
      uploadSubmit(widget.id!.toInt(), _imageFile!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Veuillez sélectionner une photo",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ),
      );
    }
  }
}
