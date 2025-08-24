import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';
import '../widgets/home_header.dart';
import '../widgets/search_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/featured_workers_section.dart';
import '../widgets/recent_requests_section.dart';
import '../widgets/quick_actions_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
      });
    } else if (_scrollController.offset <= 100 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // En-tête de la page d'accueil
          SliverToBoxAdapter(
            child: HomeHeader(
              userName: appState.currentUser?.username ?? 'Utilisateur',
              userAvatar: appState.currentUser?.profileImage,
            ),
          ),
          
          // Section de recherche
          SliverToBoxAdapter(
            child: SearchSection(),
          ),
          
          // Section des catégories
          SliverToBoxAdapter(
            child: CategoriesSection(),
          ),
          
          // Section des travailleurs en vedette
          SliverToBoxAdapter(
            child: FeaturedWorkersSection(),
          ),
          
          // Section des demandes récentes
          SliverToBoxAdapter(
            child: RecentRequestsSection(),
          ),
          
          // Section des actions rapides
          SliverToBoxAdapter(
            child: QuickActionsSection(),
          ),
          
          // Espace en bas pour le bouton flottant
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      
      // Bouton flottant pour créer une demande
      floatingActionButton: _showFloatingButton
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.request),
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: const Icon(Icons.add),
              label: const Text(
                'Nouvelle demande',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
              .animate()
              .scale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
              )
          : null,
      
      // Bouton flottant pour le chat
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Widget alternatif avec animation Flutter Animate
class HomePageAnimated extends ConsumerStatefulWidget {
  const HomePageAnimated({super.key});

  @override
  ConsumerState<HomePageAnimated> createState() => _HomePageAnimatedState();
}

class _HomePageAnimatedState extends ConsumerState<HomePageAnimated> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
      });
    } else if (_scrollController.offset <= 100 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // En-tête avec animation
          SliverToBoxAdapter(
            child: HomeHeader(
              userName: appState.currentUser?.username ?? 'Utilisateur',
              userAvatar: appState.currentUser?.profileImage,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                )
                .slideY(
                  begin: -0.3,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  delay: const Duration(milliseconds: 200),
                ),
          ),
          
          // Section de recherche avec animation
          SliverToBoxAdapter(
            child: SearchSection()
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                )
                .slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  delay: const Duration(milliseconds: 400),
                ),
          ),
          
          // Section des catégories avec animation
          SliverToBoxAdapter(
            child: CategoriesSection()
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 600),
                )
                .slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  delay: const Duration(milliseconds: 600),
                ),
          ),
          
          // Section des travailleurs en vedette avec animation
          SliverToBoxAdapter(
            child: FeaturedWorkersSection()
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 800),
                )
                .slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  delay: const Duration(milliseconds: 800),
                ),
          ),
          
          // Section des demandes récentes avec animation
          SliverToBoxAdapter(
            child: RecentRequestsSection()
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
          ),
          
          // Section des actions rapides avec animation
          SliverToBoxAdapter(
            child: QuickActionsSection()
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 1200),
                )
                .slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  delay: const Duration(milliseconds: 1200),
                ),
          ),
          
          // Espace en bas pour le bouton flottant
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      
      // Bouton flottant avec animation
      floatingActionButton: _showFloatingButton
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.request),
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: const Icon(Icons.add),
              label: const Text(
                'Nouvelle demande',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
                .animate()
                .scale(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                )
                .then()
                .shimmer(
                  duration: const Duration(milliseconds: 2000),
                  delay: const Duration(milliseconds: 500),
                )
          : null,
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}