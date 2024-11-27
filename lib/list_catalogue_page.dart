import 'package:africasa_mecano/catalogue_page.dart';
import 'package:africasa_mecano/domain/models/liste_catalogue_model.dart';
import 'package:africasa_mecano/profil_page.dart';
import 'package:africasa_mecano/provider/delete_catalogue_provider.dart';
import 'package:africasa_mecano/provider/list_catalogue_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';

class ListCataloguePage extends ConsumerStatefulWidget {
  const ListCataloguePage({super.key, this.id});
  final int? id;

  @override
  ConsumerState<ListCataloguePage> createState() => _ListCataloguePageState();
}

class _ListCataloguePageState extends ConsumerState<ListCataloguePage> {
  late LisCatalogueProvider _lisCatalogueProvider = LisCatalogueProvider();
 late DeleteCatalogueProvider _deleteCatalogueProvider = DeleteCatalogueProvider();
  @override
  void initState() {

    Future.delayed(Duration.zero, () {
      _lisCatalogueProvider = ref.read(listCatalogue);
      _lisCatalogueProvider.listCatalogue(id: widget.id!.toInt());
      _deleteCatalogueProvider = ref.read(deleteCatalogueProvider);
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilPage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text('Catalogue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  CataloguePage(id: widget.id,)));
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>   FilePickerDemo()));
      }, icon: const Icon(Icons.add, color: Colors.white,),label: Text("Ajouter une photo",style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.white) ), backgroundColor: Colors.blue.shade500,),
       body: SafeArea(child: SingleChildScrollView(
         padding: const EdgeInsets.all(15),
         child: Column(
           children: [
             ListCatalogues()
           ],
         ),
       )),

    );
  }
  Widget ListCatalogues(){
    return Consumer(builder: (context, ref, child) {
      _lisCatalogueProvider = ref.watch(listCatalogue);

      if (_lisCatalogueProvider.listCatalogueModel == null) {
        // Loader pendant le chargement
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

      var data = _lisCatalogueProvider.listCatalogueModel?.data;

      if (_lisCatalogueProvider.isLoading) {
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

      if (data!.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 210.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.picture_in_picture, size: 90, color: Colors.grey.shade500),
                Text(
                  "Pas de",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.blue.shade500,
                  ),
                ),
                Text(
                  "photo catalogue!",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.blue.shade500,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SizedBox(
        height: 600,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            var item = data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:  Text('Suppression', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.blue.shade500),),
                        content:  SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Voulez-vous supprimer cette image de votre catalogue?', style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Colors.grey.shade800)),

                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Non'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () {
                              deleteCatalogue(item.id);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );

                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5), // Coins arrondis
                  child: Image.network(
                    item.photo != null && item.photo.isNotEmpty
                        ? item.photo.toString()
                        : 'https://via.placeholder.com/150/66b7d2',
                    fit: BoxFit.cover, // Remplit l'espace
                    width: double.infinity,
                    // Largeur de chaque élément
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez-vous supprimer cette image de votre catalogue?'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  void deleteCatalogue(int id) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _deleteCatalogueProvider.delete(id: id);

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        _lisCatalogueProvider.listCatalogue(id: widget.id!.toInt());
        Navigator.of(context).pop();
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
    } else {
      showDialog(
          context: context, builder: (context) => const NetworkErrorDialog());
    }
  }
}
