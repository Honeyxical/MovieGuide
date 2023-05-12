import Foundation

protocol UserProtocol{
    var nickname: String {get set}
    var login: String {get set}
    var password: String {get set}
    var xash: Int {get set}
    
}

class User: NSObject, NSCoding, UserProtocol{
    var nickname: String
    var login: String
    var password: String
    var xash: Int
    
    init(nickname: String, login: String, password: String) {
        self.nickname = nickname
        self.login = login
        self.password = password
        self.xash = self.hashValue
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nickname, forKey: "nickname")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
        coder.encode(xash, forKey: "hash")
    }
    
    required init?(coder: NSCoder) {
        self.nickname = coder.decodeObject(forKey: "nickname") as! String
        self.login = coder.decodeObject(forKey: "login") as! String
        self.password = coder.decodeObject(forKey: "password") as! String
        self.xash = coder.decodeObject(forKey: "hash") as! Int
    }
}
