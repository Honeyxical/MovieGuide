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
    
    let type: String?
    let typeNumber: Int?
    
    let year: Int?
    let ageRating: Int?
    let movieLength: Int?
    let ratingMpaa: String?
    
    let videos: Videos?
    
    let externalId: ExternalId?
    
    let rating: Rating?
    let votes: Votes?
    
    let premiere: Premiere?
    
    var poster: Poster?
    
    let facts: [Facts]?
    
    let genres: [Generes]?
    
    let countries: [Countries]?
    
    let persons: [Persons]?
    
    let similarMovies: [SimilarMovies]?
    
    let backdrop: Backdrop?
    
    let logo: Logo?
}

struct Facts: Decodable {
    let value: String?
    let type: String?
    let spoiler: Bool?
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

struct Persons: Decodable{
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


