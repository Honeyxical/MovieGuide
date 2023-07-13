import Foundation
import UIKit

struct FilmFullInfo: Decodable{
    let id: Int?
    
    let name: String?
    let alternativeName: String?
    let enName: String?
    
    let description: String?
    let shortDescription: String?
    let slogan: String?
    
    let year: Int?
    let ageRating: Int?
    let movieLength: Int?
    
    let rating: Rating?
    
    var poster: Poster?
    
    let genres: [Generes]?
    
    let countries: [Countries]?
    
    var persons: [Person]?
    
    var similarMovies: [SimilarMovies]?
    
    let statusCode: Int?
    let message: String?
    let error: String?
}

struct Rating: Decodable{
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

struct Premiere: Decodable{
    let country: String?
    let world: Date?
    let digital: Date?
}

struct Poster: Decodable{
    let url: String?
    let previewUrl: String?
    var posterData: Data?
}

struct Person: Decodable{
    let id: Int?
    let photo: String?
    let name: String?
    let enName: String?
    let profession: String?
    let enProfession: String?
    var photoData: Data?
}

struct SimilarMovies: Decodable{
    let id: Int?
    let name: String?
    let enName: String?
    let alternativeName: String?
    let type: String?
    var poster: Poster?
}

struct Generes: Decodable{
    let name: String?
}
struct Countries: Decodable{
    let name: String?
}
