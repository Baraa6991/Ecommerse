import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/Profile/profile_cubit.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEditingName = false;
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: BlocProvider(
        create: (context) => ProfileCubit()..getProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileSuccess) {
              final cubit = context.read<ProfileCubit>();
              final user = state.user;
              nameController.text = "${user.firstName} ${user.lastName}";

              return SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: user.image != null
                                ? NetworkImage(user.image!)
                                : const AssetImage('assets/image copy.png')
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => cubit.pickAndUploadImage(),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: appColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: appColors.pageBackground,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isEditingName
                              ? SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: nameController,
                                    style: TextStyle(color: appColors.text),
                                    decoration: InputDecoration(
                                      hintText: 'Full Name',
                                      hintStyle:
                                          TextStyle(color: appColors.suptext),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: appColors.primary),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: appColors.primary),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appColors.text,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          IconButton(
                            icon: Icon(
                              isEditingName ? Icons.check : Icons.edit,
                              color: appColors.primary,
                            ),
                            onPressed: () {
                              if (isEditingName) {
                                final parts =
                                    nameController.text.trim().split(' ');
                                if (parts.length >= 2) {
                                  cubit.updateProfile(
                                    firstName: parts.first,
                                    lastName: parts.sublist(1).join(' '),
                                    location: user.location,
                                  );
                                }
                              }
                              setState(() => isEditingName = !isEditingName);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.location,
                        style: TextStyle(
                          fontSize: 18,
                          color: appColors.suptext,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 18,
                          color: appColors.suptext,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 80),
                      OnBordingContainer(
                        width: 300,
                        height: 60,
                        color: appColors.primary,
                        widget: Text(
                          'Light & Dark',
                          style: TextStyle(
                            fontSize: 20,
                            color: appColors.text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OnBordingContainer(
                        width: 300,
                        height: 60,
                        color: appColors.primary,
                        widget: Text(
                          'LogOut',
                          style: TextStyle(
                            fontSize: 20,
                            color: appColors.text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: appColors.text),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No Data',
                  style: TextStyle(color: appColors.text),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
