import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _progressValue;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Contrôleur pour l'animation du logo
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Contrôleur pour l'animation du texte
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Contrôleur pour l'animation de la barre de progression
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Animation du logo
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    // Animation du texte
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    // Animation de la barre de progression
    _progressValue = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  void _startSplashSequence() async {
    // Démarrer l'animation du logo
    await _logoController.forward();
    
    // Attendre un peu puis démarrer l'animation du texte
    await Future.delayed(const Duration(milliseconds: 300));
    await _textController.forward();
    
    // Démarrer l'animation de la barre de progression
    await Future.delayed(const Duration(milliseconds: 200));
    await _progressController.forward();
    
    // Attendre que tout soit terminé puis naviguer
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Vérifier si l'utilisateur est authentifié
    final isAuthenticated = ref.read(appStateProvider).isAuthenticated;
    
    if (mounted) {
      if (isAuthenticated) {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.auth);
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomColors>();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              customColors?.gradientStart ?? AppConstants.primaryColor,
              customColors?.gradientEnd ?? AppConstants.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Espace en haut
              const Spacer(flex: 2),
              
              // Logo principal
              _buildLogo(),
              
              const SizedBox(height: 40),
              
              // Titre de l'application
              _buildAppTitle(),
              
              const SizedBox(height: 16),
              
              // Sous-titre
              _buildSubtitle(),
              
              const Spacer(flex: 2),
              
              // Barre de progression
              _buildProgressBar(),
              
              const SizedBox(height: 40),
              
              // Texte de chargement
              _buildLoadingText(),
              
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScale.value,
          child: Opacity(
            opacity: _logoOpacity.value,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.work_outline,
                size: 60,
                color: AppConstants.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppTitle() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Text(
              AppConstants.appName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Text(
              'Connecter les travailleurs et les clients',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _progressValue.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingText() {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _progressValue,
          child: Text(
            'Chargement...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

// Widget alternatif avec animation Flutter Animate
class SplashPageAnimated extends ConsumerWidget {
  const SplashPageAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomColors>();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              customColors?.gradientStart ?? AppConstants.primaryColor,
              customColors?.gradientEnd ?? AppConstants.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Logo avec animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.work_outline,
                  size: 60,
                  color: AppConstants.primaryColor,
                ),
              )
                  .animate()
                  .scale(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                  ),
              
              const SizedBox(height: 40),
              
              // Titre avec animation
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .slideY(
                    begin: 0.5,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                    delay: const Duration(milliseconds: 500),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 500),
                  ),
              
              const SizedBox(height: 16),
              
              // Sous-titre avec animation
              Text(
                'Connecter les travailleurs et les clients',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .slideY(
                    begin: 0.5,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                    delay: const Duration(milliseconds: 700),
                  )
                  .fadeIn(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 700),
                  ),
              
              const Spacer(flex: 2),
              
              // Barre de progression avec animation
              Container(
                width: 200,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .scaleX(
                    begin: 0.0,
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeInOut,
                    delay: const Duration(milliseconds: 1200),
                  ),
              
              const SizedBox(height: 40),
              
              // Texte de chargement avec animation
              Text(
                'Chargement...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 2000),
                  ),
              
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    ).animate().onComplete((controller) {
      // Navigation automatique après l'animation
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          // Vérifier si l'utilisateur est authentifié
          final isAuthenticated = ref.read(appStateProvider).isAuthenticated;
          
          if (isAuthenticated) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.auth);
          }
        }
      });
    });
  }
}