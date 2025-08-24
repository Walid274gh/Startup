import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../core/utils/language_utils.dart';
import '../models/service.dart';
import '../models/user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _selectedLocation = 'all';
  bool _isSearching = false;

  final List<String> _categories = [
    'all',
    'plomberie',
    'electricite',
    'menage',
    'jardinage',
    'demenagement',
    'climatisation',
    'reparation',
  ];

  final List<String> _locations = [
    'all',
    'alger_centre',
    'bab_ezzouar',
    'hydra',
    'bir_khadem',
    'dar_el_beida',
    'rouiba',
    'reghaia',
  ];

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Barre de recherche
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildSearchBar(),
            ),

            // Filtres
            SlideTransition(
              position: _slideAnimation,
              child: _buildFilters(),
            ),

            // Résultats de recherche
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildPopularServices(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: AppSizes.shadowBlurSmall,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                border: Border.all(
                  color: AppColors.borderLight,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: LanguageUtils.getText('fr', 'search_placeholder'),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                    size: AppSizes.iconMedium,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.textSecondary,
                            size: AppSizes.iconSmall,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _isSearching = false;
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingMedium,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isSearching = value.isNotEmpty;
                  });
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _isSearching = true;
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: IconButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  setState(() {
                    _isSearching = true;
                  });
                }
              },
              icon: Icon(
                Icons.tune,
                color: AppColors.textInverse,
                size: AppSizes.iconMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageUtils.getText('fr', 'search_filters'),
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: AppSizes.spacingSmall),
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  value: _selectedCategory,
                  items: _categories,
                  label: LanguageUtils.getText('fr', 'search_category'),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: _buildFilterDropdown(
                  value: _selectedLocation,
                  items: _locations,
                  label: LanguageUtils.getText('fr', 'search_location'),
                  onChanged: (value) {
                    setState(() {
                      _selectedLocation = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionLarge,
        ),
        const SizedBox(height: AppSizes.spacingSmall),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(
              color: AppColors.borderLight,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.textSecondary,
              ),
              style: AppTextStyles.bodyMedium,
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    _getLocalizedText(item),
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedText(String key) {
    switch (key) {
      case 'all':
        return LanguageUtils.getText('fr', 'search_filter_all');
      case 'plomberie':
        return 'Plomberie';
      case 'electricite':
        return 'Électricité';
      case 'menage':
        return 'Ménage';
      case 'jardinage':
        return 'Jardinage';
      case 'demenagement':
        return 'Déménagement';
      case 'climatisation':
        return 'Climatisation';
      case 'reparation':
        return 'Réparation';
      case 'alger_centre':
        return 'Alger Centre';
      case 'bab_ezzouar':
        return 'Bab Ezzouar';
      case 'hydra':
        return 'Hydra';
      case 'bir_khadem':
        return 'Bir Khadem';
      case 'dar_el_beida':
        return 'Dar El Beida';
      case 'rouiba':
        return 'Rouiba';
      case 'reghaia':
        return 'Reghaia';
      default:
        return key;
    }
  }

  Widget _buildPopularServices() {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      children: [
        Text(
          LanguageUtils.getText('fr', 'search_popular_services'),
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.spacingMedium,
            mainAxisSpacing: AppSizes.spacingMedium,
            childAspectRatio: 1.2,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return _buildServiceCard(_getPopularService(index));
          },
        ),
      ],
    );
  }

  Map<String, dynamic> _getPopularService(int index) {
    final services = [
      {
        'title': 'Plomberie',
        'icon': Icons.plumbing,
        'color': AppColors.primary,
        'workers': 45,
        'rating': 4.8,
      },
      {
        'title': 'Électricité',
        'icon': Icons.electrical_services,
        'color': AppColors.accent,
        'workers': 32,
        'rating': 4.7,
      },
      {
        'title': 'Ménage',
        'icon': Icons.cleaning_services,
        'color': AppColors.statusActive,
        'workers': 67,
        'rating': 4.6,
      },
      {
        'title': 'Jardinage',
        'icon': Icons.eco,
        'color': AppColors.statusActive,
        'workers': 28,
        'rating': 4.5,
      },
      {
        'title': 'Déménagement',
        'icon': Icons.local_shipping,
        'color': AppColors.primary,
        'workers': 23,
        'rating': 4.4,
      },
      {
        'title': 'Climatisation',
        'icon': Icons.ac_unit,
        'color': AppColors.accent,
        'workers': 19,
        'rating': 4.3,
      },
    ];
    return services[index];
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () {
        // Navigation vers la liste des travailleurs pour ce service
      },
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
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: service['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Icon(
                service['icon'],
                color: service['color'],
                size: AppSizes.iconLarge,
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            Text(
              service['title'],
              style: AppTextStyles.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  color: AppColors.textSecondary,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: AppSizes.spacingSmall),
                Text(
                  '${service['workers']}',
                  style: AppTextStyles.captionLarge,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.starFilled,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: AppSizes.spacingSmall),
                Text(
                  '${service['rating']}',
                  style: AppTextStyles.captionLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      children: [
        Text(
          LanguageUtils.getText('fr', 'search_results'),
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSizes.spacingMedium),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildWorkerCard();
          },
        ),
      ],
    );
  }

  Widget _buildWorkerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.marginMedium),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.person,
              color: AppColors.primary,
              size: AppSizes.iconLarge,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Benali',
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: AppSizes.spacingSmall),
                Text(
                  'Plombier professionnel',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSmall),
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
                      style: AppTextStyles.captionLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacingSmall),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.starFilled,
                      size: AppSizes.iconSmall,
                    ),
                    const SizedBox(width: AppSizes.spacingSmall),
                    Text(
                      '4.8 (156 avis)',
                      style: AppTextStyles.captionLarge,
                    ),
                    const SizedBox(width: AppSizes.spacingMedium),
                    Icon(
                      Icons.work,
                      color: AppColors.textSecondary,
                      size: AppSizes.iconSmall,
                    ),
                    const SizedBox(width: AppSizes.spacingSmall),
                    Text(
                      '89 missions',
                      style: AppTextStyles.captionLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                'À partir de',
                style: AppTextStyles.captionLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '500 DA',
                style: AppTextStyles.priceMedium,
              ),
              const SizedBox(height: AppSizes.spacingMedium),
              ElevatedButton(
                onPressed: () {
                  // Navigation vers le profil du travailleur
                },
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
                  LanguageUtils.getText('fr', 'search_view_profile'),
                  style: AppTextStyles.buttonSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}