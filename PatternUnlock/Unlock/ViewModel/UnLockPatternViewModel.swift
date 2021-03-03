//
//  UnLockPatternViewModel.swift
//  PatternUnlock
//
//  Created by Issam Bendaas on 03.03.21.
//

import Foundation
import Combine

protocol UnLockPatternViewModelInput {

}

protocol UnLockPatternViewModelOutput {

}

final class UnLockPatternViewModel: ObservableObject, Identifiable {

	let unlockKeyA = "0114455773"
	let unlockKeyB = "46633115"
	let unlockDots: [UnlockDotModel]
	let headerText = NSLocalizedString("Try to match one of displayed keys to go to next screen", comment: "")
	let title = NSLocalizedString("Unlock to navigate", comment: "")


	private var touchedDots = [Point]()
	//inputs
	@Published var enteredPattern: String = "-.-.-.-.-.-.-"
	@Published var didAppears: Bool = false
	
	init() {
		unlockDots = UnlockDotIdentifier
			.allCases
			.map { UnlockDotModel(identifier: $0) }
	}
	
}
