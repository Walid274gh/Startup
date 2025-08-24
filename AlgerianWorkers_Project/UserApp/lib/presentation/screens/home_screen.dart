import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/service.dart';
import '../../models/user.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/utils/language_utils.dart';

/// Écran d'accueil principal de l'application Khidmeti (Utilisateurs)
/// 
/// Cet écran affiche :
/// - Services populaires avec animations fluides
/// - Statistiques du réseau de travailleurs
/// - Actualités et promotions
/// - Accès rapide aux fonctionnalités principales
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final ScrollController _scrollController = ScrollController();
  String _selectedLanguage = 'fr';
  
  // Données simulées pour la démonstration
  final List<Service> _popularServices = [
    Service(
      id: 'plumbing',
      name: 'Plomberie',
      nameAr: 'سباكة',
      nameEn: 'Plumbing',
      icon: '🔧',
      description: 'Services de plomberie professionnels',
      descriptionAr: 'خدمات سباكة احترافية',
      descriptionEn: 'Professional plumbing services',
      category: ServiceCategory.repair,
      complexityLevel: 3,
      averagePrice: 2500.0,
      isActive: true,
      availableWorkersCount: 15,
      averageRating: 4.7,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: 'electricity',
      name: 'Électricité',
      nameAr: 'كهرباء',
      nameEn: 'Electricity',
      icon: '⚡',
      description: 'Installation et réparation électrique',
      descriptionAr: 'تركيب وإصلاح كهربائي',
      descriptionEn: 'Electrical installation and repair',
      category: ServiceCategory.repair,
      complexityLevel: 4,
      averagePrice: 3000.0,
      isActive: true,
      availableWorkersCount: 12,
      averageRating: 4.8,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Service(
      id: 'cleaning',
      name: 'Nettoyage',
      nameAr: 'تنظيف',
      nameEn: 'Cleaning',
      icon: '🧹',
      description: 'Services de nettoyage professionnels',
      descriptionAr: 'خدمات تنظيف احترافية',
      descriptionEn: 'Professional cleaning services',
      category: ServiceCategory.cleaning,
      complexityLevel: 2,
      averagePrice: 1500.0,
      isActive: true,
      availableWorkersCount: 25,
      averageRating: 4.5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserPreferences();
  }

  void _initializeAnimations() {
    // Contrôleur d'animation de fondu
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Contrôleur d'animation de glissement
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Contrôleur d'animation d'échelle
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Démarrer les animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  Future<void> _loadUserPreferences() async {
    // Simuler le chargement des préférences utilisateur
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _selectedLanguage = 'fr'; // Par défaut en français
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar personnalisée
            _buildSliverAppBar(),
            
            // Contenu principal
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section de bienvenue
                    _buildWelcomeSection(),
                    
                    const SizedBox(height: AppSizes.spacingLarge),
                    
                    // Section des services populaires
                    _buildPopularServicesSection(),
                    
                    const SizedBox(height: AppSizes.spacingLarge),
                    
                    // Section des statistiques
                    _buildStatisticsSection(),
                    
                    const SizedBox(height: AppSizes.spacingLarge),
                    
                    // Section des actualités
                    _buildNewsSection(),
                    
                    const SizedBox(height: AppSizes.spacingLarge),
                    
                    // Section d'accès rapide
                    _buildQuickAccessSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construction de l'App Bar personnalisée
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            LanguageUtils.getText('Khidmeti', _selectedLanguage),
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Motif décoratif
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Bouton de notification
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            // Navigation vers les notifications
          },
        ),
        // Bouton de profil
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.white),
          onPressed: () {
            // Navigation vers le profil
          },
        ),
      ],
    );
  }

  /// Section de bienvenue
  Widget _buildWelcomeSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accentLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageUtils.getText('Bienvenue sur Khidmeti', _selectedLanguage),
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingSmall),
                  Text(
                    LanguageUtils.getText(
                      'Trouvez les meilleurs travailleurs pour vos besoins',
                      _selectedLanguage,
                    ),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.handshake,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section des services populaires
  Widget _buildPopularServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageUtils.getText('Services Populaires', _selectedLanguage),
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _popularServices.length,
            itemBuilder: (context, index) {
              final service = _popularServices[index];
              return _buildServiceCard(service, index);
            },
          ),
        ),
      ],
    );
  }

  /// Carte de service
  Widget _buildServiceCard(Service service, int index) {
    return AnimatedBuilder(
      animation: _scaleController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 160,
            margin: EdgeInsets.only(
              right: index == _popularServices.length - 1 ? 0 : AppSizes.spacingMedium,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                onTap: () {
                  // Navigation vers le service
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icône du service
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            service.icon,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingMedium),
                      
                      // Nom du service
                      Text(
                        LanguageUtils.getText(service.name, _selectedLanguage),
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSizes.spacingSmall),
                      
                      // Prix moyen
                      Text(
                        '${service.averagePrice.toStringAsFixed(0)} DA',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingSmall),
                      
                      // Travailleurs disponibles
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${service.availableWorkersCount}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section des statistiques
  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageUtils.getText('Statistiques du Réseau', _selectedLanguage),
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.people,
                  value: '2,847',
                  label: LanguageUtils.getText('Travailleurs', _selectedLanguage),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.star,
                  value: '4.8',
                  label: LanguageUtils.getText('Note Moyenne', _selectedLanguage),
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.check_circle,
                  value: '15,234',
                  label: LanguageUtils.getText('Missions', _selectedLanguage),
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Carte de statistique
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Section des actualités
  Widget _buildNewsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LanguageUtils.getText('Actualités & Promotions', _selectedLanguage),
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Voir toutes les actualités
                },
                child: Text(
                  LanguageUtils.getText('Voir tout', _selectedLanguage),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildNewsCard(
            title: LanguageUtils.getText(
              'Nouveaux travailleurs certifiés',
              _selectedLanguage,
            ),
            subtitle: LanguageUtils.getText(
              'Plus de 50 nouveaux travailleurs ont rejoint notre réseau',
              _selectedLanguage,
            ),
            icon: Icons.verified_user,
            color: AppColors.success,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildNewsCard(
            title: LanguageUtils.getText(
              'Promotion spéciale',
              _selectedLanguage,
            ),
            subtitle: LanguageUtils.getText(
              '-20% sur tous les services de nettoyage ce mois-ci',
              _selectedLanguage,
            ),
            icon: Icons.local_offer,
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }

  /// Carte d'actualité
  Widget _buildNewsCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSmall),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section d'accès rapide
  Widget _buildQuickAccessSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageUtils.getText('Accès Rapide', _selectedLanguage),
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          Row(
            children: [
              Expanded(
                child: _buildQuickAccessButton(
                  icon: Icons.search,
                  label: LanguageUtils.getText('Rechercher', _selectedLanguage),
                  color: AppColors.primary,
                  onTap: () {
                    // Navigation vers la recherche
                  },
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildQuickAccessButton(
                  icon: Icons.add_circle,
                  label: LanguageUtils.getText('Nouvelle Demande', _selectedLanguage),
                  color: AppColors.accent,
                  onTap: () {
                    // Navigation vers la création de demande
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: _buildQuickAccessButton(
                  icon: Icons.chat,
                  label: LanguageUtils.getText('Messages', _selectedLanguage),
                  color: AppColors.success,
                  onTap: () {
                    // Navigation vers les messages
                  },
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildQuickAccessButton(
                  icon: Icons.history,
                  label: LanguageUtils.getText('Historique', _selectedLanguage),
                  color: AppColors.info,
                  onTap: () {
                    // Navigation vers l'historique
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Bouton d'accès rapide
  Widget _buildQuickAccessButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                  textAlign: TextAlign.center,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}