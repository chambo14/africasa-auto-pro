import 'package:africasa_mecano/password_page.dart';
import 'package:africasa_mecano/provider/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import 'core/utils/colors_util.dart';
import 'login_page.dart';

class InfoPage extends ConsumerStatefulWidget {
  const InfoPage({super.key});

  @override
  ConsumerState<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends ConsumerState<InfoPage> {
  late LogoutUserProvider _logoutUserProvider;

  @override
  void initState() {
    _logoutUserProvider = ref.read(logoutProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text("Mes informations", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500),),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  logout();
                },
                child:  ListTile(
                  leading: Icon(Icons.logout, color: Colors.blue.shade300),
                  title: Text('Se deconnecter', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal)),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PasswordPage()));
                },
                child: ListTile(
                  leading:  Icon(Icons.lock, color: Colors.blue.shade300),
                  title: Text('Modifier mot de passe', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal)),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: (){
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PasswordPage()));
                },
                child:  ListTile(
                  leading: Icon(Icons.book_outlined, color: Colors.blue.shade300,),
                  title: Text("Carnet d'entretien", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void logout() async {
    try {
      // Affiche le dialogue de chargement
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Déconnexion en cours...",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: ColorsUtil.black,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                NutsActivityIndicator(
                  radius: 40,
                  tickCount: 16,
                  activeColor: Colors.blue.shade700,
                  inactiveColor: Colors.grey.shade300,
                  animationDuration: const Duration(milliseconds: 750),
                  relativeWidth: 0.3,
                ),
              ],
            ),
          );
        },
      );

      // Exécute la déconnexion
      var response = await _logoutUserProvider.logoutUser();

      if (response == null) {
        Navigator.of(context).pop(); // Ferme le dialogue
        return;
      }

      // Vérifie le succès de la réponse
      if (response.success == true) {
        Navigator.of(context).pop(); // Ferme le dialogue
        await Future.delayed(Duration(milliseconds: 300)); // Ajoute un léger délai
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      } else {
        throw Exception(response.message.toString());
      }
    } catch (e) {
      Navigator.of(context).pop(); // Ferme le dialogue si une erreur survient
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
