// SageCore/Tests/SageCoreTests/ViewStateTests.swift
import XCTest
@testable import SageCore

final class ViewStateTests: XCTestCase {

    func testIdleState() {
        let state: ViewState<String> = .idle
        if case .idle = state { } else {
            XCTFail("État devrait être .idle")
        }
    }

    func testLoadingState() {
        let state: ViewState<Int> = .loading
        if case .loading = state { } else {
            XCTFail("État devrait être .loading")
        }
    }

    func testSuccessStateWithValue() {
        let state: ViewState<String> = .success("Bonjour")
        if case .success(let value) = state {
            XCTAssertEqual(value, "Bonjour")
        } else {
            XCTFail("État devrait être .success")
        }
    }

    func testSuccessStateWithArray() {
        let state: ViewState<[Int]> = .success([1, 2, 3])
        if case .success(let values) = state {
            XCTAssertEqual(values, [1, 2, 3])
        } else {
            XCTFail("État devrait être .success avec tableau")
        }
    }

    func testErrorStateContainsAppError() {
        let appError = AppError.auth("Token expiré")
        let state: ViewState<String> = .error(appError)
        if case .error(let error) = state {
            if case .auth(let msg) = error {
                XCTAssertEqual(msg, "Token expiré")
            } else {
                XCTFail("AppError devrait être .auth")
            }
        } else {
            XCTFail("État devrait être .error")
        }
    }

    func testViewStateWorksWithCustomType() {
        struct TestModel { let name: String }
        let state: ViewState<TestModel> = .success(TestModel(name: "Test"))
        if case .success(let model) = state {
            XCTAssertEqual(model.name, "Test")
        } else {
            XCTFail("ViewState doit accepter n'importe quel type générique")
        }
    }
}
