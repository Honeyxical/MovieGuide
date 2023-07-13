import Foundation

class NetworkService {
    private let apiKey = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    private let reserveApiKey = "T7P5MRK-8ZG4FAC-N3ZRJWE-6VT9V3N"
    
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
        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { [self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                var film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                getImage(url: film.poster!.url!) { data in
                    film.poster!.posterData = data
                }
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
                let docs = self.insertPosters(docs: films.docs!)
                completition(docs)
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
    
   private func getImage(url: String, completition: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) {data, _, error in
            guard let data = data, error == nil  else {
                print("\n\nError download image\n")
                fatalError()
            }
            completition(data)
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
    
    private func insertPosters(docs: [FilmShortInfo]) -> [FilmShortInfo] {
        var docs = docs
        for counter in 0...docs.count - 1 {
            getImage(url: docs[counter].poster!.previewUrl ?? docs[counter].poster!.url!) { data in
                docs[counter].poster!.posterData = data
            }
        }
        return docs
    }
    
    private func insertPosters(docs: [SearchFilmInfo]) -> [SearchFilmInfo] {
        var docs = docs
        if docs.isEmpty {
            return docs
        }
        for counter in 0...docs.count - 1 {
            guard let posterUrl = docs[counter].poster else {
                continue
            }
            getImage(url: posterUrl) { data in
                docs[counter].posterData = data
            }
        }
        return docs
    }
    
    private func insertPosterForSimilarMovies(array: [SimilarMovies]) -> [SimilarMovies] {
        if array.isEmpty {
            return array
        }
        var array = array
        
        for counter in 0...array.count - 1 {
            getImage(url: array[counter].poster!.previewUrl ?? array[counter].poster!.url!) { data in
                array[counter].poster?.posterData = data
            }
        }
        return array
    }
    
    private func insertPersonsImage(array: [Person]) -> [Person] {
        if array.isEmpty {
            return array
        }
        var array = array
        
        for counter in 0...array.count - 1 {
            guard let personImageUrl = array[counter].photo else {
                continue
            }
            getImage(url: personImageUrl) { data in
                array[counter].photoData = data
            }
        }
        
        return array
    }
    
    func getPosters(array: [PostersURL]) -> [Data] {
        var resultArray: [Data] = []
        for elem in array {
            getImage(url: elem.previewUrl ?? elem.url!) { data in
                resultArray.append(data)
            }
        }
        print("return array images")
        return resultArray
    }
}
