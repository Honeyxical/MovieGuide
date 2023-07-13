import Foundation

protocol UserStorageProtocol {

    func getUserForKey(key: String) -> UserProtocol?
    func saveCurrentUser(user: UserProtocol)
    func saveNewUser(user: UserProtocol)
    func removeCurrentUser()
    func getCurrentUser() -> UserProtocol
}

struct UserStorage: UserStorageProtocol {
    internal var users: UserDefaults = UserDefaults.standard

    func getUserForKey(key: String) -> UserProtocol? {
        if let userFromStorage = users.data(forKey: key) {
            guard let user = unarchiveObject(data: userFromStorage) else { return nil }
            return user
        }
        return nil
    }

    func saveCurrentUser(user: UserProtocol) {
        users.set(archiveObject(object: user), forKey: "currentUser")
        users.set(archiveObject(object: user), forKey: user.login)
    }
    
    func getCurrentUser() -> UserProtocol {
        if let currentUser = users.data(forKey: "currentUser") {
            if let user = unarchiveObject(data: currentUser){
                return user
            }
        }
        return User(nickname: "", email: "", login: "", password: "", userHash: 0)
    }

    func saveNewUser(user: UserProtocol) {
        guard let archivedUser = archiveObject(object: user) else { return }
        users.set(archivedUser, forKey: user.login)
    }

    func removeCurrentUser() {
        users.set(nil, forKey: "currentUser")
    }
    
    private func archiveObject(object: UserProtocol) -> Data? {
        let user = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        guard let user: Data = user else {
            return nil
        }
        return user
    }
    
    private func unarchiveObject(data: Data) -> User? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User
    }
}
