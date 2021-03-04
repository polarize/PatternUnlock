import Foundation

struct UsersResponse {
	let items : [UserResponse]?
}

extension UsersResponse : Decodable {
	enum CodingKeys: String, CodingKey {
		case items
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		items = try values.decodeIfPresent([UserResponse].self, forKey: .items)
	}
}

struct UserResponse: Hashable {
	let avatarUrl : String?
	let name : String?
}

extension UserResponse : Decodable {
	enum CodingKeys: String, CodingKey {
		case avatarUrl = "avatar_url"
		case name = "login"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}
}
