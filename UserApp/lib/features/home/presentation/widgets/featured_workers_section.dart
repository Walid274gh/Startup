import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/constants.dart';

class FeaturedWorkersSection extends ConsumerWidget {
  const FeaturedWorkersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Données simulées des travailleurs en vedette
    final featuredWorkers = _getFeaturedWorkers();

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
                'Travailleurs en vedette',
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
          
          // Liste horizontale des travailleurs
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredWorkers.length,
              itemBuilder: (context, index) {
                final worker = featuredWorkers[index];
                return _buildWorkerCard(
                  context: context,
                  worker: worker,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerCard({
    required BuildContext context,
    required Map<String, dynamic> worker,
    required int index,
  }) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(
        right: index == _getFeaturedWorkers().length - 1 ? 0 : 16,
      ),
      child: GestureDetector(
        onTap: () => context.push('${AppRoutes.workerDetails}/${worker['id']}'),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de profil et badge de vérification
              Stack(
                children: [
                  // Image de profil
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: worker['profileImage'] != null
                          ? CachedNetworkImage(
                              imageUrl: worker['profileImage'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                  size: 40,
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  
                  // Badge de vérification
                  if (worker['isVerified'] == true)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  
                  // Badge de disponibilité
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: worker['isOnline'] == true ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        worker['isOnline'] == true ? 'En ligne' : 'Hors ligne',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Informations du travailleur
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom du travailleur
                    Text(
                      worker['fullName'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Profession
                    Text(
                      worker['profession'],
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Note et tarif
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Note
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              worker['rating'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        
                        // Tarif horaire
                        Text(
                          '${worker['hourlyRate']} DA/h',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryColor,
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
      ),
    );
  }

  List<Map<String, dynamic>> _getFeaturedWorkers() {
    return [
      {
        'id': '1',
        'fullName': 'Ahmed Benali',
        'profession': 'Plombier',
        'profileImage': null,
        'rating': 4.8,
        'hourlyRate': 800,
        'isVerified': true,
        'isOnline': true,
      },
      {
        'id': '2',
        'fullName': 'Fatima Zohra',
        'profession': 'Électricienne',
        'profileImage': null,
        'rating': 4.9,
        'hourlyRate': 900,
        'isVerified': true,
        'isOnline': false,
      },
      {
        'id': '3',
        'fullName': 'Karim Boudiaf',
        'profession': 'Peintre',
        'profileImage': null,
        'rating': 4.7,
        'hourlyRate': 700,
        'isVerified': false,
        'isOnline': true,
      },
      {
        'id': '4',
        'fullName': 'Nadia Messaoudi',
        'profession': 'Jardinier',
        'profileImage': null,
        'rating': 4.6,
        'hourlyRate': 600,
        'isVerified': true,
        'isOnline': true,
      },
      {
        'id': '5',
        'fullName': 'Omar Tounsi',
        'profession': 'Mécanicien',
        'profileImage': null,
        'rating': 4.5,
        'hourlyRate': 1000,
        'isVerified': false,
        'isOnline': false,
      },
    ];
  }
}

// Widget alternatif avec animation Flutter Animate
class FeaturedWorkersSectionAnimated extends ConsumerWidget {
  const FeaturedWorkersSectionAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredWorkers = _getFeaturedWorkers();

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
                'Travailleurs en vedette',
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
          
          // Liste horizontale avec animation
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredWorkers.length,
              itemBuilder: (context, index) {
                final worker = featuredWorkers[index];
                return _buildWorkerCardAnimated(
                  context: context,
                  worker: worker,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerCardAnimated({
    required BuildContext context,
    required Map<String, dynamic> worker,
    required int index,
  }) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(
        right: index == _getFeaturedWorkers().length - 1 ? 0 : 16,
      ),
      child: GestureDetector(
        onTap: () => context.push('${AppRoutes.workerDetails}/${worker['id']}'),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de profil et badges avec animation
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: worker['profileImage'] != null
                          ? CachedNetworkImage(
                              imageUrl: worker['profileImage'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                  size: 40,
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  
                  if (worker['isVerified'] == true)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          delay: Duration(milliseconds: 800 + (index * 200)),
                        ),
                  
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: worker['isOnline'] == true ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        worker['isOnline'] == true ? 'En ligne' : 'Hors ligne',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          delay: Duration(milliseconds: 1000 + (index * 200)),
                        ),
                  ),
                ],
              ),
              
              // Informations avec animation
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker['fullName'],
                      style: const TextStyle(
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
                          delay: Duration(milliseconds: 1200 + (index * 200)),
                        ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      worker['profession'],
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: Duration(milliseconds: 1400 + (index * 200)),
                        ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              worker['rating'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          '${worker['hourlyRate']} DA/h',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: Duration(milliseconds: 1600 + (index * 200)),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: 600 + (index * 200)),
        )
        .slideX(
          begin: 0.3,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          delay: Duration(milliseconds: 600 + (index * 200)),
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          delay: Duration(milliseconds: 600 + (index * 200)),
        );
  }

  List<Map<String, dynamic>> _getFeaturedWorkers() {
    return [
      {
        'id': '1',
        'fullName': 'Ahmed Benali',
        'profession': 'Plombier',
        'profileImage': null,
        'rating': 4.8,
        'hourlyRate': 800,
        'isVerified': true,
        'isOnline': true,
      },
      {
        'id': '2',
        'fullName': 'Fatima Zohra',
        'profession': 'Électricienne',
        'profileImage': null,
        'rating': 4.9,
        'hourlyRate': 900,
        'isVerified': true,
        'isOnline': false,
      },
      {
        'id': '3',
        'fullName': 'Karim Boudiaf',
        'profession': 'Peintre',
        'profileImage': null,
        'rating': 4.7,
        'hourlyRate': 700,
        'isVerified': false,
        'isOnline': true,
      },
      {
        'id': '4',
        'fullName': 'Nadia Messaoudi',
        'profession': 'Jardinier',
        'profileImage': null,
        'rating': 4.6,
        'hourlyRate': 600,
        'isVerified': true,
        'isOnline': true,
      },
      {
        'id': '5',
        'fullName': 'Omar Tounsi',
        'profession': 'Mécanicien',
        'profileImage': null,
        'rating': 4.5,
        'hourlyRate': 1000,
        'isVerified': false,
        'isOnline': false,
      },
    ];
  }
}