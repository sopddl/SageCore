// SageCore/Tests/SageCoreTests/ProtocolConformanceTests.swift
import XCTest
@testable import SageCore

final class ProtocolConformanceTests: XCTestCase {

    // MARK: - ConflictResolvable

    func testConflictResolvableAdoption() {
        struct Entity: ConflictResolvable {
            let updatedAt: Date
        }
        let entity = Entity(updatedAt: Date())
        XCTAssertNotNil(entity.updatedAt)
    }

    func testLastWriteWinsSorting() {
        struct DTO: ConflictResolvable {
            let id: String
            let updatedAt: Date
        }
        let older = DTO(id: "a", updatedAt: Date(timeIntervalSinceNow: -60))
        let newer = DTO(id: "b", updatedAt: Date())
        let sorted = [older, newer].sorted { $0.updatedAt > $1.updatedAt }
        XCTAssertEqual(sorted.first?.id, "b", "La version la plus récente doit être en premier")
    }

    // MARK: - NetworkMonitorProtocol

    func testNetworkMonitorProtocolAdoption() {
        // Vérifier qu'un mock peut adopter le protocole sans contrainte cachée
        final class MockMonitor: NetworkMonitorProtocol {
            var onConnectionChange: ((Bool) -> Void)?
            var startCalled = false
            var cancelCalled = false
            func start(queue: DispatchQueue) { startCalled = true }
            func cancel() { cancelCalled = true }
        }

        let monitor = MockMonitor()
        monitor.start(queue: .main)
        monitor.cancel()

        XCTAssertTrue(monitor.startCalled)
        XCTAssertTrue(monitor.cancelCalled)
    }

    func testNetworkMonitorOnConnectionChangeCallback() {
        final class MockMonitor: NetworkMonitorProtocol {
            var onConnectionChange: ((Bool) -> Void)?
            func start(queue: DispatchQueue) { onConnectionChange?(true) }
            func cancel() {}
        }

        let monitor = MockMonitor()
        var receivedValue: Bool?
        monitor.onConnectionChange = { receivedValue = $0 }
        monitor.start(queue: .main)

        XCTAssertEqual(receivedValue, true)
    }

    // MARK: - SyncServiceProtocol

    func testSyncServiceProtocolAdoption() {
        final class MockSync: SyncServiceProtocol {
            var isConnected: Bool = false
            func start() { isConnected = true }
            func stop() { isConnected = false }
            func enqueueOperation(type: String, payload: Data) async {}
            func triggerSyncForTesting() async {}
        }

        let sync = MockSync()
        sync.start()
        XCTAssertTrue(sync.isConnected)
        sync.stop()
        XCTAssertFalse(sync.isConnected)
    }
}
