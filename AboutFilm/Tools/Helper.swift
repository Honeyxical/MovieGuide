import UIKit

func getObject() -> [FilmShortInfo]{
    var film: [FilmShortInfo] = []
    NetworkService.network.getFilmList { data in
        film = data
        for i in 0...film.count - 1 {
            let prewURL = film[i].poster?.previewUrl
            let url = film[i].poster?.url
            NetworkService.network.getImage(url: prewURL ?? url!) { data in
                film[i].posterData = data
            }
        }
    }
    
    return film
}
