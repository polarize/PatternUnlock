//
//  ViewController.swift
//  PatternUnlock
//
//  Created by Issam Bendaas on 03.03.21.
//

import UIKit
import Combine

final class UnlockViewController: UIViewController {

	@IBOutlet weak var drawView: PatternLockView!

	@IBOutlet weak var firstKeyLabel: UILabel! {
		didSet {
			firstKeyLabel.text = "23322332"
		}
	}

	@IBOutlet weak var secondKeyLabel: UILabel! {
		didSet {
			secondKeyLabel.text = "32211222"
		}
	}

	@IBOutlet weak var enteredKeyLabel: UILabel! {
		didSet {
			enteredKeyLabel.text = "---------------"
		}
	}

	@IBOutlet weak var headerLabel: UILabel! {
		didSet {
			headerLabel.text = "Header Text"
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

