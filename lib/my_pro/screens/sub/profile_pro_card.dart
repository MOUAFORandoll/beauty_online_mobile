import 'dart:io';

import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/loadPicture.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ProfileProCardScreen extends StatefulWidget {
  const ProfileProCardScreen({super.key});

  @override
  State<ProfileProCardScreen> createState() => _ProfileProCardScreenState();
}

class _ProfileProCardScreenState extends State<ProfileProCardScreen> {
  late final professionalCubit = context.read<MyProfessionalCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfessionalCubit, MyProfessionalState>(
        builder: (context, state) {
      late final professional = professionalCubit.professional;

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            final image = await pickImage(context);
                            if (image != null) {
                              professionalCubit.updateProfilePicture(
                                  file: File(image.path));
                            }
                          },
                          child: ProfilePicture(
                              image: professional.cover ?? '', size: 80)
                          //  CircleAvatar(
                          //   radius: 40,
                          //   backgroundImage: context.read<AppCacheManager>().getImage(
                          //       'https://randomuser.me/api/portraits/men/73.jpg'),
                          // ),
                          ),
                      if (state is MyProfessionalUpdatingState)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(80)),
                            child: Positioned(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 16),
                  // Name and status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          professional.namePro!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '📨',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                professional.description ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Avatar section
          ],
        ),
      );
    });
  }
}
