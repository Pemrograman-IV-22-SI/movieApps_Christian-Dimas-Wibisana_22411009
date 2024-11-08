import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:toastification/toastification.dart';

class Genre extends StatefulWidget {
  const Genre({super.key});
  static String routeName = "/genre";
  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  final dio = Dio();
  bool isLoading = false;
  var dataGenre = [];
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
                    Navigator.pushNamed(context, HomeAdmin.routeName);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              const Text('Genre', style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white))
          ]),
      backgroundColor: const Color(0xff232429),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                var genre = dataGenre[index];
                return ListTile(
                  title: Text(
                    genre['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.movie,
                    color: Colors.white,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.yellowAccent,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ))
                    ],
                  ),
                );
              },
              itemCount: dataGenre.length,
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
      response = await dio.get(getAllGenre);
      if (response.data['status'] == true) {
        dataGenre = response.data['data'];
      } else {
        dataGenre = [];
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
