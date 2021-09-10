import Foundation

public enum Quarter: String, CaseIterable, Codable {
    case q1
    case q2
    case q3
    case q4
}

public typealias BookCategory = Book.Category

public struct Book: Identifiable, Codable {
    public var id = UUID()
    public enum Category: String, CaseIterable, Codable {
        case emotion
        case education
        case language
        case other
    }

    public var name: String
    public var category: Category
    public var publishDate: Quarter
    
    public init(id: UUID = UUID(), name: String, category: Category, publishDate: Quarter) {
        self.id = id
        self.name = name
        self.category = category
        self.publishDate = publishDate
    }
}

extension Book: Hashable {
    public init?(dict: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    public var json: [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return dictionary
        } catch {
            return nil
        }
    }
}
