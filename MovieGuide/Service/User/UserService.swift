import Foundation

protocol UserServiceProtocol {
    var userStorage: UserStorageProtocol {get set}

    // Auth methods
    func getUserLoginAndEmail() -> (String, String)
    func registration(user: UserProtocol) -> Bool
    func login(userLogin: String, userPassword: String) -> Bool
    func logout(user: UserProtocol)
    func getCurrentUser(login: String, password: String) -> UserProtocol

    // Films methods
    func getFavouritesFilms() -> [Int]
    func addFavouriteFilm(filmId: Int, user: UserProtocol)
    func removeFavouriteFilm(filmId: Int, user: UserProtocol)

    // Edit user profile methods
    func dataEditing(tuple: (nickName: String, email: String, password: String))
    func updateUserImage(data: Data)
}

class UserService: UserServiceProtocol {
    var userStorage: UserStorageProtocol
    var user: UserProtocol

    init(userStotage: UserStorageProtocol, user: UserProtocol) {
        self.userStorage = userStotage
        self.user = user
    }

    // Auth methods
    func getUserLoginAndEmail() -> (String, String) {
        return (user.nickname, user.email)
    }

    func login(userLogin: String, userPassword: String) -> Bool {
        guard let userFromStorage = userStorage.getUserForKey(key: userLogin) else {return false}
        if userFromStorage.password == userPassword {
            userStorage.saveCurrentUser(user: userFromStorage)
            return true
        }
        return false
    }

    func registration(user: UserProtocol) -> Bool {
        if userStorage.getUserForKey(key: user.login) == nil {
            userStorage.saveNewUser(user: user)
            userStorage.saveCurrentUser(user: user)
            return true
        }
        return false
    }

    func logout(user: UserProtocol) {
        userStorage.saveCurrentUser(user: user)
        userStorage.removeCurrentUser()
    }

    func getCurrentUser(login: String, password: String) -> UserProtocol {
        return userStorage.getCurrentUser()
    }

    // Films methods
    func getFavouritesFilms() -> [Int] {
        var ids: [Int] = []

        for elem in user.favouriteFilms {
            ids.append(elem.intValue)
        }
        return ids
    }

    func addFavouriteFilm(filmId: Int, user: UserProtocol) {
        self.user.favouriteFilms.append(NSNumber(value: filmId))
        userStorage.saveCurrentUser(user: user)
    }

    func removeFavouriteFilm(filmId: Int, user: UserProtocol) {
        self.user.favouriteFilms.remove(at: user.favouriteFilms.firstIndex(of: NSNumber(value: filmId))!)
        userStorage.saveCurrentUser(user: user)
    }

    // Edit user profile methods
    func dataEditing(tuple: (nickName: String, email: String, password: String)) {
        if tuple.nickName != "" {
            user.nickname = tuple.nickName
        }

        if tuple.email != "" {
            user.email = tuple.email
        }

        if tuple.password != "" {
            user.password = tuple.password
        }
    }

    func updateUserImage(data: Data) {
        user.userImage = data
    }
}
