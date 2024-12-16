import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/users/home_user.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:toastification/toastification.dart';

class TransaksiUser extends StatefulWidget {
  const TransaksiUser({super.key});
  static String routeName = "/transaksi-user";
  @override
  State<TransaksiUser> createState() => _TransaksiUserState();
}

class _TransaksiUserState extends State<TransaksiUser> {
  final dio = Dio();
  bool isLoading = false;
  bool isLoadingDelete = false;
  var dataTransaksiUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeUsers.routeName);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white)),
            const Text('Transaksi', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: const Color(0xff232429),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                var transaksiUser = dataTransaksiUser[index];
                return ListTile(
                  title: Text(
                    transaksiUser['movie']['title'],
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.movie,
                    color: Colors.white,
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "harga Movie Rp. ${transaksiUser['harga']}",
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
              },
              itemCount: dataTransaksiUser.length,
            ),
    );
  }

  void getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      Response response;
      response = await dio.get(getTransaksi);
      if (response.data['status'] == true) {
        dataTransaksiUser = response.data['data'];
      } else {
        dataTransaksiUser = [];
      }
      ;
    } catch (e) {
      toastification.show(
          context: context,
          title: const Text('Server tidak merespon'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 2),
          style: ToastificationStyle.fillColored);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
