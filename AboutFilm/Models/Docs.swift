import Foundation

struct Docs: Decodable{
    let id: Int?
    let name: String?
    let shortDescription: String?
    var poster: Poster?
}
