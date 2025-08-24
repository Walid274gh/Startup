import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../core/utils/language_utils.dart';
import '../models/mission.dart';
import '../models/worker.dart';

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

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: AppSizes.animationNormal,
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: AppSizes.animationNormal,
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: AppSizes.animationFast,
      vsync: this,
    );

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

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar avec salutations
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    LanguageUtils.getText('fr', 'home_greeting'),
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primaryVariant,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Contenu principal
            SliverPadding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Statistiques rapides
                  SlideTransition(
                    position: _slideAnimation,
                    child: _buildQuickStats(),
                  ),

                  const SizedBox(height: AppSizes.spacingLarge),

                  // Missions disponibles
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildAvailableMissions(),
                  ),

                  const SizedBox(height: AppSizes.spacingLarge),

                  // Actions rapides
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildQuickActions(),
                  ),

                  const SizedBox(height: AppSizes.spacingLarge),

                  // Nouvelles et promotions
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildNewsAndPromotions(),
                  ),

                  const SizedBox(height: AppSizes.spacingLarge),

                  // Statistiques de performance
                  SlideTransition(
                    position: _slideAnimation,
                    child: _buildPerformanceStats(),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: AppSizes.shadowBlurMedium,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageUtils.getText('fr', 'home_quick_stats'),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.work,
                  value: '12',
                  label: LanguageUtils.getText('fr', 'home_missions_completed'),
                  color: AppColors.statusActive,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  value: '4.8',
                  label: LanguageUtils.getText('fr', 'home_rating'),
                  color: AppColors.starFilled,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.attach_money,
                  value: '2,450 DA',
                  label: LanguageUtils.getText('fr', 'home_earnings'),
                  color: AppColors.accent,
                ),
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
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: AppSizes.iconMedium,
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.captionLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAvailableMissions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageUtils.getText('fr', 'home_available_missions'),
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 280,
                margin: EdgeInsets.only(
                  right: index < 4 ? AppSizes.marginMedium : 0,
                ),
                child: _buildMissionCard(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: AppSizes.shadowBlurSmall,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingSmall),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
                child: Icon(
                  Icons.home_repair_service,
                  color: AppColors.primary,
                  size: AppSizes.iconSmall,
                ),
              ),
              const SizedBox(width: AppSizes.spacingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plomberie',
                      style: AppTextStyles.titleSmall,
                    ),
                    Text(
                      'Urgent - 2h',
                      style: AppTextStyles.captionLarge.copyWith(
                        color: AppColors.priorityUrgent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            'Réparation fuite robinet cuisine',
            style: AppTextStyles.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.textSecondary,
                size: AppSizes.iconSmall,
              ),
              const SizedBox(width: AppSizes.spacingSmall),
              Expanded(
                child: Text(
                  'Bab Ezzouar, Alger',
                  style: AppTextStyles.captionLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '500 - 800 DA',
                style: AppTextStyles.priceMedium,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textInverse,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
                child: Text(
                  LanguageUtils.getText('fr', 'home_apply'),
                  style: AppTextStyles.buttonSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageUtils.getText('fr', 'home_quick_actions'),
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.spacingMedium,
          mainAxisSpacing: AppSizes.spacingMedium,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              icon: Icons.search,
              title: LanguageUtils.getText('fr', 'home_search_missions'),
              color: AppColors.primary,
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.schedule,
              title: LanguageUtils.getText('fr', 'home_my_schedule'),
              color: AppColors.accent,
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.analytics,
              title: LanguageUtils.getText('fr', 'home_analytics'),
              color: AppColors.statusActive,
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.support_agent,
              title: LanguageUtils.getText('fr', 'home_support'),
              color: AppColors.notificationInfo,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          border: Border.all(
            color: AppColors.borderLight,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.05),
              blurRadius: AppSizes.shadowBlurSmall,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: AppSizes.iconLarge,
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            Text(
              title,
              style: AppTextStyles.labelMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsAndPromotions() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.campaign,
                color: AppColors.accent,
                size: AppSizes.iconMedium,
              ),
              const SizedBox(width: AppSizes.spacingSmall),
              Text(
                LanguageUtils.getText('fr', 'home_news_promotions'),
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            '🎉 Bonus de 20% sur toutes les missions cette semaine !',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.textInverse,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium,
                vertical: AppSizes.paddingSmall,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            child: Text(
              LanguageUtils.getText('fr', 'home_learn_more'),
              style: AppTextStyles.buttonSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceStats() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: AppSizes.shadowBlurMedium,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageUtils.getText('fr', 'home_performance_stats'),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceItem(
                  label: LanguageUtils.getText('fr', 'home_response_time'),
                  value: '15 min',
                  progress: 0.8,
                  color: AppColors.statusActive,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildPerformanceItem(
                  label: LanguageUtils.getText('fr', 'home_completion_rate'),
                  value: '95%',
                  progress: 0.95,
                  color: AppColors.statusActive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem({
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionLarge,
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.borderLight,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 4,
        ),
      ],
    );
  }
}