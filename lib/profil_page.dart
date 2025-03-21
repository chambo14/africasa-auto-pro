import 'package:africasa_mecano/Day_page.dart';
import 'package:africasa_mecano/Update_profile_page.dart';
import 'package:africasa_mecano/catalogue_page.dart';
import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/list_catalogue_page.dart';
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
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade300,
                    child: ClipOval(
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/icon/logoF.png'),
                        image: infoClient.profilPic != null && infoClient.profilPic.isNotEmpty
                            ? NetworkImage(infoClient.profilPic)
                            : const NetworkImage('https://via.placeholder.com/150'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          );
                        },
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("Nom:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal),),
                      const SizedBox(width: 10,),
                      Text(infoClient.name.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Prenoms:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Flexible(child: Text(infoClient.lastname.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal, color: Colors.blue.shade500)))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Email:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Flexible(child: Text(infoClient.email.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal, color: Colors.blue.shade500)))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Contact:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.contact.toString(),  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),

                  Row(
                    children: [
                      Text("Professionnel:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal)),
                      const SizedBox(width: 10,),
                      Text(infoClient.mecanicien!.speciality.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, fontStyle: FontStyle.normal, color: Colors.blue.shade500))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UpdateProfilePage(id: infoClient.mecanicien!.id.toInt() ,)));
                    },
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade500,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Modifier mon profil", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListCataloguePage(id:infoClient.mecanicien!.id.toInt() )));
                    },
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade500,)
                      ),
                      child: Center(child: Text("Catalogue", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.blue.shade500),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DayPage(id:infoClient.mecanicien!.id.toInt() )));
                    },
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade500,)
                      ),
                      child: Center(child: Text("Jour de travail", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.blue.shade500),)),
                    ),
                  )

                ],
              );
            }
          ),
        ),
      ),
    );
  }

  // Widget button(){
  //   return InkWell(
  //     onTap: (){
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UpdateProfilePage(id: infoClient.mecanicien!.id.toInt() ,)));
  //     },
  //     child: Container(
  //       height: 50,
  //       width: 320,
  //       decoration: BoxDecoration(
  //           color: Colors.blue.shade500,
  //           borderRadius: BorderRadius.circular(10)
  //       ),
  //       child: Center(child: Text("Modifier mon profil", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),)),
  //     ),
  //   );
  // }


}
