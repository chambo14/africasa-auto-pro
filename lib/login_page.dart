import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/password_forgot_page.dart';
import 'package:africasa_mecano/password_page.dart';
import 'package:africasa_mecano/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';
import 'domain/shared_preferences.dart';
import 'menu_page.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LoginPhoneController _loginPhoneController = LoginPhoneController();
  String initialCountry = 'CI';
  FocusNode focusNode = FocusNode();
  bool _isObscured = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      _loginPhoneController = ref.read(loginControllerProvider);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Image.asset("assets/logo.png"),
              Text("Connecte-toi avec ton numero de telephone", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70,),
              contactField(),
              const SizedBox(height: 20,),
              passwordField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PasswordForgotPage()));
                  }, child: Text("Mot de passe oublié?", style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              loginButton()
            ],
          ),
        ),
      ),
    );
  }
  Widget loginButton(){
    return InkWell(
      onTap: (){
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PasswordPage()));
        checkInfoLogin();
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
  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isObscured,
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
        suffixIcon: IconButton(onPressed: (){
          setState(() {
            _isObscured = !_isObscured; // Alterner la visibilité
          });
        },icon:Icon( _isObscured ? Icons.visibility_off : Icons.visibility,)),
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


  Future<String> loadFromJson() async {
    return await rootBundle.loadString('assets/countries/country_list_en.json');
  }

  void loginSubmit( String login, String password) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _loginPhoneController.login(login: login, password: password);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("tokens", dataResponse.data?.token ?? "");
        //SharedPreferencesServices.saveToken(dataResponse.token ?? "");
        if (dataResponse.data != null) {
          SharedPreferencesServices.saveUser(dataResponse.data!);
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
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

  checkInfoLogin(){
    if (contactController.text.isNotEmpty || passwordController.text.isNotEmpty ) {


      loginSubmit(contactController.text, passwordController.text);

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
