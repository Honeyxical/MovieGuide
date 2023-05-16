import Foundation

protocol AuthProtocol{
    var users: UserDefaults {get set}
    
    func registration(user: UserProtocol) -> Bool
    func login(userLogin: String, userPassword: String) -> UserProtocol?
}

struct Auth: AuthProtocol{
    static let auth = Auth()
    
    internal var users: UserDefaults = UserDefaults.standard
    
    func registration(user: UserProtocol) -> Bool {
        if users.object(forKey: user.login) == nil{
            guard let archivedUser = archiveObject(object: user) else { return false}
            users.set(archivedUser, forKey: user.login)
            setCurrentUser(login: user.login)
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
            setCurrentUser(login: user.login)
            return user
        }
        return nil
    }
    
    func getCurrentUser() -> UserProtocol? {
        guard let userLogin = users.string(forKey: "currentUser") else { return nil } // получение логина текущего юзера
        guard let currentUser = users.data(forKey: userLogin) else { return nil }
        return unarchiveObject(data: currentUser)
    }
    
    private func getUserHash() -> Data?{
        guard let currentUserHash = users.data(forKey: "currentUser") else {
            return nil
        }
        return currentUserHash
    }
    
    private func setCurrentUser(login: String){
        users.set(login, forKey: "currentUser")
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
