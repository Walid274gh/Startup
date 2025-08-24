import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';

class HomeHeader extends ConsumerWidget {
  final String userName;
  final String? userAvatar;

  const HomeHeader({
    super.key,
    required this.userName,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final hour = now.hour;
    
    String greeting;
    if (hour < 12) {
      greeting = 'Bonjour';
    } else if (hour < 18) {
      greeting = 'Bon après-midi';
    } else {
      greeting = 'Bonsoir';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryColor,
            AppConstants.primaryColor.withOpacity(0.8),
            AppConstants.secondaryColor,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre supérieure avec avatar et notifications
          Row(
            children: [
              // Avatar de l'utilisateur
              GestureDetector(
                onTap: () => context.push(AppRoutes.profile),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: userAvatar != null
                        ? CachedNetworkImage(
                            imageUrl: userAvatar!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.7),
                                size: 24,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.7),
                                size: 24,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: Colors.white.withOpacity(0.7),
                              size: 24,
                            ),
                          ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Salutation et nom d'utilisateur
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Bouton de notifications
              GestureDetector(
                onTap: () => context.push(AppRoutes.notifications),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      // Indicateur de nouvelles notifications
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Message de bienvenue
          Text(
            'Que souhaitez-vous faire aujourd\'hui ?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Statistiques rapides
          Row(
            children: [
              _buildStatItem(
                icon: Icons.work_outline,
                value: '12',
                label: 'Demandes',
                color: Colors.orange,
              ),
              const SizedBox(width: 16),
              _buildStatItem(
                icon: Icons.people_outline,
                value: '8',
                label: 'Travailleurs',
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              _buildStatItem(
                icon: Icons.star_outline,
                value: '4.8',
                label: 'Note',
                color: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget alternatif avec animation Flutter Animate
class HomeHeaderAnimated extends ConsumerWidget {
  final String userName;
  final String? userAvatar;

  const HomeHeaderAnimated({
    super.key,
    required this.userName,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final hour = now.hour;
    
    String greeting;
    if (hour < 12) {
      greeting = 'Bonjour';
    } else if (hour < 18) {
      greeting = 'Bon après-midi';
    } else {
      greeting = 'Bonsoir';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryColor,
            AppConstants.primaryColor.withOpacity(0.8),
            AppConstants.secondaryColor,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre supérieure avec avatar et notifications
          Row(
            children: [
              // Avatar avec animation
              GestureDetector(
                onTap: () => context.push(AppRoutes.profile),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: userAvatar != null
                        ? CachedNetworkImage(
                            imageUrl: userAvatar!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.7),
                                size: 24,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.7),
                                size: 24,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: Colors.white.withOpacity(0.7),
                              size: 24,
                            ),
                          ),
                  ),
                )
                    .animate()
                    .scale(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      delay: const Duration(milliseconds: 200),
                    ),
              ),
              
              const SizedBox(width: 16),
              
              // Salutation avec animation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 400),
                        )
                        .slideX(
                          begin: -0.3,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          delay: const Duration(milliseconds: 400),
                        ),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 600),
                        )
                        .slideX(
                          begin: -0.3,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          delay: const Duration(milliseconds: 600),
                        ),
                  ],
                ),
              ),
              
              // Bouton de notifications avec animation
              GestureDetector(
                onTap: () => context.push(AppRoutes.notifications),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .scale(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      delay: const Duration(milliseconds: 800),
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Message de bienvenue avec animation
          Text(
            'Que souhaitez-vous faire aujourd\'hui ?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1000),
              )
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1000),
              ),
          
          const SizedBox(height: 16),
          
          // Statistiques avec animation
          Row(
            children: [
              _buildStatItemAnimated(
                icon: Icons.work_outline,
                value: '12',
                label: 'Demandes',
                color: Colors.orange,
                delay: const Duration(milliseconds: 1200),
              ),
              const SizedBox(width: 16),
              _buildStatItemAnimated(
                icon: Icons.people_outline,
                value: '8',
                label: 'Travailleurs',
                color: Colors.green,
                delay: const Duration(milliseconds: 1400),
              ),
              const SizedBox(width: 16),
              _buildStatItemAnimated(
                icon: Icons.star_outline,
                value: '4.8',
                label: 'Note',
                color: Colors.yellow,
                delay: const Duration(milliseconds: 1600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItemAnimated({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required Duration delay,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: const Duration(milliseconds: 600),
            delay: delay,
          )
          .slideY(
            begin: 0.3,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            delay: delay,
          )
          .scale(
            begin: const Offset(0.8, 0.8),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            delay: delay,
          );
  }
}