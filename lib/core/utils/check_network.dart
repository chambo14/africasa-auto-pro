import 'dart:developer';
import 'dart:io';

Future<bool> checkNetwork() async {
  bool isConnectionSuccessful = false;

  try {
    final response = await InternetAddress.lookup("www.google.com");

    if (response.isNotEmpty) {
      isConnectionSuccessful = true;
    }

  } on SocketException catch (e) {
    log("error checkConnection => $e");
    isConnectionSuccessful = false;
  }

  return isConnectionSuccessful;
}

