import 'package:africasa_mecano/booking_page.dart';
import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:africasa_mecano/gestion_page.dart';
import 'package:africasa_mecano/notification/liste_notification_page.dart';
import 'package:africasa_mecano/password_page.dart';
import 'package:africasa_mecano/profil_page.dart';
import 'package:africasa_mecano/provider/info_user_provider.dart';
import 'package:africasa_mecano/provider/list_operation_provider.dart';
import 'package:africasa_mecano/provider/logout_provider.dart';
import 'package:africasa_mecano/provider/notification_provider.dart';
import 'package:africasa_mecano/provider/operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:badges/badges.dart' as badges;
import 'core/components/dialog_alert.dart';
import 'core/components/network_error_dialog.dart';
import 'core/utils/check_network.dart';
import 'core/utils/colors_util.dart';
import 'core/utils/strings.dart';
import 'login_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, this.isActive});
  final int? isActive;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController gainController = TextEditingController();
  TextEditingController sortieController = TextEditingController();
  TextEditingController libelleController = TextEditingController();
  TextEditingController libelleRetraitController = TextEditingController();
  TextEditingController motifController = TextEditingController();
  TextEditingController motifRetraitController = TextEditingController();
  String operation_type = " SORTIE";
  String operation_entree = " ENTREE";
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final List<double> gainTab = [];
  final List<double> perteTab = [];
  late double somGin = 0.0;
  late double soustraction = 0.0;
  late double balance = 0.0;
  late OperationController _operationController = OperationController();
  late LogoutUserProvider _logoutUserProvider;
  late UserInfoProvider _userInfoProvider = UserInfoProvider();
  late ListOperationProvider _listOperationProvider = ListOperationProvider();
  late NotificationProvider _notificationProvider = NotificationProvider();
  Future<void> loadSavedValues() async {
    final prefs = await SharedPreferences.getInstance();
    somGin = prefs.getDouble('somGin') ?? 0.0;
    soustraction = prefs.getDouble('soustraction') ?? 0.0;
    balance = somGin - soustraction;
  }

  Future<void> saveValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('somGin', somGin);
    await prefs.setDouble('soustraction', soustraction);
  }
  void calculGain() {
    final gainText = gainController.text;
    if (gainText.isNotEmpty) {
      final gainValue = double.tryParse(gainText);
      if (gainValue != null) {
        setState(() {
          gainTab.add(gainValue);
          somGin += gainValue;
          balance = somGin - soustraction;
        });
        saveValues();
        gainController.clear();  // Optionnel : vide le champ après ajout
        print("Valeur ajoutée à gainTab: $gainValue");
      } else {
        print("Erreur : Veuillez saisir un nombre valide");
      }
    }
  }

  void calculRetrait() {
    final retraitText = sortieController.text;
    if (retraitText.isNotEmpty) {
      final retraitValue = double.tryParse(retraitText);
      if (retraitValue != null) {
        setState(() {
          perteTab.add(retraitValue);
          soustraction += retraitValue;
          balance = somGin - soustraction;
        });
        saveValues();
        sortieController.clear();  // Optionnel : vide le champ après ajout
        print("Valeur ajoutée à gainTab: $retraitValue");
      } else {
        print("Erreur : Veuillez saisir un nombre valide");
      }
    }
  }


  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      _operationController = ref.read(operationProvider);
      _logoutUserProvider = ref.read(logoutProvider);
      _userInfoProvider = ref.read(userProvider);
      _userInfoProvider.infoUserConnected();
      _listOperationProvider = ref.read(listOperationProvider);
      _listOperationProvider.getListOperation();
      _notificationProvider = ref.read(notificationProvider);
      _notificationProvider.getListNotification();
      loadSavedValues();

      deconnexionPrestataire();
    });
    somGin = 0.0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Consumer(builder: (context, ref, child){
                _userInfoProvider = ref.watch(userProvider);
                var infoClient= _userInfoProvider.userInfoModel?.data;
                if(infoClient==null){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 65,
                    //   width: 65,
                    //   decoration: BoxDecoration(
                    //     image:  DecorationImage(
                    //       image: NetworkImage(infoClient.profilPic!= null && infoClient.profilPic.isNotEmpty?infoClient.profilPic.toString(): 'https://via.placeholder.com/150'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //     border: Border.all(color: Colors.grey.shade300),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //
                    // ),
                    CircleAvatar(
                      radius: 32.5, // Rayon pour correspondre à 65x65
                      backgroundColor: Colors.grey.shade300, // Couleur de bordure
                      child: ClipOval(
                        child: Image.network(
                          infoClient.profilPic != null && infoClient.profilPic.isNotEmpty
                              ? infoClient.profilPic
                              : 'https://via.placeholder.com/150',
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // L'image est chargée
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Icon(Icons.person, size: 40, color: Colors.grey.shade500); // Fallback en cas d'erreur
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(infoClient.name.toString(), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500),),
                        const SizedBox(width: 5,),
                        Text(infoClient.mecanicien!.lastname.toString(), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500),)
                      ],
                    ),
                    Text(infoClient.mecanicien!.speciality.toString(), style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.grey.shade700),)
                  ],
                );
              },),
            ),
            ListTile(
              leading:  Icon(Icons.person, color: Colors.grey.shade800),
              title: Text('Profil', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProfilPage()));
              },
            ),
            ListTile(
              leading:  Icon(Icons.lock, color: Colors.grey.shade800),
              title: Text('Modifier mot de passe ', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PasswordPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.grey.shade800),
              title:  Text('Se déconnecter', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500)),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),  // Drawer ajouté ici
      appBar: AppBar(

        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),  // Icône pour ouvrir le Drawer
              onPressed: () {
                Scaffold.of(context).openDrawer();  // Ouvre le Drawer
              },
            );
          },
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 2, end: 10),
            badgeContent: Consumer(
              builder: (context, ref, child) {
                var unRead;
                _notificationProvider = ref.watch(notificationProvider);
                var data = _notificationProvider.notificationModel?.data;
                unRead = data?.where((item) => item.readAt == null).toList();

                return Text(
                  "${unRead?.length ?? 0}",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                );
              }
            ),
            child: IconButton(
              icon: Icon(Icons.notifications, color: Colors.grey.shade500,size: 25,),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const ListNotificationPage()));
              },
            ),
          ),
          // Icone de notification à droite
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: RefreshIndicator(
            onRefresh: () {
              return Future<void>.delayed(const Duration(seconds: 3));

            },
            child: Consumer(
              builder: (context, ref, child) {
                _listOperationProvider = ref.watch(listOperationProvider);
                List<AllOperation> entreeTab = [];
                List<AllOperation> sortieTab = [];
                var data = _listOperationProvider.listOperationModel?.data?.allOperations;

                if(data != null && data.isNotEmpty){
                  entreeTab = data.where((item) => item.typeOperation == "ENTREE").toList();
                  sortieTab = data.where((item) => item.typeOperation == "SORTIE").toList();

                }
                double totalPrix = entreeTab.fold(0.0, (total, item) => total + item.amount);
                double totalPrixSortie = sortieTab.fold(0.0, (total, item) => total + item.amount);
                double differencePrix = totalPrix - totalPrixSortie;
                print(entreeTab);
                return Column(
                  children: [
                    Center(
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 1000000,
                            showLabels: false,  // Masque les étiquettes de valeur
                            showTicks: false,   // Masque les graduations
                            ranges: <GaugeRange>[
                              GaugeRange(
                                startValue: 0,
                                endValue: 250000,
                                color: Colors.red,
                              ),
                              GaugeRange(
                                startValue: 250000,
                                endValue: 500000,
                                color: Colors.orange,
                              ),
                              GaugeRange(
                                startValue: 500000,
                                endValue: 750000,
                                color: Colors.yellow,
                              ),
                              GaugeRange(
                                startValue: 750000,
                                endValue: 1000000,
                                color: Colors.green,
                              ),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: differencePrix, // Utilisez la variable balance ici
                                needleStartWidth: 1,
                                needleEndWidth: 3,
                                knobStyle: KnobStyle(
                                  knobRadius: 0.05,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'fr', // Changez la langue si nécessaire
                                        symbol: '',   // Supprime le symbole monétaire (par exemple, € ou $)
                                        decimalDigits: 0, // Nombre de chiffres après la virgule
                                      ).format(differencePrix), // Formate le nombre avec séparateurs des milliers
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey.shade900,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Fcfa",  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade900,
                                      fontSize: 20,
                                    ),)
                                  ],
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      )
                      ,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _dialogBuilder(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade700,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              NumberFormat.currency(
                                locale: 'fr', // Changez la langue si nécessaire
                                symbol: '',   // Supprime le symbole monétaire (par exemple, € ou $)
                                decimalDigits: 0, // Nombre de chiffres après la virgule
                              ).format(totalPrix), // Formate le nombre avec séparateurs des milliers
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _retraitBuilder(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red.shade500,
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: GoogleFonts.poppins(
                                         fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),


                            Text(
                              NumberFormat.currency(
                                locale: 'fr', // Changez la langue si nécessaire
                                symbol: '',   // Supprime le symbole monétaire (par exemple, € ou $)
                                decimalDigits: 0, // Nombre de chiffres après la virgule
                              ).format(totalPrixSortie), // Formate le nombre avec séparateurs des milliers
                              style: GoogleFonts.poppins(
                                color: Colors.red.shade400,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingPage()));
                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade500,
                        ),
                        child: Center(
                          child: Text("Mes rendez-vous",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GestionPage()));
                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade500),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text("Gestion",
                              style: GoogleFonts.poppins(
                                  color: Colors.blue.shade500, fontSize: 20)),
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un gain'),
          content: SizedBox(
            height: 170,
            child: Column(
              children: [
                // TextFormField(
                //   controller: libelleController,
                //   keyboardType: TextInputType.visiblePassword,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Svp entrez le libelle';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     hintText: "Ex: paiement fournisseur",
                //     fillColor: Colors.white,
                //     filled: true,
                //     hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
                //     // suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
                //     // prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey.shade900, width: 0.5),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     errorBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: motifController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Svp entrez votre motif';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Ex: achat materiel",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
                    // suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
                    // prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: gainController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Svp entrez votre gain';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Ex: 120000",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
                    // suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
                    // prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Valider'),
              onPressed: () {

                checkGain();
                calculGain();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _retraitBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Faire une sortie'),
          content: SizedBox(
            height: 170,
            child: Column(
              children: [

                const SizedBox(height: 10,),
                TextFormField(
                  controller: motifRetraitController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Svp entrez votre motif';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Ex: achat materiel",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
                    // suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
                    // prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: sortieController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Svp entrez votre gain';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Ex: 120000",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 14),
                    // suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.shade200,),
                    // prefixIcon: Icon(Icons.lock,color: Colors.grey.shade200,),
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
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Valider'),
              onPressed: () {
                checkData();
                calculRetrait();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> operationSubmit( String date_operation, libelle, motif,amount, type_operation) async {
    var checkInternet = checkNetwork();

    if (await checkInternet) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const DialogAlert();
          });
      var dataResponse =
      await _operationController.operation(date_operation: date_operation, libelle: libelle, motif: motif, amount: amount, type_operation: type_operation, );

      if (dataResponse == null) {
        return;
      }
      if (dataResponse.success == true) {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => const MenuPage()),
        //       (route) => false,
        // );
        Navigator.pop(context);
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

  checkData(){
    if (sortieController.text.isNotEmpty || motifRetraitController.text.isNotEmpty||libelleRetraitController.text.isNotEmpty ) {


      operationSubmit(formattedDate,libelleRetraitController.text, motifRetraitController.text, sortieController.text, operation_type).then((value) {
        _listOperationProvider.getListOperation(); 
      });

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

  checkGain(){
    if (gainController.text.isNotEmpty || motifController.text.isNotEmpty||libelleController.text.isNotEmpty ) {


      operationSubmit(formattedDate,libelleController.text, motifController.text, gainController.text, operation_entree).whenComplete(() {
       _listOperationProvider.getListOperation(); 
      });

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
  void logout() async {
    try {
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      ;
      // Vérifie le succès de la réponse
      if (response.success == true) {
        Navigator.of(context).pop(); // Ferme le dialogue
        await Future.delayed(Duration(milliseconds: 300)); // Ajoute un léger délai
        prefs.clear();
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

  void deconnexionPrestataire() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_userInfoProvider.userInfoModel?.data?.isActive == 0) {
      await prefs.remove("tokens");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    }
  }
}
