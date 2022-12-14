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
    enum CodingKeys: String, CodingKey {
          case comments
          case total
          case skip
          case limit
      }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.comments = try container.decode([Comment1].self, forKey: .comments)
        self.total = try container.decode(Int.self, forKey: .total)
        self.skip = try container.decode(Int.self, forKey: .skip)
        self.limit = try container.decode(Int.self, forKey: .limit)
    }
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
        guard let mainUrl = Bundle.main.url(forResource: "JSON", withExtension: "json") else {return}
                do {
                    let data = try Data(contentsOf: mainUrl)
                    let decoder = JSONDecoder()
                    let finalData = try decoder.decode(User1.self, from: data)
                    print(finalData)
                } catch {
                    print(error)
                }
            }
    }
