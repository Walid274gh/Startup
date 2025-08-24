import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Catégories populaires',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.search),
                child: Text(
                  'Voir tout',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Grille des catégories
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: ProfessionConstants.professions.length,
            itemBuilder: (context, index) {
              final profession = ProfessionConstants.professions[index];
              final icon = ProfessionConstants.professionIcons[profession] ?? Icons.work;
              final color = _getProfessionColor(index);
              
              return _buildCategoryCard(
                context: context,
                profession: profession,
                icon: icon,
                color: color,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String profession,
    required IconData icon,
    required Color color,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => context.push('${AppRoutes.search}?profession=$profession'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône de la profession
            Container(
              width: 50,
              height: 50,
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
            
            const SizedBox(height: 12),
            
            // Nom de la profession
            Text(
              profession,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 4),
            
            // Nombre de travailleurs (simulé)
            Text(
              '${_getRandomWorkerCount()} travailleurs',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getProfessionColor(int index) {
    final colors = [
      AppConstants.primaryColor,
      AppConstants.secondaryColor,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
      Colors.lightGreen,
    ];
    
    return colors[index % colors.length];
  }

  int _getRandomWorkerCount() {
    // Simulation d'un nombre de travailleurs
    final random = DateTime.now().millisecond;
    return 10 + (random % 90);
  }
}

// Widget alternatif avec animation Flutter Animate
class CategoriesSectionAnimated extends ConsumerWidget {
  const CategoriesSectionAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec animation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Catégories populaires',
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
              TextButton(
                onPressed: () => context.push(AppRoutes.search),
                child: Text(
                  'Voir tout',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                  )
                  .slideX(
                    begin: 0.3,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    delay: const Duration(milliseconds: 400),
                  ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Grille des catégories avec animation
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: ProfessionConstants.professions.length,
            itemBuilder: (context, index) {
              final profession = ProfessionConstants.professions[index];
              final icon = ProfessionConstants.professionIcons[profession] ?? Icons.work;
              final color = _getProfessionColor(index);
              
              return _buildCategoryCardAnimated(
                context: context,
                profession: profession,
                icon: icon,
                color: color,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCardAnimated({
    required BuildContext context,
    required String profession,
    required IconData icon,
    required Color color,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => context.push('${AppRoutes.search}?profession=$profession'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône avec animation
            Container(
              width: 50,
              height: 50,
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
                  delay: Duration(milliseconds: 600 + (index * 100)),
                ),
            
            const SizedBox(height: 12),
            
            // Nom de la profession avec animation
            Text(
              profession,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 800 + (index * 100)),
                ),
            
            const SizedBox(height: 4),
            
            // Nombre de travailleurs avec animation
            Text(
              '${_getRandomWorkerCount()} travailleurs',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 1000 + (index * 100)),
                ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: const Duration(milliseconds: 600),
            delay: Duration(milliseconds: 600 + (index * 100)),
          )
          .slideY(
            begin: 0.3,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            delay: Duration(milliseconds: 600 + (index * 100)),
          )
          .scale(
            begin: const Offset(0.8, 0.8),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            delay: Duration(milliseconds: 600 + (index * 100)),
          );
  }

  Color _getProfessionColor(int index) {
    final colors = [
      AppConstants.primaryColor,
      AppConstants.secondaryColor,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
      Colors.lightGreen,
    ];
    
    return colors[index % colors.length];
  }

  int _getRandomWorkerCount() {
    final random = DateTime.now().millisecond;
    return 10 + (random % 90);
  }
}