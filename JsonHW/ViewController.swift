//
//  ViewController.swift
//  JsonHW
//
//  Created by Stanislav Sobolevsky on 1.11.22.
//

import UIKit

// MARK: - User
struct User: Codable {
    let comments: [Comment]
    let total, skip, limit: Int
}
// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let body: String
    let postID: Int
    let user: UserClass

    enum CodingKeys: String, CodingKey {
        case id, body
        case postID = "postId"
        case user
    }
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
// MARK: - При декодировании возможны следующие виды ошибок:
//        DecodingError.dataCorrupted(DecodingError.Context) — данные повреждены. Обычно означает что данные, которые вы пытаетесь декодировать не соответствуют ожидаемому формату, например вместо ожидаемого JSON вы получили совсем другой формат.
//        DecodingError.keyNotFound(CodingKey, DecodingError.Context) — требуемое поле не было найдено. Означает что поле, которое вы ожидали получить, отсутствует
//        DecodingError.typeMismatch(Any.Type, DecodingError.Context) — несоответствие типов. Когда тип данных в модели не совпадает с типом полученного поля
//        DecodingError.valueNotFound(Any.Type, DecodingError.Сontext) — отсутствует значение для определенного поля. Поле, которое вы определили в модели данных, не смогло проинициализироваться, вероятно, в полученных данных это поле равно nil. Эта ошибка происходит только с неопциональными полями, если поле не обязательно должно иметь значение, не забудьте сделать его опционалом.
    guard let mainUrl = Bundle.main.url(forResource: "JSON", withExtension: "json") else {
        return }
        do {
            let data = try Data(contentsOf: mainUrl)
            let decoder = JSONDecoder()
            _ = try decoder.decode(User.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
        } catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key,context))
        } catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type,context))
        } catch DecodingError.valueNotFound(let value, let context) {
            print(DecodingError.valueNotFound(value,context))
        } catch let error {
            print(error)
        }
    }
}
