import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:africasa_mecano/domain/models/approve_model.dart';
import 'package:africasa_mecano/domain/models/catalogue_modele.dart';
import 'package:africasa_mecano/domain/models/detail_appointment_model.dart';
import 'package:africasa_mecano/domain/models/detail_notification_model.dart';
import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:africasa_mecano/domain/models/liste_catalogue_model.dart';
import 'package:africasa_mecano/domain/models/notification_model.dart';
import 'package:africasa_mecano/domain/models/operation_model.dart';
import 'package:africasa_mecano/domain/models/password_model.dart';
import 'package:africasa_mecano/domain/models/reset_model.dart';
import 'package:africasa_mecano/domain/models/update_picture_model.dart';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/appoint_model.dart';
import '../../domain/models/detail_operation_model.dart';
import '../../domain/models/info_mecano_model.dart';
import '../../domain/models/logout_model.dart';
import '../../domain/models/mecano_model.dart';
import '../../domain/models/rendez_vous_model.dart';
import '../../domain/models/response_model.dart';
import '../../domain/models/update_profile_model.dart';
import '../../domain/models/user_info_model.dart';
import '../../domain/models/user_model.dart';
import '../config/api.dart';
import '../config/api_end_points.dart';
import '../config/api_utils.dart';
import '../config/error_response.dart';



class ApiRepository {
  Future<ResponseModel?> registerCustomer(String type_user, String name, String lastname, String email, String contact, String password) async {
    String url = Api.baseUrl + ApiEndPoints.register;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "type_user": type_user,
          "name": name,
          "lastname": lastname,
          "email": email,
          "contact": contact,
          "password": password,
        },
        options: Options(
          headers: {

            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(ResponseModel.fromJson(response.data));
        }
        ResponseModel phoneconnected = ResponseModel.fromJson(response.data);
        return phoneconnected;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ResponseModel();
      }
    } catch (e) {
      return ResponseModel(message: ErrorResponse.checkMessage(e));
    }
  }

  Future<UserModel?> changePassword(String password, String new_password, String confirm_password) async {
    String url = Api.baseUrl + ApiEndPoints.password;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "password": password,
          "new_password": new_password,
          "confirm_password": confirm_password,
        },
        options: Options(
          headers: {
           "Authorization": "Bearer $tokens",
            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        // if (kDebugMode) {
        //   print(ResponseModel.fromJson(response.data));
        // }
        UserModel pwd = UserModel.fromJson(response.data);
        return pwd;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return UserModel();
      }
    } catch (e) {
      print("l'erreur est: $e");
      return UserModel(message: ErrorResponse.checkMessage(e));
    }
  }
  Future<ResponseModel?> loginCustomer(String login, String password, String device_token) async {
    String url = Api.baseUrl + ApiEndPoints.login;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "login": login,
          "password": password,
          "device_token": device_token
        },
        options: Options(
          headers: {

            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(ResponseModel.fromJson(response.data));
        }
        ResponseModel phoneconnected = ResponseModel.fromJson(response.data);
        return phoneconnected;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ResponseModel();
      }
    } catch (e) {
      return ResponseModel(message: ErrorResponse.checkMessage(e));
    }
  }

  Future<UpdateProfilModel?> UpdateProfil(String name, String lastname, String adresse, String speciality) async {
    String url = Api.baseUrl + ApiEndPoints.updateProfil;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "name": name,
          "lastname": lastname,
          "adresse": adresse,
          "speciality": speciality
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $tokens",
            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      log(response.data.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        UpdateProfilModel profil = UpdateProfilModel.fromJson(response.data);
        return profil;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return UpdateProfilModel();
      }
    } catch (e) {
      print('quelle erreur $e');
      return UpdateProfilModel(message: ErrorResponse.checkMessage(e));
    }
  }
  Future<PasswordModel?> passwordForgot(String contact,) async {
    String url = Api.baseUrl + ApiEndPoints.modifiedPassword;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "contact": contact,

        },
        options: Options(
          headers: {

            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(PasswordModel.fromJson(response.data));
        }
        PasswordModel phoneconnected = PasswordModel.fromJson(response.data);
        return phoneconnected;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return PasswordModel();
      }
    } catch (e) {
      return PasswordModel(message: ErrorResponse.checkMessage(e));
    }
  }
  Future<ResetModel?> resetForgot(String contact,String token, String password, String password_confirmation) async {
    String url = Api.baseUrl + ApiEndPoints.reset;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "contact": contact,
          "token": token,
          "password": password,
          "password_confirmation":password_confirmation,
        },
        options: Options(
          headers: {

            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(ResetModel.fromJson(response.data));
        }
        ResetModel phoneconnected = ResetModel.fromJson(response.data);
        return phoneconnected;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ResetModel();
      }
    } catch (e) {
      return ResetModel(message: ErrorResponse.checkMessage(e));
    }
  }



  Future<LogoutModel?> logoutCustomer() async {
      String url = Api.baseUrl + ApiEndPoints.logout;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var tokens = prefs.getString("tokens");

      try {
        final response = await apiUtils.post(
            url: url,
            options: Options(headers: {"Authorization": "Bearer $tokens", 'content-type': 'application/json',
            'accept':'application/json'}));

        if (response.statusCode == 200) {
          LogoutModel _responseData = LogoutModel.fromJson(response.data);
          return _responseData;
        } else {
          Map<String, dynamic> map = json.decode(response.data);
          if (kDebugMode) {
            print(map["message"]);
          }
          return LogoutModel();
        }
      } catch (e) {
        return LogoutModel(message: ErrorResponse.checkMessage(e));
      }
    }
 Future<MecamoModel?> getListMecano() async {
    String url = Api.baseUrl + ApiEndPoints.providers;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        MecamoModel _mecanoModel = MecamoModel.fromJson(response.data);
        print('mecano a pour valeur $_mecanoModel');
        return _mecanoModel;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return MecamoModel();
      }
    } catch (e) {
      print("la valeur de $e");
      return MecamoModel();
    }
  }

  Future<InfoMecanoModel?> detailMecanicien(int id) async {
    String url = "${Api.baseUrl}${ApiEndPoints.providerById}/$id";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        InfoMecanoModel responseData =
        InfoMecanoModel.fromJson(response.data);
        print("LA VALEUR DE RESPONSE est ${response.data}");
        return responseData;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return InfoMecanoModel();
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "XXXXXXXXXXXXXXXXXXXXXXXXXXX${e.error}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        return InfoMecanoModel();
      }
    }
    return null;
  }

  Future<RendezVousModel?> appointmentCustomer(int client_id, int mecanicien_id, String date_rdv, String hour_start_rdv, String hour_end_rdv) async {
    String url = Api.baseUrl + ApiEndPoints.rdv;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "client_id": client_id,
          "mecanicien_id": mecanicien_id,
          "date_rdv": date_rdv,
          "hour_start_rdv": hour_start_rdv,
          "hour_end_rdv": hour_end_rdv
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $tokens",
            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(RendezVousModel.fromJson(response.data));
        }
        RendezVousModel rdv = RendezVousModel.fromJson(response.data);
        return rdv;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print("${map["message"]}");
        }
        return RendezVousModel();
      }
    } catch (e) {
      return RendezVousModel(message: ErrorResponse.checkMessage(e));
    }
  }


  // Future<AppointModel?> listAppoints() async {
  //   String url = Api.baseUrl + ApiEndPoints.appoint;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var tokens = prefs.getString("tokens");
  //   if (kDebugMode) {
  //     print(url);
  //   }
  //   try {
  //     final response = await apiUtils.get(
  //         url: url,
  //         options: Options(headers: {"Authorization": "Bearer $tokens"}));
  //     if (response.statusCode == 200) {
  //       AppointModel apppointMOdel = AppointModel.fromJson(response.data);
  //       print('mecano a pour valeur $apppointMOdel');
  //       return apppointMOdel;
  //     } else {
  //       Map<String, dynamic> map = json.decode(response.data);
  //       if (kDebugMode) {
  //         print(map["message"]);
  //       }
  //       return AppointModel();
  //     }
  //   } catch (e) {
  //     print("la valeur de $e");
  //     return AppointModel();
  //   }
  // }

  Future<AppointModel?> listAppoints() async {
    String url = Api.baseUrl + ApiEndPoints.appoint;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        AppointModel appoint = AppointModel.fromJson(response.data);
        print('mecano a pour valeur $appoint');
        return appoint;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return AppointModel();
      }
    } catch (e) {
      print("la valeur deX $e");
      return AppointModel();
    }
  }


  Future<OperationModel?> doOperation(String date_operation, String libelle, String motif, String amount, String type_operation) async {
    String url = Api.baseUrl + ApiEndPoints.operations;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.post(
        url: url,
        data: {
          "date_operation": date_operation,
          "libelle": libelle,
          "motif": motif,
          "amount": amount,
          "type_operation": type_operation
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $tokens",
            'content-type': 'application/json',
            'accept':'application/json'
          },
          followRedirects: false, // Désactiver la redirection automatique
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(OperationModel.fromJson(response.data));
        }
        OperationModel rdv = OperationModel.fromJson(response.data);
        return rdv;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return OperationModel();
      }
    } catch (e) {
      print("que dit $e");
      return OperationModel(message: ErrorResponse.checkMessage(e));
    }
  }

  Future<ListOperationModel?> listOperations() async {
    String url = Api.baseUrl + ApiEndPoints.listOperations;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        ListOperationModel apppointMOdel = ListOperationModel.fromJson(response.data);
        print('mecano a pour valeur $apppointMOdel');
        return apppointMOdel;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ListOperationModel();
      }
    } catch (e) {
      print("la valeur de $e");
      return ListOperationModel();
    }
  }

  Future<DetailOperationModel?> detailOperations(int id) async {
    String url = "${Api.baseUrl}${ApiEndPoints.detailOperations}/$id/show";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        DetailOperationModel responseData =
        DetailOperationModel.fromJson(response.data);
        print("LA VALEUR DE RESPONSE est ${response.data}");
        return responseData;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return DetailOperationModel();
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "XXXXXXXXXXXXXXXXXXXXXXXXXXX${e.error}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        return DetailOperationModel();
      }
    }
    return null;
  }


  Future<DetailOperationModel?> detailAppoints(int id) async {
    String url = "${Api.baseUrl}${ApiEndPoints.detailAppoint}/$id/show";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        DetailOperationModel responseData =
        DetailOperationModel.fromJson(response.data);
        print("LA VALEUR DE RESPONSE est ${response.data}");
        return responseData;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return DetailOperationModel();
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "XXXXXXXXXXXXXXXXXXXXXXXXXXX${e.error}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        return DetailOperationModel();
      }
    }
    return null;
  }

  Future<DetailAppointmentModel?> detailAppointment(int id) async {
    String url = "${Api.baseUrl}${ApiEndPoints.detailAppoint}/$id/show";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        DetailAppointmentModel responseData =
        DetailAppointmentModel.fromJson(response.data);
        print("LA VALEUR DE RESPONSE est ${response.data}");
        return responseData;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return DetailAppointmentModel();
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "XXXXXXXXXXXXXXXXXXXXXXXXXXX${e.error}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        return DetailAppointmentModel();
      }
    }
    return null;
  }

  Future<ApproveModel?> validateAppointment(int id) async {
    String url = Api.baseUrl + ApiEndPoints.approve;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");

    if (kDebugMode) {
      print(url);
    }

    try {
      // Construction de la requête en tant que `FormData`
      final formData = FormData.fromMap({
        "appointment_id": id,
      });

      final response = await apiUtils.post(
        url: url,
        data: formData, // Utilisation de `FormData`
        options: Options(
          headers: {
            "Authorization": "Bearer $tokens",
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print(ApproveModel.fromJson(response.data));
        }
        ApproveModel rdv = ApproveModel.fromJson(response.data);
        return rdv;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ApproveModel();
      }
    } catch (e) {
      print("que dit $e");
      return ApproveModel(message: ErrorResponse.checkMessage(e));
    }
  }


  Future<ApproveModel?> RefusedAppointment(int id) async {
    String url = Api.baseUrl + ApiEndPoints.refused;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");

    if (kDebugMode) {
      print(url);
    }

    try {
      // Construction de la requête en tant que `FormData`
      final formData = FormData.fromMap({
        "appointment_id": id,
      });

      final response = await apiUtils.post(
        url: url,
        data: formData, // Utilisation de `FormData`
        options: Options(
          headers: {
            "Authorization": "Bearer $tokens",
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500; // Accepter toutes les réponses inférieures à 500
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        // if (kDebugMode) {
        //   print(OperationModel.fromJson(response.data));
        // }
        ApproveModel rdv = ApproveModel.fromJson(response.data);
        return rdv;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ApproveModel();
      }
    } catch (e) {
      print("que dit $e");
      return ApproveModel(message: ErrorResponse.checkMessage(e));
    }
  }
  Future<UserInfoModel?> getInfoUser() async {
    String url = Api.baseUrl + ApiEndPoints.userInfo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        UserInfoModel _mecanoModel = UserInfoModel.fromJson(response.data);
        print('mecano a pour valeur $_mecanoModel');
        return _mecanoModel;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return UserInfoModel();
      }
    } catch (e) {
      print("la valeur de $e");
      return UserInfoModel();
    }
  }

  Future<UpdatePictureModel?> UpdatePictureProfile (File profil) async {
    String url = Api.baseUrl + ApiEndPoints.updatePicture;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("tokens");

    if (kDebugMode) {
      print("URL de l'API: $url");
    }

    try {
      // Préparation du FormData
      FormData formData = FormData.fromMap({
        "profil_pic": await MultipartFile.fromFile(
          profil.path,
          filename: profil.path.split('/').last,
        ),

      });

      // Appel API
      final response = await apiUtils.post(
        url: url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Vérification et gestion des réponses
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Réponse de l'API : ${response.data}");
        }
        return UpdatePictureModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print("Erreur côté client : ${response.data}");
        }
        return UpdatePictureModel.fromJson(response.data);
      } else {
        if (kDebugMode) {
          print("Erreur inconnue : ${response.statusCode}");
        }
        return UpdatePictureModel(
            message: "Erreur : Code ${response.statusCode}, veuillez réessayer.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception attrapée : $e");
      }
      return UpdatePictureModel(message: ErrorResponse.checkMessage(e));
    }
  }

  Future<CatalogueModel?> rechargedCatalogue (int mecanicienId, File image) async {
    String url = Api.baseUrl + ApiEndPoints.uploadCatalog;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("tokens");

    if (kDebugMode) {
      print("URL de l'API: $url");
    }

    try {
      // Préparation du FormData
      FormData formData = FormData.fromMap({
        "photo[]": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
        "mecanicien_id": mecanicienId,
      });

      // Appel API
      final response = await apiUtils.post(
        url: url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Vérification et gestion des réponses
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Réponse de l'API : ${response.data}");
        }
        return CatalogueModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print("Erreur côté client : ${response.data}");
        }
        return CatalogueModel.fromJson(response.data);
      } else {
        if (kDebugMode) {
          print("Erreur inconnue : ${response.statusCode}");
        }
        return CatalogueModel(
            message: "Erreur : Code ${response.statusCode}, veuillez réessayer.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception attrapée : $e");
      }
      return CatalogueModel
        (message: ErrorResponse.checkMessage(e));
    }
  }

  Future<ListCatalogueModel?> getListCatalogue(int id) async {

    String url = "${Api.baseUrl}${ApiEndPoints.listCatalogue}$id";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        ListCatalogueModel _mecanoModel = ListCatalogueModel.fromJson(response.data);
        print('mecano a pour valeur $_mecanoModel');
        return _mecanoModel;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return ListCatalogueModel();
      }
    } catch (e) {
      print("la valeur de $e");
      return ListCatalogueModel();
    }
  }

  Future<NotificationModel?> listNotification() async {
    String url = Api.baseUrl + ApiEndPoints.notification;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        NotificationModel notif = NotificationModel.fromJson(response.data);
        print('mecano a pour valeur $notif');
        return notif;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return NotificationModel();
      }
    } catch (e) {
      print("la valeur de $e");
      return NotificationModel();
    }
  }

  Future<DetailNotificationModel?> detailNotification(int id) async {
    String url = "${Api.baseUrl}${ApiEndPoints.notificationId}/$id";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString("tokens");
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await apiUtils.get(
          url: url,
          options: Options(headers: {"Authorization": "Bearer $tokens"}));
      if (response.statusCode == 200) {
        DetailNotificationModel responseData =
        DetailNotificationModel.fromJson(response.data);
        print("LA VALEUR DE RESPONSE est ${response.data}");
        return responseData;
      } else {
        Map<String, dynamic> map = json.decode(response.data);
        if (kDebugMode) {
          print(map["message"]);
        }
        return DetailNotificationModel();
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "XXXXXXXXXXXXXXXXXXXXXXXXXXX${e.error}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        return DetailNotificationModel();
      }
    }
    return null;
  }
}
