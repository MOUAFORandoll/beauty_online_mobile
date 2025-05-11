import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  late final userCubit = context.read<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                CircleAvatar(
                  radius: 40,
                  backgroundImage: context.read<AppCacheManager>().getImage(
                      'https://randomuser.me/api/portraits/men/73.jpg'),
                ),

                const SizedBox(width: 16),
                // Name and status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userCubit.user.userName!,
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
                              userCubit.user.email!,
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
          InkWell(
            onTap: () {
              // Handle avatar tap
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  // Skull icon
                  Icon(
                    Icons.face,
                    size: 30,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Avatar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
