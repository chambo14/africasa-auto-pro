import 'dart:io';

import 'package:africasa_mecano/profil_page.dart';
import 'package:africasa_mecano/provider/update_profil_provider.dart';
import 'package:africasa_mecano/provider/update_working_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';
import 'domain/models/update_profile_model.dart';
import 'provider/update_picture_provider.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key, this.id});
  final int? id;

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController speciality = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController libelle = TextEditingController();
  TextEditingController horaire = TextEditingController();
  late UpdateProfilProvider _uploadProfileProvider = UpdateProfilProvider();
  late UpdatePictureProvider _updatePictureProvider = UpdatePictureProvider();
  late UpdateWorkingProvider _updateWorkingProvider = UpdateWorkingProvider();

  @override
  void initState() {
    _uploadProfileProvider = ref.read(updateProfileProvider);
    _updatePictureProvider = ref.read(pictureProvider);
    _updateWorkingProvider = ref.read(updateWorkingProvider);
    super.initState();
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilPage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Modifier profil", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500),),
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // CircleAvatar for the image
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? Icon(Icons.person, size: 80, color: Colors.grey)
                      : null,
                ),

                // Positioned IconButton for overlay
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Colors.white
                    ),
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.blue.shade500,
                        size: 30,
                      ),
                      iconSize: 30,
                      color: Colors.blue,
                      splashRadius: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            nameField(),
            const SizedBox(height: 15,),
            lastnameField(),
            const SizedBox(height: 15,),
            villeField(),
            const SizedBox(height: 15,),
            adresseField(),
            const SizedBox(height: 15,),
            libelleField(),
            const SizedBox(height: 15,),
            horaireField(),
            const SizedBox(height: 25,),
            changeButton()
          ],
        ),
      )),
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre nom';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre nom",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.person,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  Widget lastnameField() {
    return TextFormField(
      controller: lastname,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre prenom';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre prenom",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.person,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  Widget villeField() {
    return TextFormField(
      controller: speciality,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre spécialité';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre spécialité",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.info_rounded,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  Widget adresseField() {
    return TextFormField(
      controller: adresse,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre adresse';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre adresse",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.pin_drop,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  Widget changeButton(){
    return InkWell(
      onTap: (){
        changeProfile();
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

  Widget libelleField() {
    return TextFormField(
      controller: libelle,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre jour';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Saisissez votre jour",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),

        prefixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  Widget horaireField(){
    return TextFormField(
      controller: horaire,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez vos heures de travail';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "00h-20h",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),

        prefixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade200,),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  void updateProfileSubmit( String name, String lastname, String speciality, String adresse) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _uploadProfileProvider.updateProfile(name: name, lastname: lastname, adresse: adresse, speciality: speciality, );

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {


        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ProfilPage()),
              (route) => false,
        );
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
  changeProfile(){
    if (name.text.isNotEmpty || lastname.text.isNotEmpty || speciality.text.isNotEmpty|| adresse.text.isNotEmpty || libelle.text.isNotEmpty || horaire.text.isNotEmpty) {

      updateProfileSubmit(name.text, lastname.text , speciality.text, adresse.text,);
      daySubmit(widget.id!.toInt(), libelle.text, horaire.text);

      if (_imageFile != null) {
        uploadSubmit(_imageFile!); // Call image upload function if an image is selected
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(
            'Veuillez remplir les champs obligatoires et sélectionner une image.',
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          )));
    }
  }

  void daySubmit( int mecanicienId, String libelle, horaire) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _updateWorkingProvider.working(mecanicienId: mecanicienId, libelle: libelle, horaire: horaire);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ProfilPage()),
              (route) => false,
        );
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
  // void changeProfile() {
  //   if (name.text.isNotEmpty || lastname.text.isNotEmpty || ville.text.isNotEmpty || adresse.text.isNotEmpty || cni.text.isNotEmpty || _imageFile != null) {
  //     // Proceed with profile update submission
  //     updateProfileSubmit(name.text, lastname.text, ville.text, adresse.text, cni.text);
  //
  //     // If an image is selected, upload it as well
  //     if (_imageFile != null) {
  //       uploadSubmit(_imageFile!); // Call image upload function if an image is selected
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: const Duration(seconds: 3),
  //         content: Text(
  //           'Veuillez remplir les champs obligatoires et sélectionner une image.',
  //           style: GoogleFonts.poppins(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //               color: Colors.white),
  //         )));
  //   }
  // }
  void uploadSubmit( File picture) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _updatePictureProvider.updatePicture(picture: picture);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
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
      uploadSubmit(_imageFile!);
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
