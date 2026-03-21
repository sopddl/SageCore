// SageCore/Sources/SageCore/SageCoreProfileContract.swift
import Foundation

/// Contrat définissant le profil core complet de la Sage Platform.
///
/// Chaque app implémente ce protocole via son @Model SageCoreProfile.
/// Les champs avec extension default sont opt-in : l'app les utilise ou non.
///
/// ⚠️ @Model SwiftData ne peut PAS être dans SageCore (crash de migration si déplacés).
/// Ce protocole sert de spécification compile-time pour garantir la cohérence.
public protocol SageCoreProfileContract {
    // === Identité (obligatoire) ===
    var id: UUID { get }
    var firstName: String? { get set }

    // === Localisation (obligatoire) ===
    var language: String { get set }
    var region: String { get set }

    // === GPS (opt-in) ===
    var latitude: Double? { get set }
    var longitude: Double? { get set }

    // === Conformité (obligatoire) ===
    var analyticsConsent: Bool { get set }

    // === Notifications & Pause (opt-in) ===
    var notificationPreferences: Data? { get set }
    var vacationEndDate: Date? { get set }

    // === Expertise & Objectifs (opt-in — promu du spécifique, ADR D-CORE-01) ===
    var skillLevel: String { get set }
    var objectivesData: Data? { get set }
    var availableTime: String { get set }

    // === Sync metadata (obligatoire) ===
    var createdAt: Date { get }
    var updatedAt: Date { get set }
    var isSoftDeleted: Bool { get set }
    var deletedAt: Date? { get set }
}

// MARK: - Opt-in defaults

/// Les apps n'ont pas besoin d'implémenter les champs opt-in.
/// GPS, notifications, pause, expertise : valeurs par défaut fournies.
public extension SageCoreProfileContract {
    var latitude: Double? { get { nil } set {} }
    var longitude: Double? { get { nil } set {} }
    var notificationPreferences: Data? { get { nil } set {} }
    var vacationEndDate: Date? { get { nil } set {} }
    var skillLevel: String { get { "" } set {} }
    var objectivesData: Data? { get { nil } set {} }
    var availableTime: String { get { "" } set {} }
}
