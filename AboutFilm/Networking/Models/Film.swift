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
    var posterData: Data?
    
    let genres: [Generes]?
    
    let countries: [Countries]?
    
    let persons: [Person]?
    
    let similarMovies: [SimilarMovies]?
    
}

struct Rating: Decodable{
    let kinopoisk: Double?
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

struct Backdrop: Decodable{
    let url: String?
    let previewUrl: String?
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
    let poster: Poster?
    var posterData: Data?
}

struct Generes: Decodable{
    let name: String?
}
struct Countries: Decodable{
    let name: String?
}



