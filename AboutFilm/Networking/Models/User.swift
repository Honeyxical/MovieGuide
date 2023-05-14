import Foundation

protocol UserProtocol{
    var nickname: String {get set}
    var login: String {get set}
    var password: String {get set}
}

class User: NSObject, NSCoding, UserProtocol{
    var nickname: String
    var login: String
    var password: String
    
    init(nickname: String, login: String, password: String, userHash: Int) {
        self.nickname = nickname
        self.login = login
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nickname, forKey: "nickname")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        self.nickname = coder.decodeObject(forKey: "nickname") as! String
        self.login = coder.decodeObject(forKey: "login") as! String
        self.password = coder.decodeObject(forKey: "password") as! String
    }
}
