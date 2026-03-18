// Tests/SageCoreTests/SupportedLanguageTests.swift
// Story 11.7 — Tests SupportedLanguage

import XCTest
@testable import SageCore

final class SupportedLanguageTests: XCTestCase {

    // MARK: - allCases (AC4)

    func testAllCases_containsFrenchAndEnglish() {
        let allCases = SupportedLanguage.allCases
        XCTAssertTrue(allCases.contains(.french), "allCases should contain .french")
        XCTAssertTrue(allCases.contains(.english), "allCases should contain .english")
        XCTAssertGreaterThanOrEqual(allCases.count, 2)
    }

    // MARK: - rawValue

    func testRawValue_french_isFr() {
        XCTAssertEqual(SupportedLanguage.french.rawValue, "fr")
    }

    func testRawValue_english_isEn() {
        XCTAssertEqual(SupportedLanguage.english.rawValue, "en")
    }

    // MARK: - nativeName

    func testNativeName_french_isFrançais() {
        XCTAssertEqual(SupportedLanguage.french.nativeName, "Français")
    }

    func testNativeName_english_isEnglish() {
        XCTAssertEqual(SupportedLanguage.english.nativeName, "English")
    }

    // MARK: - Identifiable

    func testId_matchesRawValue() {
        for lang in SupportedLanguage.allCases {
            XCTAssertEqual(lang.id, lang.rawValue)
        }
    }

    // MARK: - init(languageCode:)

    func testInitLanguageCode_validFr() {
        XCTAssertEqual(SupportedLanguage(languageCode: "fr"), .french)
    }

    func testInitLanguageCode_validEn() {
        XCTAssertEqual(SupportedLanguage(languageCode: "en"), .english)
    }

    func testInitLanguageCode_unsupported_fallsBackToFrench() {
        XCTAssertEqual(SupportedLanguage(languageCode: "de"), .french)
        XCTAssertEqual(SupportedLanguage(languageCode: "xyz"), .french)
    }

    // MARK: - Codable

    func testCodable_roundTrip() throws {
        let original = SupportedLanguage.english
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(SupportedLanguage.self, from: data)
        XCTAssertEqual(decoded, original)
    }
}
