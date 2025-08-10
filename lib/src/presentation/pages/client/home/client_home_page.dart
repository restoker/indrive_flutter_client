import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indrive_flutter_client/main.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/hero/client_hero_page.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/home/bloc/home_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/mapseeker/client_mapseeker_page.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/profile_info_page.dart';
// import 'package:rive/rive.dart' as rive;

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = [
    ClientHeroPage(),
    ClientMapseekerPage(),
    ProfileInfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de opciones'),
        centerTitle: true,
        actions: [],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.homePageStatus == HomePageStatus.valid) {
            Fluttertoast.showToast(
              msg: "Hasta luego 🥺",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
              (route) => false,
            );
          }
          if (state.homePageStatus == HomePageStatus.error) {
            Fluttertoast.showToast(
              msg: "No se pudo cerrar sesión",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final homeBloc = context.watch<HomeBloc>();
            return Drawer(
              child: Column(
                children: [
                  // DrawerHeader(
                  //   decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: const [
                  //         Colors.black,
                  //         Color.fromARGB(194, 94, 73, 10),
                  //         Colors.blue,
                  //         Colors.black,
                  //         // Colors.grey,
                  //       ],
                  //       stops: const [0.1, 0.4, 0.8, 1],
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Menu del cliente',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/img/loading.gif',
                        image:
                            'https://cdn.cosmos.so/caf109bb-413f-4710-8b0c-91b6ed7df8a5?format=jpeg',
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 20.0,
                        left: 20.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 3.0,
                                  color: const Color(0xFF00BF6D),
                                ),
                              ),
                              child: ClipOval(
                                child: Image(
                                  image: AssetImage(
                                    'assets/img/user_image.png',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'Nombre',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text('Home'),
                    selected: state.pageIndex == 0,
                    leading: Icon(Icons.home),
                    selectedColor: const Color(0xFF00BF6D),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      homeBloc.add(ChangeIndexEvent(indexPage: 0));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Mapa'),
                    selected: state.pageIndex == 1,
                    leading: Icon(Icons.location_on_outlined),
                    selectedColor: const Color(0xFF00BF6D),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      homeBloc.add(ChangeIndexEvent(indexPage: 1));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Perfil de usuario'),
                    selected: state.pageIndex == 2,
                    leading: Icon(Icons.person_4_rounded),
                    selectedColor: const Color(0xFF00BF6D),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      homeBloc.add(ChangeIndexEvent(indexPage: 2));
                      Navigator.pop(context);
                    },
                  ),

                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: ListTile(
                        leading: Icon(Icons.logout_sharp),
                        title: Text('Cerrar sesión'),
                        onTap: () {
                          homeBloc.add(LogOutEvent());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
