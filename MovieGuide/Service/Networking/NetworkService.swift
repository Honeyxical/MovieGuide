import Foundation

protocol NetworkServiceProtocol {
    func getFilmById(id: Int, completition: @escaping (FilmFullInfo) -> Void)
    func getFilmList(completition: @escaping ([FilmShortInfo]) -> Void)
    func getRandomFilm(completition: @escaping (FilmFullInfo) -> Void)
    func searchFilm(name: String, completition: @escaping ([SearchFilmInfo]) -> Void)
    func getFilmPostersURL(id: Int, completition: @escaping ([PostersURL]) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    private let reserveApiKey = "T7P5MRK-8ZG4FAC-N3ZRJWE-6VT9V3N"

    let serialQueue = DispatchQueue(label: "network.service.serial-queue", attributes: .concurrent)

    enum NetworkServiceError: Error {
        case wrongUrl
    }

    func getFilmById(id: Int, completition: @escaping (FilmFullInfo) -> Void) {
        guard let request = getRequestForFilmById(id: id) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("\n\n Error to get film by Id")
                return
            }
            
            do {
                let film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                DispatchQueue.main.async {
                    completition(film)
                }
            } catch {
                print(error)
            }

        }.resume()
    }
    
    func getFilmList(completition: @escaping ([FilmShortInfo]) -> Void) {
        guard let request = getRequestForFilmList(limit: 10) else { return }
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let films = try JSONDecoder().decode(FilmList.self, from: data)
                if let docs = films.docs {
                    DispatchQueue.main.async {
                        completition(docs)
                    }
                } else {
                    completition([])
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRandomFilm(completition: @escaping (FilmFullInfo) -> Void) {
        guard let request = getRequestForRandomFilm() else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                DispatchQueue.main.async {
                    completition(film)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func searchFilm(name: String, completition: @escaping ([SearchFilmInfo]) -> Void) {
        guard let request = getRequestForSearchFilm(name: name) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let films = try JSONDecoder().decode(SearchFilmList.self, from: data)
                guard let docs = films.docs else { return }
                DispatchQueue.main.async {
                    completition(docs)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getFilmPostersURL(id: Int, completition: @escaping ([PostersURL]) -> Void) {
        guard let request = getRequestForFilmPosters(id: id, limit: 15) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let posters = try JSONDecoder().decode(FilmPosters.self, from: data)
                guard let docs = posters.docs else { return }
                DispatchQueue.main.async {
                    completition(docs)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - Private func

    private func getRequestForFilmPosters(id: Int, limit: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/image?page=1&limit=\(limit)&movieId=\(id)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForFilmById(id: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.3/movie/\(id)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForRandomFilm() -> URLRequest?  {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie/random") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForFilmList(limit: Int) -> URLRequest? {
        let randomPage = Int.random(in: 1...50)

        // swiftlint:disable line_length
        guard let url = URL(string: "https://api.kinopoisk.dev/v1/movie?selectFields=id&selectFields=enName&selectFields=poster.url&selectFields=shortDescription&selectFields=description&selectFields=type&selectFields=year&selectFields=rating.imdb&selectFields=movieLength&selectFields=genres.name&selectFields=name&page=\(String(randomPage))&limit=" + String(limit)) else { return nil }
        // swiftlint:enable line_length

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForSearchFilm(name: String) -> URLRequest? {
        let name = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.2/movie/search?page=1&limit=10&query=\(String(describing: name))") else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
