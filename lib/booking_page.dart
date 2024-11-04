import 'package:africasa_mecano/client_page.dart';
import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/menu_page.dart';
import 'package:africasa_mecano/provider/list_appoint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
 late ListAppointProvider _listAppointProvider = ListAppointProvider();
 @override
  void initState() {
   _listAppointProvider = ref.read(appointsProvider);
   _listAppointProvider.getListAppointment();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const  HomePage()));}, icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade500,),),
        centerTitle: true,
        title: Text('Mes rendez-vous', style: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade500),),
      ),

      backgroundColor: Colors.white,

      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.only(left:20, right: 20, top: 30 ),
        child: Column(
          children: [
            ListAppoint()
          ],
        ),
      )),
    );
  }

  Widget ListAppoint(){
   return Consumer(builder: (context, ref, child){
     _listAppointProvider = ref.watch(appointsProvider);

     if (_listAppointProvider.appointMOdel == null) {
       // Retourne un loader pendant le chargement
       return Padding(
         padding: const EdgeInsets.all(170.0),
         child: NutsActivityIndicator(
           radius: 40,
           tickCount: 16,
           activeColor: Colors.blue.shade500,
           inactiveColor: Colors.grey.shade300,
           animationDuration: const Duration(milliseconds: 750),
           relativeWidth: 0.3,
         ),
       );
     }

     var data = _listAppointProvider.appointMOdel?.data;
     //print('la valeur de ce $data');
     if (_listAppointProvider.isLoading) {
       return Padding(
         padding: const EdgeInsets.all(170.0),
         child: NutsActivityIndicator(
           radius: 40,
           tickCount: 16,
           activeColor: Colors.blue.shade500,
           inactiveColor: Colors.grey.shade300,
           animationDuration: const Duration(milliseconds: 750),
           relativeWidth: 0.3,
         ),
       );
     }
     if (data!.isEmpty || data == null) {
       return Padding(
         padding: const EdgeInsets.only(top:250.0),
         child: Center(
           child: Column(
             children: [
               Icon(Icons.event_busy_outlined, size: 90,  color: Colors.grey.shade700),
               Text("Pas de rendez-vous",
                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500)),
               Text("pour l'instant!",
                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
             ],
           ),
         ),
       );
     }
     return SizedBox(
       height: 700,
       child: ListView.builder(
         itemCount: data.length,
         itemBuilder: (BuildContext context, int index) {
           var item = data[index];
           return Column(
             children: [
               Container(
                 height: 170,
                 width: 350,
                 padding: const EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey.shade100),
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.grey.shade100,
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Icon(
                       Icons.calendar_month,
                     ),
                     Container(
                       height: 40,
                       width: 90,
                       padding: const EdgeInsets.all(2),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.blue.shade500,
                       ),
                       child: Center(
                         child: Text(
                           item.status.toString() == "ACCEPTED" ? "Accepter" : "En attente",
                           style: GoogleFonts.poppins(
                             fontWeight: FontWeight.w500,
                             color: Colors.white,
                             fontSize: 14,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),

                 const SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         const SizedBox(width: 20,),
                         Text("Rendez-vous avec: ", style: GoogleFonts.poppins(fontSize: 13, ),),
                         const SizedBox(width: 2,),
                         Text(item.client.name.toString(), style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w800),),
                         const SizedBox(width: 2,),
                         Text(item.client.lastname.toString(), style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800),),

                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text("Heure de RDV :  ", style: GoogleFonts.poppins(fontSize: 13, ),),
                         Text(item.hourStartRdv.toString(), style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w700),),
                         Text("-", style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                         const SizedBox(width: 2,),
                         Text(item.hourEndRdv.toString(), style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700),),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         TextButton(onPressed: (){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ClientPage(data: item)));
                         }, child: Text("Voir plus", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400))),
                       ],
                     )
                   ],
                 ),
               ),
               const SizedBox(height: 10,)
             ],
           );
         },
       ),
     );
   });
 }
}
