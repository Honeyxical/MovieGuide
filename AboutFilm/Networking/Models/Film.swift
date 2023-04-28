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
    
    let persons: [Person]?
    
    let similarMovies: [SimilarMovies]?
    
    let logo: Logo?
}

struct Rating: Decodable{
    let kinopoisk: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

struct ExternalId: Decodable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}

struct Votes: Decodable{
    let kinopoisk: Int?
    let imdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
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

struct Logo: Decodable {
    let url: String?
}

struct Person: Decodable{
    let id: Int?
    let photo: String?
    let name: String?
    let enName: String?
    let profession: String?
    let enProfession: String?
}

struct SimilarMovies: Decodable{
    let id: Int?
    let name: String?
    let enName: String?
    let alternativeName: String?
    let type: String?
    let poster: Poster?
}

struct Videos: Decodable {
    let trailers: [Trailer]?
    let teasers: [Trailer]?
}

struct Trailer: Decodable{
    let url: String?
    let name: String?
    let site: String?
    let type: String?
}

// Переделать в енам :

struct Generes: Decodable{
    let name: String?
}
struct Countries: Decodable{
    let name: String?
}

// Seasons info dobavit


