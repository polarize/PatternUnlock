import UIKit
import Combine

final class GithubSearchViewController: UIViewController {

	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!

	@IBOutlet weak var searchButton: UIButton!

	var viewModel: GithubSearchViewModel!

	var dataSource: UITableViewDiffableDataSource<Section, UserResponse>?
	private var cancellables = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()

		viewModel.$users
			.receive(on: DispatchQueue.main)
			.sink {[weak self] users in
				self?.populate(with: users)
			}
			.store(in: &cancellables)
	}


	@IBAction func searchButtonTapped(_ sender: UIButton) {
		guard let keyword = searchTextField.text, keyword.count > 2 else {
			return
		}
		viewModel.didTapSearch(keyword)
	}

	func populate(with users: [UserResponse]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, UserResponse>()
		snapshot.appendSections([.main])
		snapshot.appendItems(users)
		dataSource?.apply(snapshot)
	}

	

	private func setupTableView() {

		dataSource = UITableViewDiffableDataSource<Section, UserResponse>(tableView: tableView) { tableView, indexPath, user in

			let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

			cell.textLabel?.text = user.name
			return cell
		}

	}
}

extension GithubSearchViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.didSelectUser(at: indexPath)
	}
}

extension GithubSearchViewController {
	enum Section {
		case main
	}
}

struct User: Decodable {
	let id: Int
	let name: String
}

extension User: Hashable {}
