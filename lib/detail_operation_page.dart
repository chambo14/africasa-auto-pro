import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:africasa_mecano/gestion_page.dart';
import 'package:africasa_mecano/provider/detail_operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOperationPage extends ConsumerStatefulWidget {
  const DetailOperationPage({super.key, required this.response});
  final Data response;

  @override
  ConsumerState<DetailOperationPage> createState() => _DetailOperationPageState();
}

class _DetailOperationPageState extends ConsumerState<DetailOperationPage> {
  late DetailOperationProvider _detailOperationProvider = DetailOperationProvider();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _detailOperationProvider= ref.read(detailOperationProvider);
      _detailOperationProvider.infoOperation(
          id: widget.response.allOperations.first.id.toInt());
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const GestionPage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Detail transaction", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500),),
      ),
     body: SafeArea(
       child: SingleChildScrollView(
         padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
         child: Consumer(
           builder: (context, ref, child) {
             _detailOperationProvider =
                 ref.watch(detailOperationProvider);
             var info = _detailOperationProvider.infoMecanoModel;
             if (info == null || info.data == null || info.data!.operation == null) {
               return const Center(child: CircularProgressIndicator());
             }
             return Column(
               children: [
                 Container(
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Text("Type de transaction", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.typeOperation.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700))
                         ],
                       ),
                       Row(
                         children: [
                           Text("Reference:", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.reference.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700))
                         ],
                       ),
                       Row(
                         children: [
                           Text("Date de transaction:", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.dateOperation.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700))
                         ],
                       ),
                       Row(
                         children: [
                           Text("Transaction:", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.libelle.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700))
                         ],
                       ),
                       Row(
                         children: [
                           Text("Motif:", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.motif.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700))
                         ],
                       ),
                       Row(
                         children: [
                           Text("Montant:", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                           const SizedBox(width: 10,),
                           Text(info.data!.operation.amount.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700)),
                           Text("FCFA:", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.grey.shade700)),
                         ],
                       ),
                     ],
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
}
