import UIKit

final class GithubUserViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel! {
		didSet {
			titleLabel.text = viewModel.user.name
		}
	}

	@IBOutlet weak var avatarImageView: UIImageView! {
		didSet {
			guard let url = viewModel.avatarURL else {
				return
			}
			avatarImageView.load(url: url)
		}
	}

	var viewModel: GithubUserViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}

