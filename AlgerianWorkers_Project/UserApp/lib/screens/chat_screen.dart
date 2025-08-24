import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../core/utils/language_utils.dart';
import '../models/chat.dart';
import '../models/user.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';

  final List<String> _filters = ['all', 'active', 'archived', 'unread'];

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
            // En-tête avec recherche
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildHeader(),
            ),

            // Filtres
            SlideTransition(
              position: _slideAnimation,
              child: _buildFilters(),
            ),

            // Liste des conversations
            Expanded(
              child: _buildConversationsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
      child: Column(
        children: [
          Row(
            children: [
              Text(
                LanguageUtils.getText('fr', 'chat_title'),
                style: AppTextStyles.headlineSmall,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Navigation vers les paramètres du chat
                },
                icon: Icon(
                  Icons.settings,
                  color: AppColors.textSecondary,
                  size: AppSizes.iconMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Container(
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
                hintText: LanguageUtils.getText('fr', 'chat_search_placeholder'),
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                  size: AppSizes.iconMedium,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingMedium,
                ),
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
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(
              right: filter != _filters.last ? AppSizes.spacingSmall : 0,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                child: Text(
                  _getFilterText(filter),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected
                        ? AppColors.textInverse
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getFilterText(String filter) {
    switch (filter) {
      case 'all':
        return LanguageUtils.getText('fr', 'chat_filter_all');
      case 'active':
        return LanguageUtils.getText('fr', 'chat_filter_active');
      case 'archived':
        return LanguageUtils.getText('fr', 'chat_filter_archived');
      case 'unread':
        return LanguageUtils.getText('fr', 'chat_filter_unread');
      default:
        return filter;
    }
  }

  Widget _buildConversationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _buildConversationItem(_getConversationData(index));
      },
    );
  }

  Map<String, dynamic> _getConversationData(int index) {
    final conversations = [
      {
        'name': 'Ahmed Benali',
        'service': 'Plomberie',
        'lastMessage': 'Bonjour, je serai là dans 15 minutes',
        'time': '14:30',
        'unreadCount': 2,
        'status': 'online',
        'avatar': 'A',
        'isActive': true,
      },
      {
        'name': 'Fatima Zohra',
        'service': 'Ménage',
        'lastMessage': 'Merci pour le service, c\'était parfait !',
        'time': '12:15',
        'unreadCount': 0,
        'status': 'offline',
        'avatar': 'F',
        'isActive': false,
      },
      {
        'name': 'Mohammed Ali',
        'service': 'Électricité',
        'lastMessage': 'Pouvez-vous me confirmer l\'heure ?',
        'time': '10:45',
        'unreadCount': 1,
        'status': 'online',
        'avatar': 'M',
        'isActive': true,
      },
      {
        'name': 'Karim Boudiaf',
        'service': 'Jardinage',
        'lastMessage': 'Je commence le travail demain matin',
        'time': 'Hier',
        'unreadCount': 0,
        'status': 'offline',
        'avatar': 'K',
        'isActive': false,
      },
      {
        'name': 'Samira Ben',
        'service': 'Climatisation',
        'lastMessage': 'Le devisement est prêt',
        'time': 'Hier',
        'unreadCount': 3,
        'status': 'online',
        'avatar': 'S',
        'isActive': true,
      },
      {
        'name': 'Hassan Tazi',
        'service': 'Déménagement',
        'lastMessage': 'Nous arrivons à 8h00',
        'time': 'Lun',
        'unreadCount': 0,
        'status': 'offline',
        'avatar': 'H',
        'isActive': false,
      },
      {
        'name': 'Amina Khelifi',
        'service': 'Réparation',
        'lastMessage': 'Le problème est résolu',
        'time': 'Lun',
        'unreadCount': 0,
        'status': 'offline',
        'avatar': 'A',
        'isActive': false,
      },
      {
        'name': 'Youssef Mansouri',
        'service': 'Plomberie',
        'lastMessage': 'Je confirme le rendez-vous',
        'time': 'Dim',
        'unreadCount': 1,
        'status': 'online',
        'avatar': 'Y',
        'isActive': true,
      },
    ];
    return conversations[index];
  }

  Widget _buildConversationItem(Map<String, dynamic> conversation) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.marginMedium),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigation vers la conversation
            _openConversation(conversation);
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
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
            child: Row(
              children: [
                // Avatar avec statut
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text(
                          conversation['avatar'],
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (conversation['status'] == 'online')
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.statusActive,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surfacePrimary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSizes.spacingMedium),
                // Informations de la conversation
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['name'],
                              style: AppTextStyles.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            conversation['time'],
                            style: AppTextStyles.captionLarge.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingSmall),
                      Text(
                        conversation['service'],
                        style: AppTextStyles.captionLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingSmall),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['lastMessage'],
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (conversation['unreadCount'] > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingSmall,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.notificationError,
                                borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                              ),
                              child: Text(
                                '${conversation['unreadCount']}',
                                style: AppTextStyles.captionSmall.copyWith(
                                  color: AppColors.textInverse,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bouton d'action
                IconButton(
                  onPressed: () {
                    _showConversationOptions(conversation);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                    size: AppSizes.iconSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openConversation(Map<String, dynamic> conversation) {
    // Navigation vers l'écran de conversation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ConversationDetailScreen(
          conversation: conversation,
        ),
      ),
    );
  }

  void _showConversationOptions(Map<String, dynamic> conversation) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfacePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusMedium),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            const SizedBox(height: AppSizes.spacingMedium),
            _buildOptionItem(
              icon: Icons.archive,
              title: LanguageUtils.getText('fr', 'chat_option_archive'),
              onTap: () {
                Navigator.pop(context);
                // Action d'archivage
              },
            ),
            _buildOptionItem(
              icon: Icons.notifications_off,
              title: LanguageUtils.getText('fr', 'chat_option_mute'),
              onTap: () {
                Navigator.pop(context);
                // Action de désactivation des notifications
              },
            ),
            _buildOptionItem(
              icon: Icons.delete,
              title: LanguageUtils.getText('fr', 'chat_option_delete'),
              onTap: () {
                Navigator.pop(context);
                // Action de suppression
              },
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.statusError : AppColors.textSecondary,
        size: AppSizes.iconMedium,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isDestructive ? AppColors.statusError : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

// Écran de détail de conversation
class _ConversationDetailScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const _ConversationDetailScreen({required this.conversation});

  @override
  State<_ConversationDetailScreen> createState() => _ConversationDetailScreenState();
}

class _ConversationDetailScreenState extends State<_ConversationDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.surfacePrimary,
              child: Text(
                widget.conversation['avatar'],
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation['name'],
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                  Text(
                    widget.conversation['service'],
                    style: AppTextStyles.captionLarge.copyWith(
                      color: AppColors.textInverse.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Appel vocal
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              // Appel vidéo
            },
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: _buildMessagesList(),
          ),
          // Zone de saisie
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      itemCount: 10,
      itemBuilder: (context, index) {
        final isUser = index % 2 == 0;
        return _buildMessageItem(isUser, index);
      },
    );
  }

  Widget _buildMessageItem(bool isUser, int index) {
    final messages = [
      'Bonjour, je serai là dans 15 minutes',
      'Parfait, merci !',
      'Pouvez-vous me confirmer l\'adresse ?',
      'Oui, c\'est bien 123 Rue de la Paix, Bab Ezzouar',
      'Merci, je suis en route',
      'D\'accord, je vous attends',
      'Je suis arrivé',
      'Parfait, je descends',
      'Bonjour, comment allez-vous ?',
      'Très bien, merci !',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMedium),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                widget.conversation['avatar'],
                style: AppTextStyles.captionLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingSmall),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primary
                    : AppColors.surfacePrimary,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                border: Border.all(
                  color: isUser
                      ? AppColors.primary
                      : AppColors.borderLight,
                  width: 1,
                ),
              ),
              child: Text(
                messages[index],
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isUser
                      ? AppColors.textInverse
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSizes.spacingSmall),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.accent.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: AppColors.accent,
                size: AppSizes.iconSmall,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Ajouter une pièce jointe
            },
            icon: Icon(
              Icons.attach_file,
              color: AppColors.textSecondary,
              size: AppSizes.iconMedium,
            ),
          ),
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
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: LanguageUtils.getText('fr', 'chat_message_hint'),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingMedium,
                  ),
                ),
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingSmall),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: IconButton(
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  // Envoyer le message
                  _messageController.clear();
                }
              },
              icon: Icon(
                Icons.send,
                color: AppColors.textInverse,
                size: AppSizes.iconMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}