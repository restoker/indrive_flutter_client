import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/client/home/bloc/home_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/info/bloc/profile_info_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/widgets/index.dart';

class ProfileInfoContent extends StatelessWidget {
  const ProfileInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profileInfoBloc = context.read<ProfileInfoBloc>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: ProfileClipper(),
                child: Image(
                  height: 300.0,
                  width: double.infinity,
                  image: AssetImage('assets/img/bgprofile.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //   top: 50.0,
              //   left: 20.0,
              //   child: IconButton(
              //     icon: Icon(Icons.menu),
              //     iconSize: 30.0,
              //     onPressed: () {
              //       Scaffold.of(context).openEndDrawer();
              //     },
              //     // onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              //   ),
              // ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image(
                      height: 120.0,
                      width: 120.0,
                      // image: AssetImage('assets/img/user6.jpg'),
                      image: profileInfoBloc.state.user?.image != null
                          ? NetworkImage(
                              profileInfoBloc.state.user?.image ?? '',
                            )
                          : AssetImage('assets/img/user6.webp')
                                as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              profileInfoBloc.state.user?.nombre ?? '',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              profileInfoBloc.state.user?.email ?? '',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: profileInfoBloc.state.user?.telefono ?? ''),
              ).then((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Teléfono copiado")));
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                profileInfoBloc.state.user?.telefono ?? '',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 60.0),
          ListTile(
            splashColor: Colors.grey,
            title: Text(
              'Editar Perfil'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              'profile/update',
              arguments: profileInfoBloc.state.user,
            ),
            leading: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Icon(Icons.edit, color: Colors.white),
            ),
          ),
          ListTile(
            splashColor: Colors.grey,
            title: Text(
              'Cerrar sesión'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            onTap: () {
              context.read<HomeBloc>().add(LogOutEvent());
            },
            leading: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Icon(Icons.login_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
