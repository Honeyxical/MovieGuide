import UIKit

class User: NSObject, NSCoding {
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
