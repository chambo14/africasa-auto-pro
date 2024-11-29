import 'package:africasa_mecano/core/components/dialog_alert.dart';
import 'package:africasa_mecano/core/components/network_error_dialog.dart';
import 'package:africasa_mecano/core/utils/check_network.dart';
import 'package:africasa_mecano/core/utils/strings.dart';
import 'package:africasa_mecano/profil_page.dart';
import 'package:africasa_mecano/provider/working_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DayPage extends ConsumerStatefulWidget {
  const DayPage({super.key, this.id});
  final int? id;

  @override
  ConsumerState<DayPage> createState() => _DayPageState();
}

class _DayPageState extends ConsumerState<DayPage> {
  late WorkingProvider _workingProvider = WorkingProvider();
  TextEditingController libelle = TextEditingController();
  TextEditingController horaire = TextEditingController();

  @override
  void initState() {
    _workingProvider = ref.read(workingProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilPage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Jour de travail", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500),),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                libelleField(),
                const SizedBox(height: 10,),
                horaireField(),
                const SizedBox(height: 30,),
                button()

              ],
            ),
          )),
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

  Widget button(){
    return InkWell(
      onTap: (){

        checkInfoLogin();
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
      await _workingProvider.working(mecanicienId: mecanicienId, libelle: libelle, horaire: horaire);

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

  checkInfoLogin(){
    if (libelle.text.isNotEmpty || horaire.text.isNotEmpty ) {


      daySubmit(widget.id!.toInt(), libelle.text, horaire.text,);

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
