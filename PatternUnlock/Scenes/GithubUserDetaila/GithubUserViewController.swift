import UIKit

final class GithubUserViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel! {
		didSet {
			titleLabel.text = viewModel.user.name
		}
	}

	@IBOutlet weak var avatarImageView: UIImageView!

	var viewModel: GithubUserViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}

