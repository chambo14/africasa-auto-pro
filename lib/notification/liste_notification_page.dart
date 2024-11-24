import 'package:africasa_mecano/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ListNotificationPage extends ConsumerStatefulWidget {
  const ListNotificationPage({super.key});

  @override
  ConsumerState<ListNotificationPage> createState() => _ListNotificationPageState();
}

class _ListNotificationPageState extends ConsumerState<ListNotificationPage> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Notifications",  style: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade500, fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: addNotification, // Ajouter une notification
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          // Extraire les informations de la notification
          final notification = notifications[index];
          return Card(
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
              title: Text(notification['title']!, style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue.shade500, fontWeight: FontWeight.w600),),
              subtitle: Column(
                children: [
                  Text(notification['message']!,  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w400)),
                  Text(notification['timestamp']!,textAlign: TextAlign.end,)
                ],
              ),

              onTap: () => showNotification(notification['message']!), // Afficher un SnackBar
            ),
          );
        },
      ),
    );
  }
}
