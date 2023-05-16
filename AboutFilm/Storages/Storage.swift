import Foundation

protocol AuthProtocol{
    var users: UserDefaults {get set}
    
    func registration(user: User) -> Bool
    func login(userLogin: String, userPassword: String) -> User?
}

struct Auth: AuthProtocol{
    static let auth = Auth()
    
    internal var users: UserDefaults = UserDefaults.standard
    
    func registration(user: User) -> Bool {
        if users.object(forKey: user.login) == nil{
            guard let archivedUser = archiveObject(object: user) else { return false}
            users.set(archivedUser, forKey: user.login)
            setCurrentUser(user: user)
            return true
        }
        return false
    }
    
    func login(userLogin: String, userPassword: String) -> User? {
        guard let userFromStorage = users.data(forKey: userLogin) else {
            return nil
        }
        let user = unarchiveObject(data: userFromStorage)
        if user.password == userPassword{
            setCurrentUser(user: user)
            return user
        }
        return nil
    }
    
    func saveCurrentUser(user: User) {
        print("saving \(user)")
        users.set(nil, forKey: "currentUser")
        users.set(archiveObject(object: user), forKey: "currentUser")
        users.set(archiveObject(object: user), forKey: user.login)
        
    }
    
    func getCurrentUser() -> User? {
        guard let currentUser = users.data(forKey: "currentUser") else { return nil }
        return unarchiveObject(data: currentUser)
    }
    
    private func setCurrentUser(user: User){
        print(user)
        users.set(archiveObject(object: user), forKey: "currentUser")
    }
    
    private func archiveObject(object: User) -> Data?{
        let user = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        guard let user: Data = user else {
            return nil
        }
        return user
    }
    
    private func unarchiveObject(data: Data) -> User{
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! User
    }
}
