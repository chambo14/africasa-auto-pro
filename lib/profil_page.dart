import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/provider/info_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilPage extends ConsumerStatefulWidget {
  const ProfilPage({super.key});

  @override
  ConsumerState<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends ConsumerState<ProfilPage> {
  late UserInfoProvider _userInfoProvider = UserInfoProvider();
  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      _userInfoProvider = ref.read(userProvider);
      _userInfoProvider.infoUserConnected();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Mon profil", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Consumer(
            builder: (context,ref, child) {
              _userInfoProvider = ref.watch(userProvider);
              var infoClient= _userInfoProvider.userInfoModel?.data;
              if(infoClient==null){
                return const Center(child: CircularProgressIndicator(),);
              }
              return Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image:  DecorationImage(
                        image: NetworkImage(infoClient.profilPic!= null && infoClient.profilPic.isNotEmpty?infoClient.profilPic.toString(): 'https://via.placeholder.com/150'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(70),
                    ),

                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("Nom:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal),),
                      const SizedBox(width: 10,),
                      Text(infoClient.name.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Prenoms:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.lastname.toString(),  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Email:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.email.toString(),  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Contact:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.contact.toString(),  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),

                  Row(
                    children: [
                      Text("Professionnel:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.mecanicien!.speciality.toString(),  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
