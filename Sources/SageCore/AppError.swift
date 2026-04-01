// SageCore/Sources/SageCore/AppError.swift
import Foundation

public enum AppError: Error, LocalizedError {
    case network(URLError)
    case auth(String)
    case sync(String)
    case validation(field: String, message: String)
    case selfInvitation
    case notFound
    case unknown

    public var errorDescription: String? {
        switch self {
        case .network:
            return "Erreur réseau. Vérifiez votre connexion."
        case .auth(let msg):
            return msg
        case .sync(let msg):
            return msg
        case .validation(_, let msg):
            return msg
        case .selfInvitation:
            return "Tu ne peux pas accepter ta propre invitation."
        case .notFound:
            return "Élément introuvable."
        case .unknown:
            return "Une erreur inattendue est survenue."
        }
    }
}
