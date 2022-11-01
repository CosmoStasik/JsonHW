//
//  HandMadeViewController.swift
//  JsonHW
//
//  Created by Stanislav Sobolevsky on 1.11.22.
//

import UIKit

// MARK: - User
struct User1: Codable {
    let comments: [Comment1]
    let total, skip, limit: Int
}

// MARK: - Comment
struct Comment1: Codable {
    let id: Int
    let body: String
    let postID: Int
    let user: UserClass1

    enum CodingKeys: String, CodingKey {
        case id, body
        case postID = "postId"
        case user
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.body = try container.decode(String.self, forKey: .body)
        self.postID = try container.decode(Int.self, forKey: .postID)
        self.user = try container.decode(UserClass1.self, forKey: .user)
    }
}

// MARK: - UserClass
struct UserClass1: Codable {
    let id: Int
    let username: String
}

class HandMadeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
