// SageCore/Tests/SageCoreTests/AppErrorTests.swift
import XCTest
@testable import SageCore

final class AppErrorTests: XCTestCase {

    func testNetworkErrorDescription() {
        let error = AppError.network(URLError(.notConnectedToInternet))
        // Valeur exacte définie dans AppError.swift (strings littérales françaises)
        XCTAssertEqual(error.errorDescription, "Erreur réseau. Vérifiez votre connexion.")
    }

    func testAuthErrorDescription() {
        let error = AppError.auth("Identifiants incorrects")
        XCTAssertEqual(error.errorDescription, "Identifiants incorrects")
    }

    func testSyncErrorDescription() {
        let error = AppError.sync("Sync échouée")
        XCTAssertEqual(error.errorDescription, "Sync échouée")
    }

    func testValidationErrorDescription() {
        // Seul le `message` est retourné — pas le `field`
        let error = AppError.validation(field: "email", message: "Email invalide")
        XCTAssertEqual(error.errorDescription, "Email invalide")
    }

    func testNotFoundErrorDescription() {
        let error = AppError.notFound
        XCTAssertEqual(error.errorDescription, "Élément introuvable.")
    }

    func testUnknownErrorDescription() {
        let error = AppError.unknown
        XCTAssertEqual(error.errorDescription, "Une erreur inattendue est survenue.")
    }

    func testAppErrorIsError() {
        let error: Error = AppError.unknown
        XCTAssertNotNil(error as? AppError)
    }

    func testDefaultNetworkMonitorConformsToProtocol() {
        // Test compile-time : si ce fichier compile, DefaultNetworkMonitor satisfait NetworkMonitorProtocol
        let _: NetworkMonitorProtocol = DefaultNetworkMonitor()
    }
}
