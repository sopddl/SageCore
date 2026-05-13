// Tests/SageCoreTests/SupportedLanguageTests.swift
// Story 11.7 — Tests SupportedLanguage

import XCTest
@testable import SageCore

final class SupportedLanguageTests: XCTestCase {

    // MARK: - allCases (AC4)

    func testAllCases_containsFrenchEnglishSpanish() {
        let allCases = SupportedLanguage.allCases
        XCTAssertTrue(allCases.contains(.french), "allCases should contain .french")
        XCTAssertTrue(allCases.contains(.english), "allCases should contain .english")
        XCTAssertTrue(allCases.contains(.spanish), "allCases should contain .spanish")
        XCTAssertGreaterThanOrEqual(allCases.count, 3)
    }

    // MARK: - rawValue

    func testRawValue_french_isFr() {
        XCTAssertEqual(SupportedLanguage.french.rawValue, "fr")
    }

    func testRawValue_english_isEn() {
        XCTAssertEqual(SupportedLanguage.english.rawValue, "en")
    }

    func testRawValue_spanish_isEs() {
        XCTAssertEqual(SupportedLanguage.spanish.rawValue, "es")
    }

    // MARK: - nativeName

    func testNativeName_french_isFrançais() {
        XCTAssertEqual(SupportedLanguage.french.nativeName, "Français")
    }

    func testNativeName_english_isEnglish() {
        XCTAssertEqual(SupportedLanguage.english.nativeName, "English")
    }

    func testNativeName_spanish_isEspañol() {
        XCTAssertEqual(SupportedLanguage.spanish.nativeName, "Español")
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

    func testInitLanguageCode_validEs() {
        XCTAssertEqual(SupportedLanguage(languageCode: "es"), .spanish)
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
