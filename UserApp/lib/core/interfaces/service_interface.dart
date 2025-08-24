// Interfaces abstraites pour les services
// Suit le principe d'inversion de dépendance (DIP) des principes SOLID

// Interface de base pour tous les services
abstract class IService {
  Future<void> initialize();
  Future<void> dispose();
  bool get isInitialized;
  String get serviceName;
}

// Interface pour les services d'authentification
abstract class IAuthenticationService extends IService {
  Future<bool> isAuthenticated();
  Future<String?> getCurrentUserId();
  Future<Map<String, dynamic>?> getCurrentUser();
  Future<bool> signIn(String identifier, String password);
  Future<bool> signInWithGoogle();
  Future<bool> signInWithPhone(String phoneNumber);
  Future<bool> signUp(String email, String password, Map<String, dynamic> userData);
  Future<bool> signOut();
  Future<bool> resetPassword(String email);
  Future<bool> verifyOTP(String phoneNumber, String otp);
  Future<bool> updateProfile(Map<String, dynamic> userData);
  Future<bool> deleteAccount();
  Stream<bool> get authStateChanges;
  Stream<Map<String, dynamic>?> get userChanges;
}

// Interface pour les services de géolocalisation
abstract class IGeolocationService extends IService {
  Future<bool> requestPermission();
  Future<bool> hasPermission();
  Future<Map<String, double>?> getCurrentLocation();
  Future<Map<String, double>?> getLastKnownLocation();
  Future<String> getAddressFromCoordinates(double latitude, double longitude);
  Future<Map<String, double>?> getCoordinatesFromAddress(String address);
  Future<double> calculateDistance(double lat1, double lng1, double lat2, double lng2);
  Future<List<Map<String, dynamic>>> getNearbyPlaces(double latitude, double longitude, double radius);
  Stream<Map<String, double>> get locationUpdates;
  Future<void> startLocationTracking();
  Future<void> stopLocationTracking();
  Future<bool> isLocationEnabled();
  Future<void> openLocationSettings();
}

// Interface pour les services de notification
abstract class INotificationService extends IService {
  Future<bool> requestPermission();
  Future<bool> hasPermission();
  Future<String?> getToken();
  Future<void> sendNotification({
    required String title,
    required String body,
    String? payload,
    Map<String, dynamic>? data,
  });
  Future<void> sendLocalNotification({
    required String title,
    required String body,
    String? payload,
    Map<String, dynamic>? data,
  });
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    Map<String, dynamic>? data,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
  Future<List<Map<String, dynamic>>> getPendingNotifications();
  Future<void> onNotificationReceived(Function(Map<String, dynamic>) callback);
  Future<void> onNotificationOpened(Function(Map<String, dynamic>) callback);
}

// Interface pour les services de stockage
abstract class IStorageService extends IService {
  Future<String> uploadFile(String filePath, String destination);
  Future<String> uploadBytes(List<int> bytes, String destination, String mimeType);
  Future<bool> deleteFile(String fileUrl);
  Future<String> getDownloadUrl(String filePath);
  Future<List<String>> listFiles(String directory);
  Future<bool> fileExists(String filePath);
  Future<int> getFileSize(String filePath);
  Future<String> getFileMetadata(String filePath);
  Future<void> createDirectory(String path);
  Future<bool> deleteDirectory(String path);
  Future<double> getStorageUsage();
  Future<double> getStorageLimit();
}

// Interface pour les services de base de données
abstract class IDatabaseService extends IService {
  Future<void> connect();
  Future<void> disconnect();
  Future<bool> isConnected();
  Future<Map<String, dynamic>?> getDocument(String collection, String documentId);
  Future<List<Map<String, dynamic>>> getDocuments(String collection, {Map<String, dynamic>? where, int? limit});
  Future<String> addDocument(String collection, Map<String, dynamic> data);
  Future<bool> updateDocument(String collection, String documentId, Map<String, dynamic> data);
  Future<bool> deleteDocument(String collection, String documentId);
  Future<void> setDocument(String collection, String documentId, Map<String, dynamic> data);
  Future<void> runTransaction(Future<void> Function() updateFunction);
  Future<void> batchWrite(List<Map<String, dynamic>> operations);
  Stream<List<Map<String, dynamic>>> watchCollection(String collection);
  Stream<Map<String, dynamic>?> watchDocument(String collection, String documentId);
}

// Interface pour les services de chat
abstract class IChatService extends IService {
  Future<String> createChatRoom(String clientId, String workerId, {String? serviceRequestId});
  Future<bool> sendMessage(String chatId, String senderId, String content, {String? type, Map<String, dynamic>? metadata});
  Future<List<Map<String, dynamic>>> getMessages(String chatId, {int? limit, String? lastMessageId});
  Future<bool> markMessageAsRead(String chatId, String messageId, String userId);
  Future<bool> deleteMessage(String chatId, String messageId, String userId);
  Future<bool> editMessage(String chatId, String messageId, String newContent, String userId);
  Future<List<Map<String, dynamic>>> getChatRooms(String userId);
  Future<Map<String, dynamic>?> getChatRoom(String chatId);
  Future<bool> archiveChat(String chatId, String userId);
  Future<bool> unarchiveChat(String chatId, String userId);
  Stream<Map<String, dynamic>> watchChatRoom(String chatId);
  Stream<List<Map<String, dynamic>>> watchChatRooms(String userId);
}

// Interface pour les services de paiement
abstract class IPaymentService extends IService {
  Future<bool> initializePayment();
  Future<String?> createPaymentIntent({
    required double amount,
    required String currency,
    required String description,
    Map<String, dynamic>? metadata,
  });
  Future<bool> processPayment(String paymentIntentId);
  Future<bool> confirmPayment(String paymentIntentId);
  Future<bool> cancelPayment(String paymentIntentId);
  Future<Map<String, dynamic>?> getPaymentStatus(String paymentIntentId);
  Future<List<Map<String, dynamic>>> getPaymentHistory(String userId);
  Future<bool> refundPayment(String paymentIntentId, {double? amount});
  Future<Map<String, dynamic>?> getPaymentMethods(String userId);
  Future<bool> addPaymentMethod(Map<String, dynamic> paymentMethod);
  Future<bool> removePaymentMethod(String paymentMethodId);
  Future<bool> setDefaultPaymentMethod(String paymentMethodId);
}

// Interface pour les services de recherche
abstract class ISearchService extends IService {
  Future<List<Map<String, dynamic>>> searchWorkers({
    required String query,
    String? profession,
    String? city,
    String? wilaya,
    double? latitude,
    double? longitude,
    double? radius,
    Map<String, dynamic>? filters,
  });
  Future<List<Map<String, dynamic>>> searchServiceRequests({
    required String query,
    String? profession,
    String? city,
    String? wilaya,
    double? latitude,
    double? longitude,
    double? radius,
    Map<String, dynamic>? filters,
  });
  Future<List<Map<String, dynamic>>> getSuggestions(String query);
  Future<List<String>> getPopularSearches();
  Future<List<String>> getRecentSearches(String userId);
  Future<void> saveSearch(String userId, String query);
  Future<void> clearSearchHistory(String userId);
  Future<Map<String, dynamic>> getSearchAnalytics();
}

// Interface pour les services de validation
abstract class IValidationService extends IService {
  Future<bool> validateEmail(String email);
  Future<bool> validatePhoneNumber(String phoneNumber);
  Future<bool> validatePassword(String password);
  Future<bool> validateDocument(Map<String, dynamic> document);
  Future<bool> validateLocation(Map<String, dynamic> location);
  Future<bool> validatePayment(Map<String, dynamic> payment);
  Future<List<String>> getValidationErrors(Map<String, dynamic> data, String validationType);
  Future<Map<String, dynamic>> sanitizeData(Map<String, dynamic> data);
  Future<bool> isDataValid(Map<String, dynamic> data, String validationType);
}

// Interface pour les services de sécurité
abstract class ISecurityService extends IService {
  Future<String> encryptData(String data);
  Future<String> decryptData(String encryptedData);
  Future<String> hashPassword(String password);
  Future<bool> verifyPassword(String password, String hash);
  Future<String> generateToken();
  Future<bool> validateToken(String token);
  Future<void> logSecurityEvent(String event, Map<String, dynamic> details);
  Future<List<Map<String, dynamic>>> getSecurityLogs();
  Future<bool> isDeviceSecure();
  Future<void> lockApp();
  Future<void> unlockApp();
}

// Interface pour les services de cache
abstract class ICacheService extends IService {
  Future<void> set(String key, dynamic value, {Duration? expiration});
  Future<T?> get<T>(String key);
  Future<bool> has(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<void> clearExpired();
  Future<List<String>> getKeys();
  Future<int> getSize();
  Future<double> getMemoryUsage();
  Future<void> setExpiration(String key, Duration expiration);
  Future<Duration?> getExpiration(String key);
}

// Interface pour les services de synchronisation
abstract class ISyncService extends IService {
  Future<void> syncData();
  Future<void> syncUserData(String userId);
  Future<void> syncWorkers();
  Future<void> syncServiceRequests();
  Future<void> syncChats();
  Future<bool> isSyncing();
  Future<DateTime> getLastSyncTime();
  Future<void> setSyncInterval(Duration interval);
  Future<Duration> getSyncInterval();
  Future<void> enableAutoSync();
  Future<void> disableAutoSync();
  Future<bool> isAutoSyncEnabled();
  Stream<double> get syncProgress;
  Stream<String> get syncStatus;
}

// Interface pour les services d'analytics
abstract class IAnalyticsService extends IService {
  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters});
  Future<void> logUserAction(String action, {Map<String, dynamic>? parameters});
  Future<void> logError(String error, {Map<String, dynamic>? parameters});
  Future<void> setUserProperty(String property, String value);
  Future<void> setUserId(String userId);
  Future<void> setUserProfile(Map<String, dynamic> profile);
  Future<Map<String, dynamic>> getAnalytics();
  Future<Map<String, dynamic>> getEventCount(String eventName, {DateTime? start, DateTime? end});
  Future<void> enableAnalytics();
  Future<void> disableAnalytics();
  Future<bool> isAnalyticsEnabled();
}

// Interface pour les services de configuration
abstract class IConfigurationService extends IService {
  Future<void> loadConfiguration();
  Future<T?> getValue<T>(String key, {T? defaultValue});
  Future<void> setValue<T>(String key, T value);
  Future<bool> hasValue(String key);
  Future<void> removeValue(String key);
  Future<void> clear();
  Future<Map<String, dynamic>> getAllValues();
  Future<void> reloadConfiguration();
  Future<bool> isConfigurationLoaded();
  Future<String> getConfigurationVersion();
  Future<void> updateConfiguration(Map<String, dynamic> newConfig);
}