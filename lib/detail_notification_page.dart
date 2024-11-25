import 'package:africasa_mecano/notification/liste_notification_page.dart';
import 'package:africasa_mecano/provider/detail_notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class DetailNotificationPage extends ConsumerStatefulWidget {
  const DetailNotificationPage({super.key, this.id});
  final int? id;

  @override
  ConsumerState<DetailNotificationPage> createState() => _DetailNotificationPageState();
}

class _DetailNotificationPageState extends ConsumerState<DetailNotificationPage> {
late DetailNotificationProvider _notificationProvider = DetailNotificationProvider();

@override
  void initState() {
    _notificationProvider = ref.read(detailNotificationProvider);
    _notificationProvider.infoNotification(id: widget.id!.toInt());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ListNotificationPage()));},icon: const Icon(Icons.arrow_back_ios),),
        title: Text("Info Notifications",  style: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade500, fontWeight: FontWeight.w500)),

      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10,right: 10, top: 20),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                _notificationProvider = ref.watch(detailNotificationProvider);
                var data = _notificationProvider.detailNotificationModel?.data;
                if (_notificationProvider.isLoading || data == null) {
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

                return Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_rounded, color: Colors.grey.shade500,),
                          const SizedBox(width: 5,),
                          Text(data.title.toString(), style: GoogleFonts.poppins(fontSize: 15, color: Colors.blue.shade500, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(data.message.toString(), style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10,),

                    ],
                  ),
                );
              }
            )
          ],
        ),
      )),
    );
  }
}
