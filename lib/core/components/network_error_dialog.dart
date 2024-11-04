import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/colors_util.dart';
import '../utils/strings.dart';

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10),
      title: Text(strings.internetAlert,
          style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorsUtil.KcircleGreen,
              fontWeight: FontWeight.w500)),
      content: Text(
          strings.errorInternet,
          style: GoogleFonts.poppins(
              fontSize: 15,
              color: ColorsUtil.black,
              fontWeight: FontWeight.w500)),
      actions: <Widget>[
        TextButton(
          child: Text(strings.ok,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: ColorsUtil.KcircleGreen,
                  fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}