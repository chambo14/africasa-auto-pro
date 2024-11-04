import 'package:africasa_mecano/core/components/network_error_dialog.dart';
import 'package:africasa_mecano/menu_page.dart';
import 'package:africasa_mecano/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/components/dialog_alert.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';

class PasswordPage extends ConsumerStatefulWidget {
  const PasswordPage({super.key});

  @override
  ConsumerState<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends ConsumerState<PasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late PasswordProvider _passwordProvider = PasswordProvider();
  @override
  void initState() {
    _passwordProvider = ref.read(passwordProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            Text("Mot de passe", style: GoogleFonts.poppins(fontSize: 24, color: Colors.blue.shade600, fontWeight: FontWeight.w500),),
            Text("Cree ton mot de passe", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
            const SizedBox(height: 70,),
            passwordField(),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nouveau mot de passe", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
                newPasswordField(),
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Confirme le mot de passe", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
                confirmPasswordField(),
              ],
            ),
            const SizedBox(height: 40,),
            loginButton()
          ],
        ),
      )),
    );
  }
  Widget loginButton(){
    return InkWell(
      onTap: (){
        checkPassword();
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
  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre mot de passe';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Saisissez votre mot de passe",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
        prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
  Widget newPasswordField() {
    return TextFormField(
      controller: newPasswordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre mot de passe';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Saisissez votre mot de passe",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
        prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Svp entrez votre mot de passe';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Saisissez votre mot de passe",
        fillColor: Colors.white,
        filled: true,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
        suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
        prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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

  void passwordSubmit( String password, String new_password, String confirm_password) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _passwordProvider.changeP(password: password, new_password: new_password, confirm_password: confirm_password);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
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

  checkPassword(){
    if (passwordController.text.isNotEmpty || newPasswordController.text.isNotEmpty || confirmPasswordController.text.isNotEmpty) {


      passwordSubmit(passwordController.text, newPasswordController.text, confirmPasswordController.text);

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
