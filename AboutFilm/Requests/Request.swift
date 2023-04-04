import Foundation

let API_KEY = "TN3T3HK-GGE44PM-KAMXMJW-HRQ4X7Q"

func getRandomFilm(completition: @escaping (Film) -> Void){
    URLSession.shared.dataTask(with: getRequest()) { data, response, error in
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

func getRequest() -> URLRequest{
    var request = URLRequest(url: URL(string: "https://api.kinopoisk.dev/v1/movie/random")!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "accept")
    request.addValue(API_KEY, forHTTPHeaderField: "X-API-KEY")
    return request
}
