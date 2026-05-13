// SageCore/Sources/SageCore/SupportedLanguage.swift
// Story 11.7 — Enum extensible des langues supportées par la plateforme Sage

import Foundation

/// Langues supportées par les apps Sage.
/// Pour ajouter une langue : ajouter un `case` + son `nativeName`.
public enum SupportedLanguage: String, CaseIterable, Identifiable, Codable, Sendable {
    case french = "fr"
    case english = "en"
    case spanish = "es"
    // Futures langues : case german = "de", case italian = "it", etc.

    public var id: String { rawValue }

    /// Nom de la langue dans sa propre langue
    public var nativeName: String {
        switch self {
        case .french: return "Français"
        case .english: return "English"
        case .spanish: return "Español"
        }
    }

    /// Initialise depuis un code langue (fallback → .french)
    public init(languageCode: String) {
        self = SupportedLanguage(rawValue: languageCode) ?? .french
    }
}
