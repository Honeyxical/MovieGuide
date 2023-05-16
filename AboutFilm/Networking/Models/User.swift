import Foundation

protocol UserProtocol{
    var nickname: String {get set}
    var login: String {get set}
    var password: String {get set}
    var favoriteFilms: [Int] {get set}
    var email: String {get set}
    }

class User: NSObject, NSCoding, UserProtocol{
    var nickname: String
    var email: String
    var login: String
    var password: String
    var favoriteFilms: [Int] = []

    
    init(nickname: String, email: String, login: String, password: String, userHash: Int) {
        self.nickname = nickname
        self.email = email
        self.login = login
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nickname, forKey: "nickname")
        coder.encode(email, forKey: "email")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        self.nickname = coder.decodeObject(forKey: "nickname") as! String
        self.email = coder.decodeObject(forKey: "email") as! String
        self.login = coder.decodeObject(forKey: "login") as! String
        self.password = coder.decodeObject(forKey: "password") as! String
    }
}
