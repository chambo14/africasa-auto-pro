import 'package:africasa_mecano/detail_operation_page.dart';
import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/provider/list_operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import 'menu_page.dart';

class GestionPage extends ConsumerStatefulWidget {
  const GestionPage({super.key});

  @override
  ConsumerState<GestionPage> createState() => _GestionPageState();
}

class _GestionPageState extends ConsumerState<GestionPage> {
  late ListOperationProvider _listOperationProvider = ListOperationProvider();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      _listOperationProvider = ref.read(listOperationProvider);
      _listOperationProvider.getListOperation();

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Gestion", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              Operation()
            ],
          ),
        ),
      ),
    );
  }
  Widget Operation(){
    return Consumer(builder: (context, ref, child){
      _listOperationProvider = ref.watch(listOperationProvider);

      _listOperationProvider.listOperationModel!.data!.allOperations.sort((a, b) => b.createdAt.compareTo(a.createdAt),);
      if (_listOperationProvider.listOperationModel == null) {
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

      var data = _listOperationProvider.listOperationModel?.data;
      //print('la valeur de ce $data');
      if (_listOperationProvider.isLoading || data == null) {
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
      if (data.allOperations.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top:250.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.event_busy_outlined, size: 90,  color: Colors.grey.shade700),
                Text("Pas de transactions",
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
          itemCount: data.allOperations.length > 40 ? 40 : data.allOperations.length ,
          itemBuilder: (BuildContext context, int index) {
            var item = data.allOperations[index];
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailOperationPage(response: data)));
                  },
                  child: RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      // Replace this delay with the code to be executed during refresh
                      // and return a Future when code finishes execution.
                      return Future<void>.delayed(const Duration(seconds: 3));
                    },
                    child: Container(
                      height: 130,
                      width: 350,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100,
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Type operation: ', style: GoogleFonts.poppins(fontSize: 15, color: Colors.blue.shade700),),
                              Text(item.typeOperation.toString(), style: GoogleFonts.poppins(fontSize: 15,),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text('Date: ', style: GoogleFonts.poppins(fontSize: 15, color: Colors.blue.shade700),),
                              Text(DateFormat('yyyy-mm-dd').format(item.dateOperation), style: GoogleFonts.poppins(fontSize: 15,),),

                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text('Reference: ', style: GoogleFonts.poppins(fontSize: 15,color: Colors.blue.shade700),),
                              Text(item.motif.toString(), style: GoogleFonts.poppins(fontSize: 15,),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text("Montant: ", style: GoogleFonts.poppins(fontSize: 15, color: Colors.blue.shade700),),
                              Text(item.amount.toString(), style: GoogleFonts.poppins(fontSize: 15),),
                              const SizedBox(width: 2,),
                              Text("FCFA", style: GoogleFonts.poppins(fontSize: 15),),
                            ],
                          ),
                          const SizedBox(height: 5,),

                        ],
                      ),
                    ),
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
