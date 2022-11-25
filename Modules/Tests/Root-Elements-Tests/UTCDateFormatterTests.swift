@testable import Root_Elements
import XCTest

final class UTCDateFormatterTests: XCTestCase {
    private let formatter = ISO8601DateFormatter()

    func test_toLocal_whenReceivedDateIsToday() {
        // Given
        let receivedDate = "2022-11-25T18:05:00Z"
        let expectedValue = "Hoje, 15:05"
        let sut = UTCDateFormatter(
            isToday: { _ in true }
        )
        // When
        let value = sut.toLocal(receivedDate)
        // Then
        XCTAssertEqual(value, expectedValue)
    }

    func test_toLocal_whenIsDateInThisWeekAndIsNotToday() {
        // Given
        let receivedDate = "2022-11-26T18:25:00Z"
        guard let today = formatter.date(from: "2022-11-25T18:00:00Z") else {
            XCTFail("Invalid Date (UTC)")
            return
        }
        let expectedValue = "Sáb, 15:25"
        let sut = UTCDateFormatter(
            isToday: { _ in false },
            isDateInThisWeek: { _, _ in true },
            currentDate: { today }
        )
        // When
        let value = sut.toLocal(receivedDate)
        // Then
        XCTAssertEqual(value, expectedValue)
    }

    func test_toLocal_whenIsNotDateInThisWeekAndIsNotToday() {
        // Given
        let receivedDate = "2022-12-05T18:00:00Z"
        guard let today = formatter.date(from: "2022-12-25T18:00:00Z") else {
            XCTFail("Invalid Date (UTC)")
            return
        }
        let expectedValue = "05.12 15:00"
        let sut = UTCDateFormatter(
            isToday: { _ in false },
            isDateInThisWeek: { _, _ in false },
            currentDate: { today }
        )
        // When
        let value = sut.toLocal(receivedDate)
        // Then
        XCTAssertEqual(value, expectedValue)
    }
}
