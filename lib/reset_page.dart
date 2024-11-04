import 'package:africasa_mecano/domain/models/password_model.dart';
import 'package:africasa_mecano/login_page.dart';
import 'package:africasa_mecano/provider/reset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';

class ResetPage extends ConsumerStatefulWidget {
  const ResetPage({super.key, required this.token});
 final String token;
  @override
  ConsumerState<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends ConsumerState<ResetPage> {
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  late ResetProvider _resetProvider = ResetProvider();
  String initialCountry = 'CI';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _resetProvider = ref.read(resetProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15,right: 15, top: 20),
          child: Column(
            children: [
              Image.asset("assets/logo.png"),
              Text("J'ai oublié mon mot de passe", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
              const SizedBox(height: 45,),
              contactField(),
              const SizedBox(height: 15,),
              passwordField(),
              const SizedBox(height: 15,),
              passwordConfirmField(),
              const SizedBox(height: 35,),
              passwordButton()
            ],
          ),
        ),
      ),
    );
  }
  Widget passwordButton(){
    return InkWell(
      onTap: (){
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PasswordPage()));
        checkInfo();
      },
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
            color: Colors.blue.shade500,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text("Modifier", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
      ),
    );
  }
  Widget contactField() {
    return IntlPhoneField(
      controller: contactController,
      focusNode: focusNode,
      initialCountryCode: 'CI',
      decoration: InputDecoration(
        hintText: "Entrez votre contact",
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w300),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      languageCode: "en",
      onChanged: (phone) {
        print(phone.completeNumber);
      },
      onCountryChanged: (country) {
        print('Country changed to: ' + country.name);
      },
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
  Widget passwordConfirmField() {
    return TextFormField(
      controller: passwordConfirmController,
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

  void forgotSubmit( String contact, token, password, confirm_password) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _resetProvider.forgot(contact: contact, token: token, password: password, confirm_password: confirm_password);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  LoginPage()),
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

  checkInfo(){
    if (contactController.text.isNotEmpty|| passwordController.text.isNotEmpty|| passwordConfirmController.text.isNotEmpty ) {


      forgotSubmit(contactController.text, widget.token.toString(), passwordController.text, passwordConfirmController.text);

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
