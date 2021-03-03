import UIKit

final class GithubSearchViewController: UIViewController {

	let mainView = GithubSearchView()

	let viewModel: GithubSearchViewModel

	init(with viewModel: GithubSearchViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}

