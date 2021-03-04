import Foundation

protocol Networking {
	static func requestUsers(userName: String, completion: @escaping (Result<[UserResponse], Error>) -> Void)
}

enum NetworkingService: Networking {
	static var baseURL = "https://api.github.com/search/users?q="

	static func requestUsers(userName: String, completion: @escaping (Result<[UserResponse], Error>) -> Void) {

		let url = URL(string: baseURL.appending(userName))!

		let task = URLSession.shared.dataTask(with: url) { data, response, error  in
			DispatchQueue.main.async {

				if let error = error {
					completion(.failure(error))
				} else if let data = data, let users = try? JSONDecoder().decode(UsersResponse.self, from: data) {
					completion(.success(users.items ?? []))
				}
			}

		}
		task.resume()
	}
}
