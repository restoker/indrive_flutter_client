import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:indrive_flutter_client/src/domain/models/index.dart';
import 'package:indrive_flutter_client/src/presentation/pages/profile/update/bloc/profile_update_bloc.dart';
import 'package:indrive_flutter_client/src/presentation/utils/bloc_form_item.dart';
import 'package:indrive_flutter_client/src/presentation/widgets/default_text_field_outline.dart';

class ProfileUpdateContent extends StatelessWidget {
  const ProfileUpdateContent({
    super.key,
    required this.user,
    // required this.state,
  });

  final User user;
  // final ProfileUpdateState state;
  @override
  Widget build(BuildContext context) {
    final updateBloc = context.read<ProfileUpdateBloc>();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 80.0),
      child: Column(
        children: [
          ProfilePic(
            updateBloc: updateBloc,
            image: user.image ?? 'https://i.postimg.cc/cCsYDjvj/user-2.png',
            state: updateBloc.state,
          ),
          Form(
            key: updateBloc.state.formkey,
            child: Column(
              children: [
                DefaultTextFieldOutline(
                  texto: 'Nombre',
                  initialValue: user.nombre,
                  icono: Icons.person,
                  onChanged: (text) {
                    updateBloc.add(
                      NameChangeEvent(nombre: BlocFormItem(value: text)),
                    );
                  },
                  validator: (p0) {
                    return updateBloc.state.nombre.error;
                  },
                ),
                Gap(10),
                DefaultTextFieldOutline(
                  texto: 'Email',
                  enabled: true,
                  initialValue: user.email,
                  icono: Icons.mail_outline_outlined,
                  onChanged: (text) {},
                ),
                Gap(10),
                DefaultTextFieldOutline(
                  texto: 'Télefono',
                  initialValue: user.telefono,
                  icono: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  onChanged: (text) {
                    updateBloc.add(
                      PhoneChangeEvent(telefono: BlocFormItem(value: text)),
                    );
                  },
                  validator: (p0) {
                    return updateBloc.state.telefono.error;
                  },
                ),
                Gap(10),
                // DefaultTextFieldOutline(
                //   texto: 'Address',
                //   icono: Icons.location_on_outlined,
                //   onChanged: (text) {},
                // ),
                // Gap(10),
                DefaultTextFieldOutline(
                  texto: 'Old Password',
                  obscureText: true,
                  icono: Icons.visibility_off,
                  onChanged: (text) {
                    updateBloc.add(
                      PasswordEvent(password: BlocFormItem(value: text)),
                    );
                  },
                  validator: (p0) {
                    return updateBloc.state.password.error;
                  },
                ),
                Gap(10),
                DefaultTextFieldOutline(
                  obscureText: true,
                  texto: 'New Password',
                  icono: Icons.visibility,
                  onChanged: (text) {
                    updateBloc.add(
                      NewPasswordEvent(newPassword: BlocFormItem(value: text)),
                    );
                  },
                  validator: (p0) {
                    return updateBloc.state.newPassword.error;
                  },
                ),
              ],
            ),
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Cancelar"),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    if (updateBloc.state.formkey!.currentState != null) {
                      if (updateBloc.state.formkey!.currentState!.validate()) {
                        updateBloc.add(UpdateFormSubmit(id: user.id!));
                      }
                    } else {
                      // updateBloc.add(UpdateFormSubmit());
                      Fluttertoast.showToast(
                        msg: 'el formulario no es válido',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: const Text("Actualizar Perfil"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    // this.imageUploadBtnPress,
    required this.state,
    required this.updateBloc,
  });

  final String image;
  final bool isShowPhotoUpload;
  // final VoidCallback? imageUploadBtnPress;
  final ProfileUpdateState state;
  final ProfileUpdateBloc updateBloc;

  @override
  Widget build(BuildContext context) {
    // inspect(state.image);
    return Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.symmetric(vertical: 25.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(
            context,
          ).textTheme.bodyLarge!.color!.withValues(alpha: 0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            width: 120,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: state.image != null
                    ? Image.file(state.image!, fit: BoxFit.cover)
                    : FadeInImage.assetNetwork(
                        placeholder: 'assets/img/loading.gif',
                        image: image,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(seconds: 1),
                      ),
              ),
            ),
          ),
          InkWell(
            onTap: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: AlertDialog(
                  backgroundColor: Colors.black87.withValues(alpha: 0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Text(
                    'Selecciona una opción',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    'Seleccione  "Galeria" o "Camara" para elegir la imagen de su perfil',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.pink,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        updateBloc.add(TakePhotoEvent());
                      },
                      child: Text(
                        'Camara',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.orange,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        updateBloc.add(PickImageEvent());
                      },
                      child: Text(
                        'Galeria',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({super.key, required this.text, required this.child});

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(text)),
          Expanded(flex: 3, child: child),
        ],
      ),
    );
  }
}
