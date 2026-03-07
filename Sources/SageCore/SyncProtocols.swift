// SageCore/Sources/SageCore/SyncProtocols.swift
import Foundation

// MARK: - SyncServiceProtocol

/// Protocole partagé entre toutes les apps Sage.
/// Chaque app fournit son implémentation concrète (ex: SyncService dans GardenSage).
public protocol SyncServiceProtocol: AnyObject {
    var isConnected: Bool { get }
    func start()
    func stop()
    func enqueueOperation(type: String, payload: Data) async
    func triggerSyncForTesting() async
}

// MARK: - ConflictResolvable

/// Protocole pour la résolution de conflits last-write-wins.
/// Les DTOs des apps Sage se conforment à ce protocole.
public protocol ConflictResolvable {
    var updatedAt: Date { get }
}
