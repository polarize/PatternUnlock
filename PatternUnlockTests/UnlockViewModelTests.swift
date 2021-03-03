//
//  UnlockViewModelTests.swift
//  PatternUnlockTests
//
//  Created by Issam Bendaas on 03.03.21.
//

import XCTest
@testable import PatternUnlock

class UnlockViewModelDelegateMock: UnlockViewModelDelegate {

	var challenge: Challenge?

	func unlockViewModel(_ viewModel: UnlockViewModel, didEnterChallenge challenge: Challenge) {
		self.challenge = challenge
	}
}

class UnlockViewModelTests: XCTestCase {

	var delegateMock = UnlockViewModelDelegateMock()
	var sutOutput: UnlockViewModelOutput!
	var sutInput: UnlockViewModelInput!

    override func setUpWithError() throws {
		let sut = UnlockViewModel()
		sut.delegate = delegateMock
		sutOutput = sut
		sutInput = sut
    }

    override func tearDownWithError() throws {

    }

    func testEnteringKeyWillCreateChallenge() throws {
		let wrongChallenge = "wrong"
		sutInput.handleEnteredPattern(wrongChallenge)

		XCTAssertNil(delegateMock.challenge)

		let challengeA = Challenge.userSearch.rawValue
		sutInput.handleEnteredPattern(challengeA)

		XCTAssertTrue(delegateMock.challenge == .userSearch)

		let challengeB = Challenge.userDetails.rawValue
		sutInput.handleEnteredPattern(challengeB)

		XCTAssertTrue(delegateMock.challenge == .userDetails)
    }

	func testTouchingDotWillAddOnce() throws {
		sutInput.clearAllDots()
		let dot1 = DotViewModel(dot: Dot(identifier: 1))
		sutInput.didTouchDot(dot1)

		XCTAssertTrue(sutOutput.touchedDots.contains(dot1))

		sutInput.didTouchDot(dot1)

		XCTAssertTrue(sutOutput.touchedDots.count == 1)
	}

	func testMaxDotesAllowed() throws {

		for dotID in 0...12 {
			let dot = DotViewModel(dot: Dot(identifier: dotID))
			sutInput.didTouchDot(dot)
		}

		XCTAssertTrue(sutOutput.touchedDots.count == Constant.dotKeyMaxLength, "\(sutOutput.touchedDots.count)")

		sutInput.clearAllDots()
	}

	func testAddingDotWillChangeHighlightState() {
		sutInput.clearAllDots()
		let dot = DotViewModel(dot: Dot(identifier: 1))

		XCTAssertTrue(dot.isHighlighted == false)
		sutInput.didTouchDot(dot)

		XCTAssertTrue(dot.isHighlighted == true)

		sutInput.clearAllDots()

		XCTAssertTrue(dot.isHighlighted == false)
	}


	func testMaxDistanceBetweenDots() {
		sutInput.clearAllDots()

		sutInput.patternSize(height: 300, width: 300)

		print("max distance allowed: \(300*300/2)")
		let dot1 = DotViewModel(dot: Dot(identifier: 1))
		dot1.point = Point(x: 20, y: 20)
		sutInput.didTouchDot(dot1)
		XCTAssertTrue(sutOutput.touchedDots.count == 1)


		let dot2 = DotViewModel(dot: Dot(identifier: 2))
		dot2.point = Point(x: 300, y: 150)

		sutInput.didTouchDot(dot2)
		XCTAssertFalse(sutOutput.touchedDots.count == 2)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
