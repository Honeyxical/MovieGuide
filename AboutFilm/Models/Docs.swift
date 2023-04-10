import Foundation

struct Docs: Decodable{
    let id: Int?
    let name: String?
    let shortDescription: String?
    let description: String?
    var poster: Poster?
    let genres: [Generes?]
    let rating: Rating?
    let type: String?
    let year: Int?
    let movieLength: Int?
    
}
