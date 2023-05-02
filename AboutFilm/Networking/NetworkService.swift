import Foundation

class NetworkService{
    static let network = NetworkService()
    
    private let API_KEY = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    
    func getFilmList(completition: @escaping ([FilmShortInfo]) -> Void){
        URLSession.shared.dataTask(with: getRequestForFilmList(limit: 10)) {data, response, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do{
                var films = try JSONDecoder().decode(FilmList.self, from: data)
//                films.docs = self.insertPosters(docs: films.docs!)
                completition(films.docs!)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRandomFilm(completition: @escaping (FilmFullInfo) -> Void){
        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(response)
                fatalError()
            }
            
            do{
                var film = try JSONDecoder().decode(FilmFullInfo.self, from: data)
                getImage(url: film.poster!.url!) { data in
                    film.poster!.posterData = data
                }
                film.similarMovies = insertPosterForSimilarMovies(array: film.similarMovies!)
                film.persons = insertPersonsImage(array: film.persons!)
                completition(film)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func searchFilm(name: String, completition: @escaping ([SearchFilmInfo]) -> Void) {
        URLSession.shared.dataTask(with: getRequestForSearchFilm(name: name)) { data, response, error in
            guard let data = data, error == nil else{
                fatalError()
            }
            
            do{
                let films = try JSONDecoder().decode(SearchFilmList.self, from: data)
                let docs = self.insertPosters(docs: films.docs!)
                completition(docs)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    func getImage(url: String, completition: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) {data, response, error in
            guard let data = data, error == nil  else {
                print("\n\nError download image\n")
                fatalError()
            }
            print("poster downloaded: \(data)")
            completition(data)
        }.resume()
    }
    
    //MARK: - Private func
    
    private func getRequestForRandomFilm() -> URLRequest{
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie/random")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForFilmList(limit: Int) -> URLRequest{
        let randomPage = Int.random(in: 1...50)
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie?selectFields=id&selectFields=enName&selectFields=poster.url&selectFields=shortDescription&selectFields=description&selectFields=type&selectFields=year&selectFields=rating.imdb&selectFields=movieLength&selectFields=genres.name&selectFields=name&page=\(String(randomPage))&limit=" + String(limit))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func getRequestForSearchFilm(name: String) -> URLRequest{
        let name = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1.2/movie/search?page=1&limit=10&query=\(name!)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func insertPosters(docs: [FilmShortInfo]) -> [FilmShortInfo] {
        var docs = docs
        for i in 0...docs.count - 1 {
            getImage(url: docs[i].poster!.previewUrl ?? docs[i].poster!.url!) { data in
                docs[i].poster!.posterData = data
            }
        }
        return docs
    }
    
    private func insertPosters(docs: [SearchFilmInfo]) -> [SearchFilmInfo]{
        var docs = docs
        if docs.isEmpty{
            return docs
        }
        for i in 0...docs.count - 1 {
            guard let posterUrl = docs[i].poster else {
                continue
            }
            getImage(url: posterUrl) { data in
                docs[i].posterData = data
            }
        }
        return docs
    }
    
    private func insertPosterForSimilarMovies(array: [SimilarMovies]) -> [SimilarMovies]{
        if array.isEmpty {
            return array
        }
        var array = array
        
        for i in 0...array.count - 1 {
            getImage(url: array[i].poster!.previewUrl ?? array[i].poster!.url!) { data in
                array[i].posterData = data
            }
        }
        return array
    }
    
    private func insertPersonsImage(array: [Person]) -> [Person] {
        if array.isEmpty{
            return array
        }
        var array = array
        
        for i in 0...array.count - 1 {
            guard let personImageUrl = array[i].photo else {
                continue
            }
            getImage(url: personImageUrl) { data in
                array[i].photoData = data
            }
        }
        
        return array
    }
}
