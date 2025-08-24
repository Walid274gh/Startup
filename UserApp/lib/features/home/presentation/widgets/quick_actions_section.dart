import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class QuickActionsSection extends ConsumerWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la section
          Text(
            'Actions rapides',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Grille des actions rapides
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildQuickActionCard(
                context: context,
                icon: Icons.add_circle_outline,
                title: 'Nouvelle demande',
                subtitle: 'Créer une demande de service',
                color: AppConstants.primaryColor,
                onTap: () => context.push(AppRoutes.request),
              ),
              _buildQuickActionCard(
                context: context,
                icon: Icons.search,
                title: 'Rechercher',
                subtitle: 'Trouver un travailleur',
                color: AppConstants.secondaryColor,
                onTap: () => context.push(AppRoutes.search),
              ),
              _buildQuickActionCard(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: 'Messages',
                subtitle: 'Voir vos conversations',
                color: Colors.green,
                onTap: () => context.push(AppRoutes.chat),
              ),
              _buildQuickActionCard(
                context: context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Voir vos alertes',
                color: Colors.orange,
                onTap: () => context.push(AppRoutes.notifications),
              ),
              _buildQuickActionCard(
                context: context,
                icon: Icons.history,
                title: 'Historique',
                subtitle: 'Vos demandes passées',
                color: Colors.purple,
                onTap: () => context.push(AppRoutes.history),
              ),
              _buildQuickActionCard(
                context: context,
                icon: Icons.help_outline,
                title: 'Aide',
                subtitle: 'Support et FAQ',
                color: Colors.teal,
                onTap: () => context.push(AppRoutes.help),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icône
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              
              // Contenu textuel
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget alternatif avec animation Flutter Animate
class QuickActionsSectionAnimated extends ConsumerWidget {
  const QuickActionsSectionAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec animation
          Text(
            'Actions rapides',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 200),
              )
              .slideX(
                begin: -0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 200),
              ),
          
          const SizedBox(height: 16),
          
          // Grille avec animation
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.add_circle_outline,
                title: 'Nouvelle demande',
                subtitle: 'Créer une demande de service',
                color: AppConstants.primaryColor,
                onTap: () => context.push(AppRoutes.request),
                delay: const Duration(milliseconds: 400),
              ),
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.search,
                title: 'Rechercher',
                subtitle: 'Trouver un travailleur',
                color: AppConstants.secondaryColor,
                onTap: () => context.push(AppRoutes.search),
                delay: const Duration(milliseconds: 600),
              ),
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: 'Messages',
                subtitle: 'Voir vos conversations',
                color: Colors.green,
                onTap: () => context.push(AppRoutes.chat),
                delay: const Duration(milliseconds: 800),
              ),
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Voir vos alertes',
                color: Colors.orange,
                onTap: () => context.push(AppRoutes.notifications),
                delay: const Duration(milliseconds: 1000),
              ),
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.history,
                title: 'Historique',
                subtitle: 'Vos demandes passées',
                color: Colors.purple,
                onTap: () => context.push(AppRoutes.history),
                delay: const Duration(milliseconds: 1200),
              ),
              _buildQuickActionCardAnimated(
                context: context,
                icon: Icons.help_outline,
                title: 'Aide',
                subtitle: 'Support et FAQ',
                color: Colors.teal,
                onTap: () => context.push(AppRoutes.help),
                delay: const Duration(milliseconds: 1400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCardAnimated({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required Duration delay,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icône avec animation
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              )
                  .animate()
                  .scale(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                    delay: delay,
                  ),
              
              // Contenu textuel avec animation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: delay.inMilliseconds + 200),
                      ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: delay.inMilliseconds + 400),
                      ),
                ],
              ),
            ],
          ),
        ),
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