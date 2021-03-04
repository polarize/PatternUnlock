import UIKit

final class GithubSearchViewController: UIViewController {

	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!

	@IBOutlet weak var searchButton: UIButton!

	var viewModel: GithubSearchViewModel!

	var dataSource: UITableViewDiffableDataSource<Section, UserResponse>?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		fetchUsers("eric")
	}


	func populate(with users: [UserResponse]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, UserResponse>()
		snapshot.appendSections([.main])
		snapshot.appendItems(users)
		dataSource?.apply(snapshot)
	}

	func fetchUsers(_ username: String) {

		NetworkingService.requestUsers(userName: username) { [weak self] result in
			switch result {
				case .success(let users):
					self?.populate(with: users)

				case .failure(let error):
					print(error)
			}

		}
	}

	private func setupTableView() {

		dataSource = UITableViewDiffableDataSource<Section, UserResponse>(tableView: tableView) { tableView, indexPath, user in

			let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

			print(user)
			cell.textLabel?.text = user.name
			return cell

		}

	}
}

extension GithubSearchViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
