import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class RecentRequestsSection extends ConsumerWidget {
  const RecentRequestsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Données simulées des demandes récentes
    final recentRequests = _getRecentRequests();

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
                'Demandes récentes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.request),
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
          
          // Liste des demandes récentes
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentRequests.length,
            itemBuilder: (context, index) {
              final request = recentRequests[index];
              return _buildRequestCard(
                context: context,
                request: request,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required BuildContext context,
    required Map<String, dynamic> request,
    required int index,
  }) {
    final status = request['status'] as String;
    final priority = request['priority'] as String;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.push('${AppRoutes.requestDetails}/${request['id']}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête avec titre et statut
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        request['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusChip(status),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Description
                Text(
                  request['description'],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12),
                
                // Détails de la demande
                Row(
                  children: [
                    // Profession requise
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 16,
                            color: AppConstants.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              request['profession'],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Budget
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${request['budget']} DA',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Pied de carte avec localisation, date et priorité
                Row(
                  children: [
                    // Localisation
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              request['location'],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(request['createdAt']),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Priorité
                    _buildPriorityChip(priority),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    switch (status.toLowerCase()) {
      case 'en_attente':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        label = 'En attente';
        break;
      case 'en_cours':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        label = 'En cours';
        break;
      case 'terminee':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        label = 'Terminée';
        break;
      case 'annulee':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = 'Annulée';
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        label = status;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    switch (priority.toLowerCase()) {
      case 'basse':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        label = 'Basse';
        break;
      case 'normale':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        label = 'Normale';
        break;
      case 'haute':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        label = 'Haute';
        break;
      case 'urgente':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = 'Urgente';
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        label = priority;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'À l\'instant';
      } else if (difference.inHours == 1) {
        return 'Il y a 1h';
      } else {
        return 'Il y a ${difference.inHours}h';
      }
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays}j';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  List<Map<String, dynamic>> _getRecentRequests() {
    return [
      {
        'id': '1',
        'title': 'Réparation de fuite d\'eau dans la salle de bain',
        'description': 'J\'ai une fuite d\'eau sous le lavabo de la salle de bain. Le robinet fuit et il y a de l\'eau qui s\'écoule.',
        'profession': 'Plombier',
        'budget': 1500,
        'location': 'Alger Centre',
        'status': 'en_attente',
        'priority': 'normale',
        'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'id': '2',
        'title': 'Installation d\'un système d\'éclairage LED',
        'description': 'Je souhaite installer un système d\'éclairage LED moderne dans mon salon et ma cuisine.',
        'profession': 'Électricien',
        'budget': 3000,
        'location': 'Bab Ezzouar',
        'status': 'en_cours',
        'priority': 'haute',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'id': '3',
        'title': 'Peinture des murs du salon',
        'description': 'Besoin de repeindre les murs du salon. Surface d\'environ 25m². Couleur à discuter.',
        'profession': 'Peintre',
        'budget': 2500,
        'location': 'Hydra',
        'status': 'terminee',
        'priority': 'basse',
        'createdAt': DateTime.now().subtract(const Duration(days: 3)),
      },
    ];
  }
}

// Widget alternatif avec animation Flutter Animate
class RecentRequestsSectionAnimated extends ConsumerWidget {
  const RecentRequestsSectionAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentRequests = _getRecentRequests();

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
                'Demandes récentes',
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
                onPressed: () => context.push(AppRoutes.request),
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
          
          // Liste avec animation
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentRequests.length,
            itemBuilder: (context, index) {
              final request = recentRequests[index];
              return _buildRequestCardAnimated(
                context: context,
                request: request,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCardAnimated({
    required BuildContext context,
    required Map<String, dynamic> request,
    required int index,
  }) {
    final status = request['status'] as String;
    final priority = request['priority'] as String;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.push('${AppRoutes.requestDetails}/${request['id']}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        request['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusChip(status),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  request['description'],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 16,
                            color: AppConstants.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              request['profession'],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${request['budget']} DA',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              request['location'],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(request['createdAt']),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(width: 16),
                    
                    _buildPriorityChip(priority),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: 600 + (index * 200)),
        )
        .slideY(
          begin: 0.3,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          delay: Duration(milliseconds: 600 + (index * 200)),
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          delay: Duration(milliseconds: 600 + (index * 200)),
        );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    switch (status.toLowerCase()) {
      case 'en_attente':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        label = 'En attente';
        break;
      case 'en_cours':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        label = 'En cours';
        break;
      case 'terminee':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        label = 'Terminée';
        break;
      case 'annulee':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = 'Annulée';
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        label = status;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    switch (priority.toLowerCase()) {
      case 'basse':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        label = 'Basse';
        break;
      case 'normale':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        label = 'Normale';
        break;
      case 'haute':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        label = 'Haute';
        break;
      case 'urgente':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = 'Urgente';
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        label = priority;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'À l\'instant';
      } else if (difference.inHours == 1) {
        return 'Il y a 1h';
      } else {
        return 'Il y a ${difference.inHours}h';
      }
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays}j';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  List<Map<String, dynamic>> _getRecentRequests() {
    return [
      {
        'id': '1',
        'title': 'Réparation de fuite d\'eau dans la salle de bain',
        'description': 'J\'ai une fuite d\'eau sous le lavabo de la salle de bain. Le robinet fuit et il y a de l\'eau qui s\'écoule.',
        'profession': 'Plombier',
        'budget': 1500,
        'location': 'Alger Centre',
        'status': 'en_attente',
        'priority': 'normale',
        'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'id': '2',
        'title': 'Installation d\'un système d\'éclairage LED',
        'description': 'Je souhaite installer un système d\'éclairage LED moderne dans mon salon et ma cuisine.',
        'profession': 'Électricien',
        'budget': 3000,
        'location': 'Bab Ezzouar',
        'status': 'en_cours',
        'priority': 'haute',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'id': '3',
        'title': 'Peinture des murs du salon',
        'description': 'Besoin de repeindre les murs du salon. Surface d\'environ 25m². Couleur à discuter.',
        'profession': 'Peintre',
        'budget': 2500,
        'location': 'Hydra',
        'status': 'terminee',
        'priority': 'basse',
        'createdAt': DateTime.now().subtract(const Duration(days: 3)),
      },
    ];
  }
}