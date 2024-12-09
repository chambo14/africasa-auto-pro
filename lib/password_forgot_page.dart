import 'package:africasa_mecano/provider/password_forgot_provider.dart';
import 'package:africasa_mecano/reset_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';

class PasswordForgotPage extends ConsumerStatefulWidget {
  const PasswordForgotPage({super.key});

  @override
  ConsumerState<PasswordForgotPage> createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends ConsumerState<PasswordForgotPage> {
  TextEditingController contactController = TextEditingController();
  late PasswordForgotProvider _passwordForgotProvider = PasswordForgotProvider();
  String initialCountry = 'CI';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _passwordForgotProvider = ref.read(forgotProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15,right: 15, top: 30),
          child: Column(
            children: [
              Image.asset("assets/africasaPro.png"),
              Text("J'ai oublié mon mot de passe", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),),
              const SizedBox(height: 70,),
              contactField(),
              const SizedBox(height: 30,),
              passwordButton()
            ],
          ),
        ),
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
        child: Center(child: Text("Envoyer", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
      ),
    );
  }
  void forgotSubmit( String contact) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _passwordForgotProvider.forgot(contact: contact);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  ResetPage(token: dataResponse.data!.token.toString(),)),
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
    if (contactController.text.isNotEmpty ) {


      forgotSubmit(contactController.text);

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
