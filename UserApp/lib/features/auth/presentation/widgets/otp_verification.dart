import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/providers/app_providers.dart';

class OTPVerification extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OTPVerification({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  ConsumerState<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends ConsumerState<OTPVerification> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  
  bool _isLoading = false;
  bool _isResending = false;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
    _setupOTPListeners();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendCountdown--;
        });
        if (_resendCountdown > 0) {
          _startResendCountdown();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _setupOTPListeners() {
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1 && i < _otpControllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Instructions
        Text(
          'Entrez le code de vérification à 6 chiffres',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
            ),
        
        const SizedBox(height: 32),
        
        // Champs OTP
        _buildOTPFields(),
        
        const SizedBox(height: 32),
        
        // Bouton de vérification
        _buildVerifyButton(),
        
        const SizedBox(height: 24),
        
        // Lien de renvoi
        _buildResendLink(),
        
        const SizedBox(height: 16),
        
        // Compteur de renvoi
        if (!_canResend) _buildResendCountdown(),
      ],
    );
  }

  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => _buildOTPField(index),
      ),
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
        );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? Colors.white
              : Colors.white.withOpacity(0.3),
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          setState(() {});
        },
        onTap: () {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    final otpCode = _getOTPCode();
    final isValid = otpCode.length == 6;
    
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isValid ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        boxShadow: isValid ? [
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
          onTap: isValid ? _handleVerification : null,
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
                      isValid ? AppConstants.primaryColor : Colors.grey,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: isValid ? AppConstants.primaryColor : Colors.grey,
                ),
              const SizedBox(width: 12),
              Text(
                _isLoading ? 'Vérification...' : 'Vérifier',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isValid ? AppConstants.primaryColor : Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
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
        );
  }

  Widget _buildResendLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous n\'avez pas reçu le code ? ',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        if (_canResend)
          TextButton(
            onPressed: _isResending ? null : _handleResend,
            child: _isResending
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Renvoyer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
          )
        else
          Text(
            'Renvoyer',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    )
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
        );
  }

  Widget _buildResendCountdown() {
    return Text(
      'Vous pourrez renvoyer le code dans $_resendCountdown secondes',
      style: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 12,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 1000),
        );
  }

  String _getOTPCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  Future<void> _handleVerification() async {
    final otpCode = _getOTPCode();
    
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez entrer le code complet à 6 chiffres'),
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
      // Simuler un délai de vérification
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implémenter la vraie logique de vérification OTP
      // final success = await ref.read(authServiceProvider).verifyOTP(
      //   widget.verificationId,
      //   otpCode,
      // );
      
      // Pour l'instant, on simule une vérification réussie
      final success = true;
      
      if (success && mounted) {
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Vérification réussie !'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        // Naviguer vers l'accueil
        context.go(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de vérification: ${e.toString()}'),
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

  Future<void> _handleResend() async {
    setState(() {
      _isResending = true;
    });

    try {
      // Simuler un délai de renvoi
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implémenter la vraie logique de renvoi OTP
      // final success = await ref.read(authServiceProvider).resendOTP(
      //   widget.phoneNumber,
      // );
      
      // Pour l'instant, on simule un renvoi réussi
      final success = true;
      
      if (success && mounted) {
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Code renvoyé avec succès !'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        // Réinitialiser le compteur
        setState(() {
          _canResend = false;
          _resendCountdown = 60;
        });
        
        // Redémarrer le compteur
        _startResendCountdown();
        
        // Vider les champs OTP
        for (var controller in _otpControllers) {
          controller.clear();
        }
        
        // Remettre le focus sur le premier champ
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      if (mounted) {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de renvoi: ${e.toString()}'),
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
          _isResending = false;
        });
      }
    }
  }
}

// Widget alternatif avec animation Flutter Animate
class OTPVerificationAnimated extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OTPVerificationAnimated({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  ConsumerState<OTPVerificationAnimated> createState() => _OTPVerificationAnimatedState();
}

class _OTPVerificationAnimatedState extends ConsumerState<OTPVerificationAnimated> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  
  bool _isLoading = false;
  bool _isResending = false;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
    _setupOTPListeners();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendCountdown--;
        });
        if (_resendCountdown > 0) {
          _startResendCountdown();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _setupOTPListeners() {
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1 && i < _otpControllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Instructions avec animation
        Text(
          'Entrez le code de vérification à 6 chiffres',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
            ),
        
        const SizedBox(height: 32),
        
        // Champs OTP avec animation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => _buildOTPField(index)
                .animate()
                .slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  delay: Duration(milliseconds: 400 + (index * 100)),
                )
                .fadeIn(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 400 + (index * 100)),
                ),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Bouton de vérification avec animation
        _buildVerifyButton()
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
        
        // Lien de renvoi avec animation
        _buildResendLink()
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
        
        // Compteur de renvoi avec animation
        if (!_canResend)
          _buildResendCountdown()
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1400),
              ),
      ],
    );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? Colors.white
              : Colors.white.withOpacity(0.3),
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          setState(() {});
        },
        onTap: () {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    final otpCode = _getOTPCode();
    final isValid = otpCode.length == 6;
    
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isValid ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        boxShadow: isValid ? [
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
          onTap: isValid ? _handleVerification : null,
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
                      isValid ? AppConstants.primaryColor : Colors.grey,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: isValid ? AppConstants.primaryColor : Colors.grey,
                ),
              const SizedBox(width: 12),
              Text(
                _isLoading ? 'Vérification...' : 'Vérifier',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isValid ? AppConstants.primaryColor : Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous n\'avez pas reçu le code ? ',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        if (_canResend)
          TextButton(
            onPressed: _isResending ? null : _handleResend,
            child: _isResending
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Renvoyer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
          )
        else
          Text(
            'Renvoyer',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildResendCountdown() {
    return Text(
      'Vous pourrez renvoyer le code dans $_resendCountdown secondes',
      style: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 12,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  String _getOTPCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  Future<void> _handleVerification() async {
    final otpCode = _getOTPCode();
    
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez entrer le code complet à 6 chiffres'),
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
      await Future.delayed(const Duration(seconds: 2));
      final success = true;
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Vérification réussie !'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        context.go(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de vérification: ${e.toString()}'),
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

  Future<void> _handleResend() async {
    setState(() {
      _isResending = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      final success = true;
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Code renvoyé avec succès !'),
            backgroundColor: AppConstants.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        setState(() {
          _canResend = false;
          _resendCountdown = 60;
        });
        
        _startResendCountdown();
        
        for (var controller in _otpControllers) {
          controller.clear();
        }
        
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de renvoi: ${e.toString()}'),
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
          _isResending = false;
        });
      }
    }
  }
}