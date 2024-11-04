import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../utils/colors_util.dart';

class DialogAlert extends StatelessWidget {
  const DialogAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          Text("Patientez...",style: GoogleFonts.poppins(
              fontSize: 18,
              color: ColorsUtil.black,
              fontWeight: FontWeight.w400),),
          const SizedBox(
            height: 12,
          ),
          NutsActivityIndicator(
            radius: 40,
            tickCount: 16,
            activeColor: Colors.blue.shade500,
            inactiveColor: Colors.grey.shade300,
            animationDuration: const Duration(milliseconds: 750),
            relativeWidth: 0.3,
          ),

        ],
      ),
    );;
  }
}
