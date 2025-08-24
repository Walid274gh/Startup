import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';
import '../providers/app_providers.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/request/presentation/pages/request_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/worker_details/presentation/pages/worker_details_page.dart';
import '../../features/request_details/presentation/pages/request_details_page.dart';
import '../../features/chat_room/presentation/pages/chat_room_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/help/presentation/pages/help_page.dart';
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/privacy/presentation/pages/privacy_page.dart';
import '../../features/terms/presentation/pages/terms_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();

  late final GoRouter _router;

  GoRouter get config => _router;

  void initialize() {
    _router = GoRouter(
      initialLocation: AppRoutes.splash,
      debugLogDiagnostics: true,
      routes: _buildRoutes(),
      redirect: _handleRedirect,
      errorBuilder: _buildErrorPage,
      redirectLimit: 5,
    );
  }

  List<RouteBase> _buildRoutes() {
    return [
      // Route splash
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const SplashPage(),
          state: state,
        ),
      ),

      // Route authentification
      GoRoute(
        path: AppRoutes.auth,
        name: 'auth',
        builder: (context, state) => const AuthPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const AuthPage(),
          state: state,
        ),
      ),

      // Route principale avec navigation bottom bar
      ShellRoute(
        builder: (context, state, child) => _buildMainShell(child),
        routes: [
          // Route accueil
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomePage(),
            pageBuilder: (context, state) => _buildPage(
              child: const HomePage(),
              state: state,
            ),
            routes: [
              // Sous-routes de l'accueil
              GoRoute(
                path: 'profile',
                name: 'home_profile',
                builder: (context, state) => const ProfilePage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const ProfilePage(),
                  state: state,
                ),
              ),
              GoRoute(
                path: 'notifications',
                name: 'home_notifications',
                builder: (context, state) => const NotificationsPage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const NotificationsPage(),
                  state: state,
                ),
              ),
              GoRoute(
                path: 'help',
                name: 'home_help',
                builder: (context, state) => const HelpPage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const HelpPage(),
                  state: state,
                ),
              ),
              GoRoute(
                path: 'about',
                name: 'home_about',
                builder: (context, state) => const AboutPage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const AboutPage(),
                  state: state,
                ),
              ),
            ],
          ),

          // Route recherche
          GoRoute(
            path: AppRoutes.search,
            name: 'search',
            builder: (context, state) => const SearchPage(),
            pageBuilder: (context, state) => _buildPage(
              child: const SearchPage(),
              state: state,
            ),
            routes: [
              // Sous-routes de la recherche
              GoRoute(
                path: 'worker/:id',
                name: 'worker_details',
                builder: (context, state) {
                  final workerId = state.pathParameters['id']!;
                  return WorkerDetailsPage(workerId: workerId);
                },
                pageBuilder: (context, state) => _buildPage(
                  child: WorkerDetailsPage(
                    workerId: state.pathParameters['id']!,
                  ),
                  state: state,
                ),
              ),
            ],
          ),

          // Route création de demande
          GoRoute(
            path: AppRoutes.request,
            name: 'request',
            builder: (context, state) => const RequestPage(),
            pageBuilder: (context, state) => _buildPage(
              child: const RequestPage(),
              state: state,
            ),
            routes: [
              // Sous-routes des demandes
              GoRoute(
                path: 'details/:id',
                name: 'request_details',
                builder: (context, state) {
                  final requestId = state.pathParameters['id']!;
                  return RequestDetailsPage(requestId: requestId);
                },
                pageBuilder: (context, state) => _buildPage(
                  child: RequestDetailsPage(
                    requestId: state.pathParameters['id']!,
                  ),
                  state: state,
                ),
              ),
            ],
          ),

          // Route chat
          GoRoute(
            path: AppRoutes.chat,
            name: 'chat',
            builder: (context, state) => const ChatPage(),
            pageBuilder: (context, state) => _buildPage(
              child: const ChatPage(),
              state: state,
            ),
            routes: [
              // Sous-routes du chat
              GoRoute(
                path: 'room/:id',
                name: 'chat_room',
                builder: (context, state) {
                  final chatId = state.pathParameters['id']!;
                  return ChatRoomPage(chatId: chatId);
                },
                pageBuilder: (context, state) => _buildPage(
                  child: ChatRoomPage(
                    chatId: state.pathParameters['id']!,
                  ),
                  state: state,
                ),
              ),
            ],
          ),

          // Route paramètres
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
            pageBuilder: (context, state) => _buildPage(
              child: const SettingsPage(),
              state: state,
            ),
            routes: [
              // Sous-routes des paramètres
              GoRoute(
                path: 'privacy',
                name: 'settings_privacy',
                builder: (context, state) => const PrivacyPage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const PrivacyPage(),
                  state: state,
                ),
              ),
              GoRoute(
                path: 'terms',
                name: 'settings_terms',
                builder: (context, state) => const TermsPage(),
                pageBuilder: (context, state) => _buildPage(
                  child: const TermsPage(),
                  state: state,
                ),
              ),
            ],
          ),
        ],
      ),

      // Routes indépendantes (sans navigation bottom bar)
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
        pageBuilder: (context, state) => _buildPage(
          child: const ProfilePage(),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.workerDetails,
        name: 'worker_details_standalone',
        builder: (context, state) {
          final workerId = state.queryParameters['id'] ?? '';
          return WorkerDetailsPage(workerId: workerId);
        },
        pageBuilder: (context, state) => _buildPage(
          child: WorkerDetailsPage(
            workerId: state.queryParameters['id'] ?? '',
          ),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.requestDetails,
        name: 'request_details_standalone',
        builder: (context, state) {
          final requestId = state.queryParameters['id'] ?? '';
          return RequestDetailsPage(requestId: requestId);
        },
        pageBuilder: (context, state) => _buildPage(
          child: RequestDetailsPage(
            requestId: state.queryParameters['id'] ?? '',
          ),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.chatRoom,
        name: 'chat_room_standalone',
        builder: (context, state) {
          final chatId = state.queryParameters['id'] ?? '';
          return ChatRoomPage(chatId: chatId);
        },
        pageBuilder: (context, state) => _buildPage(
          child: ChatRoomPage(
            chatId: state.queryParameters['id'] ?? '',
          ),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications_standalone',
        builder: (context, state) => const NotificationsPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const NotificationsPage(),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.help,
        name: 'help_standalone',
        builder: (context, state) => const HelpPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const HelpPage(),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.about,
        name: 'about_standalone',
        builder: (context, state) => const AboutPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const AboutPage(),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.privacy,
        name: 'privacy_standalone',
        builder: (context, state) => const PrivacyPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const PrivacyPage(),
          state: state,
        ),
      ),

      GoRoute(
        path: AppRoutes.terms,
        name: 'terms_standalone',
        builder: (context, state) => const TermsPage(),
        pageBuilder: (context, state) => _buildPage(
          child: const TermsPage(),
          state: state,
        ),
      ),
    ];
  }

  // Gestion des redirections
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    // Ici, vous pouvez ajouter la logique de redirection basée sur l'état de l'application
    // Par exemple, rediriger vers la page de connexion si l'utilisateur n'est pas authentifié
    
    // Pour l'instant, on laisse passer toutes les routes
    return null;
  }

  // Construction des pages avec transitions personnalisées
  Page<dynamic> _buildPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: AppConstants.defaultAnimationDuration,
    );
  }

  // Construction du shell principal avec navigation bottom bar
  Widget _buildMainShell(Widget child) {
    return MainShell(child: child);
  }

  // Construction de la page d'erreur
  Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page non trouvée'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppConstants.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Page non trouvée',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'La page que vous recherchez n\'existe pas.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget shell principal avec navigation bottom bar
class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: [
          _buildBottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Accueil',
          ),
          _buildBottomNavItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Recherche',
          ),
          _buildBottomNavItem(
            icon: Icons.add_circle_outline,
            activeIcon: Icons.add_circle,
            label: 'Demande',
          ),
          _buildBottomNavItem(
            icon: Icons.chat_outlined,
            activeIcon: Icons.chat,
            label: 'Chat',
          ),
          _buildBottomNavItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(_currentIndex == _getIndexForLabel(label) ? activeIcon : icon),
      label: label,
    );
  }

  int _getIndexForLabel(String label) {
    switch (label) {
      case 'Accueil':
        return 0;
      case 'Recherche':
        return 1;
      case 'Demande':
        return 2;
      case 'Chat':
        return 3;
      case 'Paramètres':
        return 4;
      default:
        return 0;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigation vers la route correspondante
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.search);
        break;
      case 2:
        context.go(AppRoutes.request);
        break;
      case 3:
        context.go(AppRoutes.chat);
        break;
      case 4:
        context.go(AppRoutes.settings);
        break;
    }
  }
}

// Extension pour faciliter la navigation
extension NavigationExtension on BuildContext {
  void goToSplash() => go(AppRoutes.splash);
  void goToAuth() => go(AppRoutes.auth);
  void goToHome() => go(AppRoutes.home);
  void goToSearch() => go(AppRoutes.search);
  void goToRequest() => go(AppRoutes.request);
  void goToChat() => go(AppRoutes.chat);
  void goToSettings() => go(AppRoutes.settings);
  void goToProfile() => go(AppRoutes.profile);
  void goToWorkerDetails(String workerId) => go('${AppRoutes.search}/worker/$workerId');
  void goToRequestDetails(String requestId) => go('${AppRoutes.request}/details/$requestId');
  void goToChatRoom(String chatId) => go('${AppRoutes.chat}/room/$chatId');
  void goToNotifications() => go(AppRoutes.notifications);
  void goToHelp() => go(AppRoutes.help);
  void goToAbout() => go(AppRoutes.about);
  void goToPrivacy() => go(AppRoutes.privacy);
  void goToTerms() => go(AppRoutes.terms);

  void goBack() => pop();
  void goBackToHome() => go(AppRoutes.home);
  void goBackToSearch() => go(AppRoutes.search);
  void goBackToRequest() => go(AppRoutes.request);
  void goBackToChat() => go(AppRoutes.chat);
  void goBackToSettings() => go(AppRoutes.settings);
}

// Extension pour les transitions de page
extension PageTransitionExtension on BuildContext {
  void goWithTransition(String route, {Object? extra}) {
    go(route, extra: extra);
  }

  void pushWithTransition(String route, {Object? extra}) {
    push(route, extra: extra);
  }

  void pushReplacementWithTransition(String route, {Object? extra}) {
    pushReplacement(route, extra: extra);
  }
}

// Extension pour la gestion des paramètres de route
extension RouteParametersExtension on BuildContext {
  String? getWorkerId => GoRouterState.of(this).pathParameters['id'];
  String? getRequestId => GoRouterState.of(this).pathParameters['id'];
  String? getChatId => GoRouterState.of(this).pathParameters['id'];
  
  String? getQueryWorkerId => GoRouterState.of(this).queryParameters['id'];
  String? getQueryRequestId => GoRouterState.of(this).queryParameters['id'];
  String? getQueryChatId => GoRouterState.of(this).queryParameters['id'];
  
  Map<String, String> getAllQueryParameters() => 
      GoRouterState.of(this).queryParameters;
  
  Object? getExtra() => GoRouterState.of(this).extra;
}

// Extension pour la gestion de l'historique de navigation
extension NavigationHistoryExtension on BuildContext {
  bool get canGoBack => GoRouter.of(this).canPop();
  
  void goBackMultiple(int count) {
    for (int i = 0; i < count; i++) {
      if (canGoBack) {
        pop();
      } else {
        break;
      }
    }
  }
  
  void goBackToFirst() {
    while (canGoBack) {
      pop();
    }
  }
  
  void goBackToRoute(String route) {
    final router = GoRouter.of(this);
    final location = router.location;
    
    if (location.contains(route)) {
      final segments = location.split('/');
      final routeIndex = segments.indexOf(route.split('/').last);
      
      if (routeIndex != -1) {
        final targetLocation = segments.take(routeIndex + 1).join('/');
        go(targetLocation);
      }
    }
  }
}