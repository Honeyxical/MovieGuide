import Foundation

class NetworkService{
    let API_KEY = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    
//    func getRandomFilm(completition: @escaping (Film) -> Void){
//        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let data = data else { return }
//
//            //2020-11-27T00:00:00.000Z
//
//            do{
//                let decoder = JSONDecoder()
//                let dateFormater = DateFormatter()
//                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//                decoder.dateDecodingStrategy = .formatted(dateFormater)
//
//                let obj = try decoder.decode(Film.self, from: data)
//                completition(obj)
//            }catch{
//                print(error)
//            }
//        }.resume()
//    }
    
    func getFilms(completition: @escaping ([Docs]) -> Void){
        URLSession.shared.dataTask(with: getRequestForFilmList(limit: 10)) {data, response, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do{
                let films = try JSONDecoder().decode(Film.self, from: data)
                let docs = self.insertPoster(docs: films.docs!)
                completition(docs)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRandomFilm(completition: @escaping (Docs) -> Void){
        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { data, response, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do{
                let decoder = JSONDecoder()
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormater)
                
                var film = try decoder.decode(Docs.self, from: data)
                film = self.insertPoster(film: film)
                completition(film)
            } catch {
                print(error)
            }
        }.resume()
    }
    
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
    
    private func getPosterUrl(url: String) -> URLRequest{
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    private func insertPoster(docs: [Docs]) -> [Docs]{
        var docs = docs
        for i in 0...docs.count - 1 {
            guard let _ = docs[i].poster?.url else {
                continue
            }
            
            docs[i].poster!.posterData = try! Data(contentsOf: URL(string: (docs[i].poster?.url)!)!)
        }
        return docs
    }
    
    private func insertPoster(film: Docs) -> Docs{
        var film = film
        film.poster!.posterData = try! Data(contentsOf: URL(string: (film.poster?.url)!)!)
        return film
    }
}
