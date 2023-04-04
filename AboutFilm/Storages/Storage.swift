import Foundation

protocol AuthProtocol{
    var users: UserDefaults {get set}
    
    func registration(user: UserProtocol) -> Bool
    func login(userLogin: String, userPassword: String) -> UserProtocol?
}

struct Auth: AuthProtocol{
    var users: UserDefaults = UserDefaults.standard
    
    func registration(user: UserProtocol) -> Bool {
        if users.object(forKey: user.login) == nil{
            guard let archivedUser = archiveObject(object: user) else { return false}
            users.set(archivedUser, forKey: user.login)
            return true
        }
        return false
    }
    
    func login(userLogin: String, userPassword: String) -> UserProtocol? {
        guard let userFromStorage = users.data(forKey: userLogin) else {
            return nil
        }
        let user = unarchiveObject(data: userFromStorage)
        if user.password == userPassword{
            return user
        }
        return nil
    }
    
    private func archiveObject(object: UserProtocol) -> Data?{
        let user = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        guard let user: Data = user else {
            return nil
        }
        return user
    }
    
    private func unarchiveObject(data: Data) -> UserProtocol{
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! UserProtocol
    }
}
