import Foundation

class NetworkService{
    let API_KEY = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"
    
    func getRandomFilm(completition: @escaping (Film) -> Void){
        URLSession.shared.dataTask(with: getRequestForRandomFilm()) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            //2020-11-27T00:00:00.000Z
            
            do{
                let decoder = JSONDecoder()
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormater)
                
                let obj = try decoder.decode(Film.self, from: data)
                completition(obj)
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func getFilms(completition: @escaping ([Docs]) -> Void){
        URLSession.shared.dataTask(with: getFilmList(limit: 10)) {data, response, error in
            guard let data = data, error == nil else {
                fatalError("Response error")
            }
            
            do{
                let films = try JSONDecoder().decode(Film.self, from: data)
                let docs = self.insertPoster(docs: films.docs!)
                print(docs[0])
                completition(docs)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRequestForRandomFilm() -> URLRequest{
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie/random")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    func getFilmList(limit: Int) -> URLRequest{
        let randomPage = Int.random(in: 1...9000)
        print(randomPage)
        var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie?selectFields=shortDescription&selectFields=id&selectFields=name&selectFields=poster.url&page=1&limit=\(limit)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
        return request
    }
    
    func getPosterUrl(url: String) -> URLRequest{
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
            
            docs[i].poster!.posterData = try? Data(contentsOf: URL(string: (docs[i].poster?.url)!)!)
            
            //        getPoster(url: (docs[i].poster?.url!)!) { data in
            //            print(data)
            //            docs[i].poster?.posterData = data
            //        }
        }
        return docs
    }
    
    func getPoster(url: String, completition: @escaping (Data) -> Void){
        URLSession.shared.dataTask(with: getPosterUrl(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                fatalError("Error get poster")
            }
            completition(data)
        }.resume()
    }
}
