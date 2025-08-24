// Interface abstraite pour le pattern Repository
// Suit le principe d'inversion de dépendance (DIP) des principes SOLID

abstract class IRepository<T> {
  // Opérations CRUD de base
  Future<T?> getById(String id);
  Future<List<T>> getAll();
  Future<List<T>> getWhere(Map<String, dynamic> conditions);
  Future<T> create(T entity);
  Future<T> update(T entity);
  Future<bool> delete(String id);
  
  // Opérations de recherche avancées
  Future<List<T>> search(String query);
  Future<List<T>> getPaginated(int page, int limit);
  Future<int> getCount();
  
  // Opérations de synchronisation
  Future<void> sync();
  Future<List<T>> getModifiedSince(DateTime since);
  Stream<List<T>> watchChanges();
}

// Interface pour les repositories avec géolocalisation
abstract class IGeolocationRepository<T> extends IRepository<T> {
  Future<List<T>> getNearby(double latitude, double longitude, double radiusKm);
  Future<List<T>> getInArea(String city, String wilaya);
  Future<List<T>> getByDistance(double latitude, double longitude, {double? maxDistance});
}

// Interface pour les repositories avec authentification
abstract class IAuthenticatedRepository<T> extends IRepository<T> {
  Future<List<T>> getForUser(String userId);
  Future<T?> getForUserById(String userId, String entityId);
  Future<bool> isOwner(String userId, String entityId);
}

// Interface pour les repositories avec notifications
abstract class INotificationRepository<T> extends IRepository<T> {
  Future<void> subscribeToChanges(String userId);
  Future<void> unsubscribeFromChanges(String userId);
  Stream<T> watchEntity(String entityId);
}

// Interface pour les repositories avec cache
abstract class ICachedRepository<T> extends IRepository<T> {
  Future<void> clearCache();
  Future<void> refreshCache();
  Future<bool> isCached(String id);
  Future<T?> getFromCache(String id);
}

// Interface pour les repositories avec validation
abstract class IValidatedRepository<T> extends IRepository<T> {
  Future<bool> validate(T entity);
  Future<List<String>> getValidationErrors(T entity);
  Future<T> sanitize(T entity);
}

// Interface pour les repositories avec audit
abstract class IAuditedRepository<T> extends IRepository<T> {
  Future<List<T>> getAuditTrail(String entityId);
  Future<void> logAction(String action, String entityId, String userId, Map<String, dynamic> details);
}

// Interface pour les repositories avec versioning
abstract class IVersionedRepository<T> extends IRepository<T> {
  Future<List<T>> getVersions(String entityId);
  Future<T?> getVersion(String entityId, int version);
  Future<T> createVersion(T entity);
  Future<bool> rollbackToVersion(String entityId, int version);
}

// Interface pour les repositories avec relations
abstract class IRelationalRepository<T> extends IRepository<T> {
  Future<List<T>> getWithRelations(String id, List<String> relations);
  Future<T?> getRelated(String id, String relationType);
  Future<List<T>> getByRelation(String relationType, String relationId);
}

// Interface pour les repositories avec statistiques
abstract class IStatisticsRepository<T> extends IRepository<T> {
  Future<Map<String, dynamic>> getStatistics();
  Future<Map<String, dynamic>> getStatisticsForPeriod(DateTime start, DateTime end);
  Future<Map<String, dynamic>> getStatisticsByCategory(String category);
}

// Interface pour les repositories avec export/import
abstract class IDataPortRepository<T> extends IRepository<T> {
  Future<String> exportToJson(List<String> ids);
  Future<String> exportToCsv(List<String> ids);
  Future<List<T>> importFromJson(String jsonData);
  Future<List<T>> importFromCsv(String csvData);
}

// Interface pour les repositories avec backup/restore
abstract class IBackupRepository<T> extends IRepository<T> {
  Future<String> createBackup();
  Future<bool> restoreFromBackup(String backupId);
  Future<List<String>> listBackups();
  Future<bool> deleteBackup(String backupId);
}

// Interface pour les repositories avec synchronisation temps réel
abstract class IRealtimeRepository<T> extends IRepository<T> {
  Stream<T> watchById(String id);
  Stream<List<T>> watchCollection();
  Stream<List<T>> watchQuery(Map<String, dynamic> query);
  Future<void> enableRealtimeSync();
  Future<void> disableRealtimeSync();
}

// Interface pour les repositories avec gestion des erreurs
abstract class IErrorHandlingRepository<T> extends IRepository<T> {
  Future<T> safeOperation(Future<T> Function() operation);
  Future<void> handleError(dynamic error, String operation);
  Future<bool> isHealthy();
  Future<Map<String, dynamic>> getHealthStatus();
}

// Interface pour les repositories avec métriques
abstract class IMetricsRepository<T> extends IRepository<T> {
  Future<void> recordMetric(String metricName, dynamic value);
  Future<Map<String, dynamic>> getMetrics();
  Future<Map<String, dynamic>> getMetricsForPeriod(DateTime start, DateTime end);
}

// Interface pour les repositories avec sécurité
abstract class ISecureRepository<T> extends IRepository<T> {
  Future<bool> hasPermission(String userId, String operation, String entityId);
  Future<void> encryptSensitiveData(T entity);
  Future<T> decryptSensitiveData(T entity);
  Future<void> auditAccess(String userId, String operation, String entityId);
}

// Interface pour les repositories avec gestion des conflits
abstract class IConflictResolutionRepository<T> extends IRepository<T> {
  Future<List<T>> detectConflicts(T entity);
  Future<T> resolveConflict(T entity, String resolutionStrategy);
  Future<bool> hasConflicts(String entityId);
  Future<List<String>> getConflictTypes(String entityId);
}

// Interface pour les repositories avec gestion des transactions
abstract class ITransactionalRepository<T> extends IRepository<T> {
  Future<T> executeInTransaction(Future<T> Function() operation);
  Future<void> beginTransaction();
  Future<void> commitTransaction();
  Future<void> rollbackTransaction();
  Future<bool> isInTransaction();
}