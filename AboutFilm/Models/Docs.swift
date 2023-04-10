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
    
    init(id: Int?, name: String?, shortDescription: String?, description: String?, poster: Poster?, genres: [Generes?], rating: Rating?, type: String?, year: Int?, movieLength: Int?) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
        self.poster = poster
        self.genres = genres
        self.rating = rating
        self.type = type
        self.year = year
        self.movieLength = movieLength
    }
}
