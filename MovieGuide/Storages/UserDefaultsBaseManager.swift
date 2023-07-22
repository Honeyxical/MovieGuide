import Foundation

protocol DataBaseManager {

    func getUserForKey(key: String) -> User?
    func saveCurrentUser(user: User)
    func saveNewUser(user: User)
    func removeCurrentUser()
    func getCurrentUser() -> User
}

struct UserDefaultsBaseManager: DataBaseManager {
    internal var users: UserDefaults = UserDefaults.standard

    func getUserForKey(key: String) -> User? {
        if let userFromStorage = users.data(forKey: key) {
            guard let user = unarchiveObject(data: userFromStorage) else { return nil }
            return user
        }
        return nil
    }

    func saveCurrentUser(user: User) {
        users.set(archiveObject(object: user), forKey: "currentUser")
        users.set(archiveObject(object: user), forKey: user.login)
    }
    
    func getCurrentUser() -> User {
        if let currentUser = users.data(forKey: "currentUser") {
            if let user = unarchiveObject(data: currentUser){
                return user
            }
        }
        return User(nickname: "", email: "", login: "", password: "", userHash: 0)
    }

    func saveNewUser(user: User) {
        guard let archivedUser = archiveObject(object: user) else { return }
        users.set(archivedUser, forKey: user.login)
    }

    func removeCurrentUser() {
        users.set(nil, forKey: "currentUser")
    }
    
    private func archiveObject(object: User) -> Data? {
        let user = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        guard let user: Data = user else {
            return nil
        }
        return user
    }
    
    private func unarchiveObject(data: Data) -> User? {
        try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User
    }
}
