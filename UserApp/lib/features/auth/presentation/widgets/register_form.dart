import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;
  bool _acceptMarketing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Champ nom d'utilisateur
          _buildUsernameField(),
          
          const SizedBox(height: 20),
          
          // Champ email
          _buildEmailField(),
          
          const SizedBox(height: 20),
          
          // Champ téléphone
          _buildPhoneField(),
          
          const SizedBox(height: 20),
          
          // Champ mot de passe
          _buildPasswordField(),
          
          const SizedBox(height: 20),
          
          // Champ confirmation mot de passe
          _buildConfirmPasswordField(),
          
          const SizedBox(height: 20),
          
          // Cases à cocher
          _buildCheckboxes(),
          
          const SizedBox(height: 24),
          
          // Bouton d'inscription
          _buildRegisterButton(),
          
          const SizedBox(height: 16),
          
          // Lien vers la connexion
          _buildLoginLink(),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _usernameController,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Nom d\'utilisateur',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le nom d\'utilisateur est obligatoire';
          }
          if (value.length < 3) {
            return 'Le nom d\'utilisateur doit contenir au moins 3 caractères';
          }
          if (value.length > 20) {
            return 'Le nom d\'utilisateur ne peut pas dépasser 20 caractères';
          }
          if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
            return 'Le nom d\'utilisateur ne peut contenir que des lettres, chiffres et underscores';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Adresse email',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'L\'email est obligatoire';
          }
          if (!_isValidEmail(value)) {
            return 'Veuillez entrer un email valide';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Numéro de téléphone',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.phone_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le numéro de téléphone est obligatoire';
          }
          if (!_isValidPhone(value)) {
            return 'Veuillez entrer un numéro de téléphone valide';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le mot de passe est obligatoire';
          }
          if (value.length < 8) {
            return 'Le mot de passe doit contenir au moins 8 caractères';
          }
          if (!_isValidPassword(value)) {
            return 'Le mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule et un chiffre';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Confirmer le mot de passe',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'La confirmation du mot de passe est obligatoire';
          }
          if (value != _passwordController.text) {
            return 'Les mots de passe ne correspondent pas';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildCheckboxes() {
    return Column(
      children: [
        // Case à cocher conditions d'utilisation
        Row(
          children: [
            Checkbox(
              value: _acceptTerms,
              onChanged: (value) {
                setState(() {
                  _acceptTerms = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _acceptTerms = !_acceptTerms;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'J\'accepte les '),
                      TextSpan(
                        text: 'conditions d\'utilisation',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Case à cocher politique de confidentialité
        Row(
          children: [
            Checkbox(
              value: _acceptPrivacy,
              onChanged: (value) {
                setState(() {
                  _acceptPrivacy = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _acceptPrivacy = !_acceptPrivacy;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'J\'accepte la '),
                      TextSpan(
                        text: 'politique de confidentialité',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Case à cocher marketing (optionnelle)
        Row(
          children: [
            Checkbox(
              value: _acceptMarketing,
              onChanged: (value) {
                setState(() {
                  _acceptMarketing = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _acceptMarketing = !_acceptMarketing;
                  });
                },
                child: Text(
                  'J\'accepte de recevoir des communications marketing (optionnel)',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    final isValid = _formKey.currentState?.validate() ?? false;
    final canRegister = isValid && _acceptTerms && _acceptPrivacy;
    
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: canRegister ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        boxShadow: canRegister ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: canRegister ? _handleRegister : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      canRegister ? AppConstants.primaryColor : Colors.grey,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.person_add,
                  size: 20,
                  color: canRegister ? AppConstants.primaryColor : Colors.grey,
                ),
              const SizedBox(width: 12),
              Text(
                _isLoading ? 'Inscription...' : 'Créer un compte',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: canRegister ? AppConstants.primaryColor : Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {
        // TODO: Navigation vers la page de connexion
      },
      child: Text(
        'Vous avez déjà un compte ? Connectez-vous',
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Validation pour les numéros algériens
    final phoneRegex = RegExp(r'^(\+213|0)[5-7][0-9]{8}$');
    return phoneRegex.hasMatch(phone);
  }

  bool _isValidPassword(String password) {
    // Au moins une lettre majuscule, une lettre minuscule et un chiffre
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    
    return hasUppercase && hasLowercase && hasDigits;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms || !_acceptPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez accepter les conditions d\'utilisation et la politique de confidentialité'),
          backgroundColor: AppConstants.warningColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler un délai d'inscription
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implémenter la vraie logique d'inscription
      // final success = await ref.read(authServiceProvider).signUp(
      //   _emailController.text,
      //   _passwordController.text,
      //   {
      //     'username': _usernameController.text,
      //     'phone': _phoneController.text,
      //     'acceptMarketing': _acceptMarketing,
      //   },
      // );
      
      // Pour l'instant, on simule une inscription réussie
      final success = true;
      
      if (success && mounted) {
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Inscription réussie ! Vérifiez votre email pour confirmer votre compte.'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        // Naviguer vers la page de connexion
        context.go(AppRoutes.auth);
      }
    } catch (e) {
      if (mounted) {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur d\'inscription: ${e.toString()}'),
            backgroundColor: AppConstants.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// Widget alternatif avec animation Flutter Animate
class RegisterFormAnimated extends ConsumerStatefulWidget {
  const RegisterFormAnimated({super.key});

  @override
  ConsumerState<RegisterFormAnimated> createState() => _RegisterFormAnimatedState();
}

class _RegisterFormAnimatedState extends ConsumerState<RegisterFormAnimated> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;
  bool _acceptMarketing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Champ nom d'utilisateur avec animation
          _buildUsernameField()
              .animate()
              .slideX(
                begin: -0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
              ),
          
          const SizedBox(height: 20),
          
          // Champ email avec animation
          _buildEmailField()
              .animate()
              .slideX(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 200),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 200),
              ),
          
          const SizedBox(height: 20),
          
          // Champ téléphone avec animation
          _buildPhoneField()
              .animate()
              .slideX(
                begin: -0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 400),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
              ),
          
          const SizedBox(height: 20),
          
          // Champ mot de passe avec animation
          _buildPasswordField()
              .animate()
              .slideX(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 600),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 600),
              ),
          
          const SizedBox(height: 20),
          
          // Champ confirmation mot de passe avec animation
          _buildConfirmPasswordField()
              .animate()
              .slideX(
                begin: -0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 800),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 800),
              ),
          
          const SizedBox(height: 20),
          
          // Cases à cocher avec animation
          _buildCheckboxes()
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                delay: const Duration(milliseconds: 1000),
              )
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1000),
              ),
          
          const SizedBox(height: 24),
          
          // Bouton d'inscription avec animation
          _buildRegisterButton()
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
          
          // Lien vers la connexion avec animation
          _buildLoginLink()
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

  // Méthodes identiques à la classe précédente
  Widget _buildUsernameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _usernameController,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Nom d\'utilisateur',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le nom d\'utilisateur est obligatoire';
          }
          if (value.length < 3) {
            return 'Le nom d\'utilisateur doit contenir au moins 3 caractères';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Adresse email',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'L\'email est obligatoire';
          }
          if (!_isValidEmail(value)) {
            return 'Veuillez entrer un email valide';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Numéro de téléphone',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.phone_outlined,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le numéro de téléphone est obligatoire';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le mot de passe est obligatoire';
          }
          if (value.length < 8) {
            return 'Le mot de passe doit contenir au moins 8 caractères';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Confirmer le mot de passe',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'La confirmation du mot de passe est obligatoire';
          }
          if (value != _passwordController.text) {
            return 'Les mots de passe ne correspondent pas';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCheckboxes() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _acceptTerms,
              onChanged: (value) {
                setState(() {
                  _acceptTerms = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Text(
                'J\'accepte les conditions d\'utilisation',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _acceptPrivacy,
              onChanged: (value) {
                setState(() {
                  _acceptPrivacy = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
              side: const BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Text(
                'J\'accepte la politique de confidentialité',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    final isValid = _formKey.currentState?.validate() ?? false;
    final canRegister = isValid && _acceptTerms && _acceptPrivacy;
    
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: canRegister ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        boxShadow: canRegister ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: canRegister ? _handleRegister : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      canRegister ? AppConstants.primaryColor : Colors.grey,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.person_add,
                  size: 20,
                  color: canRegister ? AppConstants.primaryColor : Colors.grey,
                ),
              const SizedBox(width: 12),
              Text(
                _isLoading ? 'Inscription...' : 'Créer un compte',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: canRegister ? AppConstants.primaryColor : Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () {
        // TODO: Navigation vers la page de connexion
      },
      child: Text(
        'Vous avez déjà un compte ? Connectez-vous',
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      final success = true;
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Inscription réussie !'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        context.go(AppRoutes.auth);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur d\'inscription: ${e.toString()}'),
            backgroundColor: AppConstants.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}