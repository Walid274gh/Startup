import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../core/utils/language_utils.dart';
import '../models/worker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar avec photo de profil
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  LanguageUtils.getText('fr', 'profile_title'),
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
                child: Stack(
                  children: [
                    Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.textInverse,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow.withOpacity(0.3),
                                blurRadius: AppSizes.shadowBlurLarge,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 37,
                            backgroundColor: AppColors.surfacePrimary,
                            child: Icon(
                              Icons.person,
                              size: AppSizes.iconLarge,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Contenu principal
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Informations du profil
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildProfileInfo(),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Statistiques
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildStatistics(),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Services offerts
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildServicesOffered(),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Paramètres et options
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildSettings(),
                ),

                const SizedBox(height: AppSizes.spacingLarge),

                // Actions
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildActions(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
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
            'Ahmed Benali',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          Text(
            'Plombier professionnel',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
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
              Text(
                'Bab Ezzouar, Alger',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          Row(
            children: [
              Icon(
                Icons.verified,
                color: AppColors.statusActive,
                size: AppSizes.iconSmall,
              ),
              const SizedBox(width: AppSizes.spacingSmall),
              Text(
                'Vérifié et certifié',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.statusActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: Text(LanguageUtils.getText('fr', 'profile_edit')),
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
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: Text(LanguageUtils.getText('fr', 'profile_share')),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                      vertical: AppSizes.paddingSmall,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
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
            LanguageUtils.getText('fr', 'profile_statistics'),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.work,
                  value: '156',
                  label: LanguageUtils.getText('fr', 'profile_missions_completed'),
                  color: AppColors.statusActive,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  value: '4.8',
                  label: LanguageUtils.getText('fr', 'profile_rating'),
                  color: AppColors.starFilled,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.attach_money,
                  value: '45,200 DA',
                  label: LanguageUtils.getText('fr', 'profile_total_earnings'),
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.timer,
                  value: '12 min',
                  label: LanguageUtils.getText('fr', 'profile_avg_response'),
                  color: AppColors.statusActive,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.check_circle,
                  value: '98%',
                  label: LanguageUtils.getText('fr', 'profile_success_rate'),
                  color: AppColors.statusActive,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.people,
                  value: '89',
                  label: LanguageUtils.getText('fr', 'profile_clients_served'),
                  color: AppColors.primary,
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
          style: AppTextStyles.titleSmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.captionLarge,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildServicesOffered() {
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
            LanguageUtils.getText('fr', 'profile_services_offered'),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Wrap(
            spacing: AppSizes.spacingSmall,
            runSpacing: AppSizes.spacingSmall,
            children: [
              _buildServiceChip('Plomberie', AppColors.primary),
              _buildServiceChip('Électricité', AppColors.accent),
              _buildServiceChip('Climatisation', AppColors.statusActive),
              _buildServiceChip('Jardinage', AppColors.statusActive),
              _buildServiceChip('Ménage', AppColors.primary),
              _buildServiceChip('Déménagement', AppColors.accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
        ),
      ),
    );
  }

  Widget _buildSettings() {
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
            LanguageUtils.getText('fr', 'profile_settings'),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          _buildSettingItem(
            icon: Icons.notifications,
            title: LanguageUtils.getText('fr', 'profile_notifications'),
            subtitle: LanguageUtils.getText('fr', 'profile_notifications_subtitle'),
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.security,
            title: LanguageUtils.getText('fr', 'profile_security'),
            subtitle: LanguageUtils.getText('fr', 'profile_security_subtitle'),
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: LanguageUtils.getText('fr', 'profile_language'),
            subtitle: 'Français',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.palette,
            title: LanguageUtils.getText('fr', 'profile_appearance'),
            subtitle: LanguageUtils.getText('fr', 'profile_appearance_subtitle'),
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.help,
            title: LanguageUtils.getText('fr', 'profile_help_support'),
            subtitle: LanguageUtils.getText('fr', 'profile_help_support_subtitle'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSizes.paddingSmall),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: AppSizes.iconSmall,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.labelMedium,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.captionLarge,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
        size: AppSizes.iconSmall,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: Text(LanguageUtils.getText('fr', 'profile_logout')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.statusError,
              foregroundColor: AppColors.textInverse,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium,
                vertical: AppSizes.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever),
            label: Text(LanguageUtils.getText('fr', 'profile_delete_account')),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.statusError,
              side: BorderSide(color: AppColors.statusError),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium,
                vertical: AppSizes.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
            ),
          ),
        ),
      ],
    );
  }
}