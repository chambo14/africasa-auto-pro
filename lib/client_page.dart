import 'package:africasa_mecano/booking_page.dart';
import 'package:africasa_mecano/core/components/network_error_dialog.dart';
import 'package:africasa_mecano/domain/models/approve_model.dart';
import 'package:africasa_mecano/provider/approve_provider.dart';
import 'package:africasa_mecano/provider/detail_appointment_model.dart';
import 'package:africasa_mecano/provider/refused_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/components/dialog_alert.dart';
import 'core/utils/check_network.dart';
import 'core/utils/strings.dart';
import 'domain/models/appoint_model.dart';

class ClientPage extends ConsumerStatefulWidget {
  const ClientPage({super.key,  this.id});
 // final Datum data;
 final int? id;

  @override
  ConsumerState<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends ConsumerState<ClientPage> {
  late DetailAppointmentProvider _detailAppointmentProvider = DetailAppointmentProvider();
  late ApproveProvider _approveModel = ApproveProvider();
  late RefusedProvider _refusedProvider = RefusedProvider();
  final String number = '+2250505544432';

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      _detailAppointmentProvider = ref.read(detailAppointmentProvider);
      _approveModel = ref.read(approveProvider);
      _refusedProvider = ref.read(refusedProvider);
      _detailAppointmentProvider.infoAppointment(
          id: widget.id!.toInt());
    });
    super.initState();
  }
  Future<void> _launchPhoneApp(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

   try{
     if (await canLaunchUrl(phoneUri)) {
       await launchUrl(phoneUri);
     } else {
       throw 'Impossible de lancer l\'appel vers $phoneNumber';
     }
   }catch(e){
     debugPrint('Exception : $e');
   }
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer(
      builder: (context, ref, child) {
        _detailAppointmentProvider =
            ref.watch(detailAppointmentProvider);
        var info = _detailAppointmentProvider.detailAppointment;

        if (info == null || info.data == null|| info.data!.appointment == null ) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const  BookingPage()));}, icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade500,),),
            title: Text('Voir le client', style: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade500),),
           centerTitle: true,
            actions: [
              InkWell(
                onTap: (){
                  checkRef();
                },
                child: IconButton(
                  onPressed: (){
                     _launchPhoneApp( '+225${info.data!.appointment.client.contact}' );
                   // _launchPhoneApp( number );
                  },
                  icon: Icon(Icons.phone, color: Colors.blue.shade400,),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Nom :",  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade600)),
                      const SizedBox(width: 10,),
                      Text(info.data!.appointment.client.name.toString(),  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                      const SizedBox(width: 5,),
                      Text(info.data!.appointment.client.lastname.toString(),  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Contact :",  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade600)),
                      const SizedBox(width: 10,),
                      Text(info.data!.appointment.client.contact.toString(),  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Date de rendez-vous :",  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade600)),
                      const SizedBox(width: 10,),
                      Text(
                        DateFormat('dd-MM-yyyy').format(info.data!.appointment.dateRdv),
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Heure de rendez-vous :",  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade600)),
                      const SizedBox(width: 10,),
                      Text(info.data!.appointment.hourStartRdv.toString(),  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                      const SizedBox(width: 5,),
                      // Text("-", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                      // const SizedBox(width: 5,),
                      // Text(info.data!.appointment.hourEndRdv.toString(),  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade900)),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(
                        onTap: (){
                          checkRef();
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red.shade300
                          ),
                          child:  Center(child: Text("Annuler",  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white))),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          checkApprove();
                        },
                        child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade300
                            ),
                            child:  Center(child: Text("Valider",  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white)),
                            )),
                      ),

                    ],
                  ),


                ],
              )
              ,
            ),
          ),
        );
      }
    );
  }
  void approveSubmit( int id) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _approveModel.approve(id: id);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BookingPage()),
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

  void refusedSubmit( int id) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _refusedProvider.refused(id: id);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BookingPage()),
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
  checkApprove(){
    ref.watch(detailAppointmentProvider);
    var info = _detailAppointmentProvider.detailAppointment;
    if (info!= null || info?.data != null|| info?.data!.appointment != null) {


      approveSubmit(info!.data!.appointment.id.toInt());

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

  checkRef(){
    ref.watch(detailAppointmentProvider);
    var info = _detailAppointmentProvider.detailAppointment;
    if (info!= null || info?.data != null|| info?.data!.appointment != null) {


      refusedSubmit(info!.data!.appointment.id.toInt());

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
