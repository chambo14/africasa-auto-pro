import 'package:africasa_mecano/profil_page.dart';
import 'package:africasa_mecano/provider/update_profil_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';
import 'domain/models/update_profile_model.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController ville = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController cni = TextEditingController();
  late UpdateProfilProvider _uploadProfileProvider = UpdateProfilProvider();

  @override
  void initState() {
    _uploadProfileProvider = ref.read(updateProfileProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(
          children: [
            nameField(),
            const SizedBox(height: 20,),
            lastnameField(),
            const SizedBox(height: 20,),
            villeField(),
            const SizedBox(height: 20,),
            adresseField(),
            const SizedBox(height: 20,),
            cniField(),
            const SizedBox(height: 20,),
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
      controller: ville,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre ville';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre ville",
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
  Widget cniField() {
    return TextFormField(
      controller: cni,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ' entrez votre numero cni';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Entrez votre numero cni",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
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
        child: Center(child: Text("Se connecter", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
      ),
    );
  }

  void updateProfileSubmit( String name, String lastname, String ville, String adresse, String cni) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _uploadProfileProvider.updateProfile(name: name, lastname: lastname, ville: ville, adresse: adresse, num_cni: cni, );

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
    if (name.text.isNotEmpty || lastname.text.isNotEmpty || ville.text.isNotEmpty|| adresse.text.isNotEmpty || cni.text.isNotEmpty) {


      updateProfileSubmit(name.text, lastname.text , ville.text, adresse.text, cni.text);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(
            strings.codeSecret,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          )));
      // Navigator.pop(context);
    }
  }
}
