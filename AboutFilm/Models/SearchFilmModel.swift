import Foundation

struct SearchFilmModel: Decodable{
    var docs: [SearchFilmResult]?
}

struct SearchFilmResult: Decodable{
    let name: String?
    let alternativeName: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let poster: String?
    var posterData: Data?
    let rating: Double?
    let movieLength: Int?
    let genres: [String]?
    let countries: [String]?
    
    init(name: String?, alternativeName: String?, year: Int?, description: String?, shortDescription: String?, poster: String?, posterData: Data? = nil, rating: Double?, movieLength: Int?, genres: [String]?, countries: [String]?) {
        self.name = name
        self.alternativeName = alternativeName
        self.year = year
        self.description = description
        self.shortDescription = shortDescription
        self.poster = poster
        self.posterData = posterData
        self.rating = rating
        self.movieLength = movieLength
        self.genres = genres
        self.countries = countries
    }
}
