import Foundation

protocol NetworkServiceProtocol {
    func getFilmById(id: Int, completiton: @escaping (FilmFullInfo) -> Void)
    func getFilmList(completition: @escaping ([FilmShortInfo]) -> Void)
    func getRandomFilm(completition: @escaping (FilmFullInfo) -> Void)
    func searchFilm(name: String, completition: @escaping ([SearchFilmInfo]) -> Void)
    func getFilmPostersURL(id: Int, completition: @escaping ([PostersURL]) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    private let reserveApiKey = "T7P5MRK-8ZG4FAC-N3ZRJWE-6VT9V3N"

    let serialQueue = DispatchQueue(label: "network.service.serial-queue", attributes: .concurrent)

    func getFilmById(id: Int, completiton: @escaping (FilmFullInfo) -> Void) {
        URLSession.shared.dataTask(with: getRequestForFilmById(id: id)) { data, _, error in
            guard let data = data, error == nil else {
                print("\n\n Error to get film by Id")
                fatalError()
            }
            
            do {
                let film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                completiton(film)
            } catch {
                print(error)
            }

        }.resume()
    }
    
    func getFilmList(completition: @escaping ([FilmShortInfo]) -> Void) {
        URLSession.shared.dataTask(with: getRequestForFilmList(limit: 10)) {data, _, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do {
                let films = try JSONDecoder().decode(FilmList.self, from: data)
                if films.docs != nil {
                    completition(films.docs!)
                } else {
                    completition([])
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRandomFilm(completition: @escaping (FilmFullInfo) -> Void) {
        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                var film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                completition(film)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func searchFilm(name: String, completition: @escaping ([SearchFilmInfo]) -> Void) {
        URLSession.shared.dataTask(with: getRequestForSearchFilm(name: name)) { data, _, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do {
                let films = try JSONDecoder().decode(SearchFilmList.self, from: data)
                completition(films.docs!)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getFilmPostersURL(id: Int, completition: @escaping ([PostersURL]) -> Void) {
        URLSession.shared.dataTask(with: getRequestForFilmPosters(id: id, limit: 15)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let posters = try JSONDecoder().decode(FilmPosters.self, from: data)
                completition(posters.docs!)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - Private func

    private func getRequestForFilmPosters(id: Int, limit: Int) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/image?page=1&limit=\(limit)&movieId=\(id)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForFilmById(id: Int) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1.3/movie/\(id)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForRandomFilm() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie/random")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForFilmList(limit: Int) -> URLRequest {
        let randomPage = Int.random(in: 1...50)

        // swiftlint:disable line_length
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie?selectFields=id&selectFields=enName&selectFields=poster.url&selectFields=shortDescription&selectFields=description&selectFields=type&selectFields=year&selectFields=rating.imdb&selectFields=movieLength&selectFields=genres.name&selectFields=name&page=\(String(randomPage))&limit=" + String(limit))!)
        // swiftlint:enable line_length
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForSearchFilm(name: String) -> URLRequest {
        let name = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1.2/movie/search?page=1&limit=10&query=\(name!)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
