import UIKit

protocol UserProtocol {
    var nickname: String {get set}
    var login: String {get set}
    var password: String {get set}
    var favouriteFilms: [NSNumber] {get set}
    var email: String {get set}
    var userImage: Data {get set}
    
    func getUserLoginAndEmail() -> (String, String)
    func getFavouritesFilms() -> [Int]
    func addFavouriteFilm(filmId: Int, user: User)
    }

class User: NSObject, NSCoding, UserProtocol {
    internal var nickname: String
    internal var email: String
    internal var login: String
    internal var password: String
    internal var favouriteFilms: [NSNumber] = []
    internal var userImage: Data

    init(nickname: String, email: String, login: String, password: String, userHash: Int) {
        self.nickname = nickname
        self.email = email
        self.login = login
        self.password = password
        self.userImage = (UIImage(named: "Ghost")?.pngData())!
    }
    
    func getUserLoginAndEmail() -> (String, String) {
        return (nickname, email)
    }
    
    func getFavouritesFilms() -> [Int] {
        var ids: [Int] = []
        
        for elem in favouriteFilms {
            ids.append(elem.intValue)
        }
        return ids
    }
    
    func addFavouriteFilm(filmId: Int, user: User) {
        favouriteFilms.append(NSNumber(value: filmId))
        Auth.auth.saveCurrentUser(user: user)
    }
    
    func removeFavouriteFilm(filmId: Int, user: User) {
        favouriteFilms.remove(at: favouriteFilms.firstIndex(of: NSNumber(value: filmId))!)
        Auth().saveCurrentUser(user: user)
    }
    
    func dataEditing(tuple: (nickName: String, email: String, password: String)) {
        if tuple.nickName != "" {
            self.nickname = tuple.nickName
        }
        
        if tuple.email != "" {
            self.email = tuple.email
        }
        
        if tuple.password != "" {
            self.password = tuple.password
        }
    }
    
    func updateUserImage(data: Data) {
        userImage = data
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nickname, forKey: "nickname")
        coder.encode(email, forKey: "email")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
        coder.encode(favouriteFilms, forKey: "favouriteFilms")
        coder.encode(userImage, forKey: "userImage")
    }
    
    required init?(coder: NSCoder) {
        self.nickname = coder.decodeObject(forKey: "nickname") as? String ?? "nickname"
        self.email = coder.decodeObject(forKey: "email") as? String ?? "email"
        self.login = coder.decodeObject(forKey: "login") as? String ?? "login"
        self.password = coder.decodeObject(forKey: "password") as? String ?? "password"
        self.favouriteFilms = coder.decodeObject(forKey: "favouriteFilms") as? [NSNumber] ?? []
        self.userImage = (coder.decodeObject(forKey: "userImage") as? NSData) as? Data ?? Data()
    }
}
