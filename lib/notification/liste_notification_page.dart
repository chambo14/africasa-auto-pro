import 'package:africasa_mecano/detail_notification_page.dart';
import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';


class ListNotificationPage extends ConsumerStatefulWidget {
  const ListNotificationPage({super.key});

  @override
  ConsumerState<ListNotificationPage> createState() => _ListNotificationPageState();
}

class _ListNotificationPageState extends ConsumerState<ListNotificationPage> {
  late NotificationProvider _notificationProvider = NotificationProvider();




  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  @override
  void initState() {

    Future.delayed(Duration.zero, (){
      _notificationProvider = ref.read(notificationProvider);
      _notificationProvider.getListNotification();

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
        title: Text("Notifications",  style: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade500, fontWeight: FontWeight.w500)),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          _notificationProvider = ref.watch(notificationProvider);
          var data = _notificationProvider.notificationModel?.data;
          if (_notificationProvider.isLoading) {
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

          if (data == null || data.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top:250.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.notifications_active_outlined, size: 90,  color: Colors.grey.shade700),
                    Text("Pas de notifications",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, color: Colors.blue.shade500)),
                    Text("pour l'instant!",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,  color: Colors.blue.shade500)),
                  ],
                ),
              ),
            );
          }
          return SizedBox(
            height: 800,
            child: ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                // Extraire les informations de la notification

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailNotificationPage(id: data[index].id,)));
                  },

                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: data[index].readAt == null ? Colors.green.shade50 : Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade300,
                        child: const ClipOval(
                          child: FadeInImage(
                            placeholder: AssetImage('assets/logo.png'), // Vous pouvez remplacer cela par un asset image de votre choix
                            image: AssetImage('assets/logo.png'),
                            width: 55, // Diamètre du CircleAvatar
                            height: 55,
                            fit: BoxFit.cover, // Remplir l'espace sans déformer l'image
                          ),
                        ),
                      ),
                      title: Text(data[index].title, style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue.shade500, fontWeight: FontWeight.w600),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].message,  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w400)),
                          Row(
                            children: [
                              Text("Publié le:", style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey.shade500)),
                              const SizedBox(width: 5,),
                              Text(DateFormat('yyyy-MM-dd').format(data[index].createdAt), style: GoogleFonts.poppins(fontSize: 15,),),
                            ],
                          ),
                          // Text(data[index].createdAt as String,textAlign: TextAlign.end,)
                        ],
                      ),
                  // Afficher un SnackBar
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
