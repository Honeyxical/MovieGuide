import Foundation

struct FilmList:Decodable{
    var docs: [FilmShortInfo]?
}

struct FilmShortInfo: Decodable {
    let id: Int?
    let name: String?
    let alternativeName: String?
    let description: String?
    let shortDescription: String?
    var poster: Poster?
    var posterData: Data?
}

struct SearchFilmList: Decodable {
    var docs: [SearchFilmInfo]?
}

struct SearchFilmInfo: Decodable {
    let id: Int?
    let name: String?
    let alternativeName: String?
    let year: Int?
    let genres: [String]?
    let countries: [String]?
    let poster: String?
    var posterData: Data?
}

struct FilmImages: Decodable {
    var docs: [PostersImage]?
}

struct PostersImage: Decodable {
    let url: String?
    let previewUrl: String?
    var imageData: Data?
}
