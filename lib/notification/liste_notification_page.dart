import 'package:africasa_mecano/detail_notification_page.dart';
import 'package:africasa_mecano/home_page.dart';
import 'package:africasa_mecano/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class ListNotificationPage extends ConsumerStatefulWidget {
  const ListNotificationPage({super.key});

  @override
  ConsumerState<ListNotificationPage> createState() => _ListNotificationPageState();
}

class _ListNotificationPageState extends ConsumerState<ListNotificationPage> {
  late NotificationProvider _notificationProvider = NotificationProvider();


  List<Map<String, String>> notifications = [
    {
      'title': 'New Message',
      'message': 'You have received a new message.',
      'timestamp': '2024-11-23 10:00:00',
    },
    {
      'title': 'Info Rendez-vous',
      'message': 'A new update is available for your app.',
      'timestamp': '2024-11-23 11:15:45',
    },
    {
      'title': 'System Alert',
      'message': 'Your password will expire soon. Please update it.',
      'timestamp': '2024-11-23 12:30:10',
    },
  ];

  void addNotification() {
    setState(() {
      notifications.add({
        'title': 'Rappel',
        'message': 'This is a dynamically added notification.',
        'timestamp': DateTime.now().toString(),
      });
    });
  }

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
    _notificationProvider = ref.read(notificationProvider);
    _notificationProvider.getListNotification();
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_alert),
        //     onPressed: addNotification, // Ajouter une notification
        //   ),
        // ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          _notificationProvider = ref.watch(notificationProvider);
          var data = _notificationProvider.notificationModel?.data;
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
