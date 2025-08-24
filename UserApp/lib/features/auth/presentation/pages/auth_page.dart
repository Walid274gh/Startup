import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import '../widgets/otp_verification.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              // En-tête avec logo et titre
              _buildHeader(),
              
              const SizedBox(height: 40),
              
              // Onglets de connexion/inscription
              _buildTabs(),
              
              const SizedBox(height: 20),
              
              // Contenu des onglets
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Onglet Connexion
                    _buildLoginTab(),
                    
                    // Onglet Inscription
                    _buildRegisterTab(),
                  ],
                ),
              ),
              
              // Pied de page
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.work_outline,
              size: 40,
              color: AppConstants.primaryColor,
            ),
          )
              .animate()
              .scale(
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              ),
          
          const SizedBox(height: 20),
          
          // Titre
          Text(
            'Bienvenue',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          )
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 200),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 200),
              ),
          
          const SizedBox(height: 8),
          
          // Sous-titre
          Text(
            'Connectez-vous ou créez votre compte',
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
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 400),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
              ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: AppConstants.primaryColor,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _currentTabIndex == 0 ? Icons.login : Icons.login_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text('Connexion'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _currentTabIndex == 1 ? Icons.person_add : Icons.person_add_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text('Inscription'),
              ],
            ),
          ),
        ],
      )
          .animate()
          .slideY(
            begin: 0.3,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            delay: const Duration(milliseconds: 600),
          )
          .fadeIn(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 600),
          ),
    );
  }

  Widget _buildLoginTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Formulaire de connexion
          const LoginForm()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 800),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 800),
              ),
          
          const SizedBox(height: 24),
          
          // Séparateur
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'ou',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 1,
                ),
              ),
            ],
          )
              .animate()
              .scaleX(
                begin: 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1000),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1000),
              ),
          
          const SizedBox(height: 24),
          
          // Bouton Google
          _buildGoogleButton()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1200),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1200),
              ),
          
          const SizedBox(height: 16),
          
          // Bouton téléphone
          _buildPhoneButton()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1400),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1400),
              ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Formulaire d'inscription
          const RegisterForm()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 800),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 800),
              ),
          
          const SizedBox(height: 24),
          
          // Séparateur
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'ou',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 1,
                ),
              ),
            ],
          )
              .animate()
              .scaleX(
                begin: 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1000),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1000),
              ),
          
          const SizedBox(height: 24),
          
          // Bouton Google
          _buildGoogleButton()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1200),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1200),
              ),
          
          const SizedBox(height: 16),
          
          // Bouton téléphone
          _buildPhoneButton()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1400),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1400),
              ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            // TODO: Implémenter la connexion Google
            _showComingSoonDialog();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/google.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.g_mobiledata,
                    size: 20,
                    color: AppConstants.primaryColor,
                  );
                },
              ),
              const SizedBox(width: 12),
              Text(
                'Continuer avec Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            // TODO: Implémenter la connexion par téléphone
            _showComingSoonDialog();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                'Continuer avec le téléphone',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Lien vers les conditions d'utilisation
          TextButton(
            onPressed: () {
              context.go(AppRoutes.terms);
            },
            child: Text(
              'En continuant, vous acceptez nos conditions d\'utilisation',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1600),
              ),
          
          const SizedBox(height: 16),
          
          // Lien vers la politique de confidentialité
          TextButton(
            onPressed: () {
              context.go(AppRoutes.privacy);
            },
            child: Text(
              'Politique de confidentialité',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontFamily: 'Poppins',
                decoration: TextDecoration.underline,
              ),
            ),
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1800),
              ),
        ],
      ),
    );
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fonctionnalité à venir'),
        content: const Text(
          'Cette fonctionnalité sera bientôt disponible. '
          'Veuillez utiliser le formulaire de connexion/inscription classique pour l\'instant.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Widget pour la vérification OTP
class OTPVerificationPage extends ConsumerWidget {
  final String phoneNumber;
  final String verificationId;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification OTP'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppConstants.primaryColor,
              AppConstants.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                
                // Icône de téléphone
                Icon(
                  Icons.phone_android,
                  size: 80,
                  color: Colors.white,
                )
                    .animate()
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                    ),
                
                const SizedBox(height: 32),
                
                // Titre
                Text(
                  'Vérification OTP',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                )
                    .animate()
                    .slideY(
                      begin: 0.3,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      delay: const Duration(milliseconds: 200),
                    )
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                    ),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  'Nous avons envoyé un code de vérification au numéro\n$phoneNumber',
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
                      begin: 0.3,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      delay: const Duration(milliseconds: 400),
                    )
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                    ),
                
                const SizedBox(height: 40),
                
                // Formulaire OTP
                OTPVerification(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                )
                    .animate()
                    .slideY(
                      begin: 0.3,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      delay: const Duration(milliseconds: 600),
                    )
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 600),
                    ),
                
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}