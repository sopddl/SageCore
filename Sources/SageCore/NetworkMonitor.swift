// SageCore/Sources/SageCore/NetworkMonitor.swift
import Foundation
import Network

// MARK: - NetworkMonitorProtocol

/// Protocole d'abstraction pour la détection réseau.
/// Utilisé par SyncService (GardenSage) et toute future app Sage.
/// NWPath n'est PAS exposé — NWPath est un struct Apple sans initialiseur public,
/// impossible à mocker. On abstrait uniquement le Bool "isConnected".
public protocol NetworkMonitorProtocol: AnyObject {
    var onConnectionChange: ((Bool) -> Void)? { get set }
    func start(queue: DispatchQueue)
    func cancel()
}

// MARK: - DefaultNetworkMonitor

/// Implémentation concrète wrappant NWPathMonitor.
public final class DefaultNetworkMonitor: NetworkMonitorProtocol {
    public var onConnectionChange: ((Bool) -> Void)?
    private let monitor = NWPathMonitor()

    public init() {}

    public func start(queue: DispatchQueue) {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.onConnectionChange?(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }

    public func cancel() {
        monitor.cancel()
    }
}
