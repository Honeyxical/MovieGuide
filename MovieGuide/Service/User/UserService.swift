import Foundation

protocol UserServiceProtocol {
    var userStorage: DataBaseManager {get set}

    // Auth methods
    func getUserLoginAndEmail() -> (String, String)
    func registration(user: User) -> Bool
    func login(userLogin: String, userPassword: String) -> Bool
    func logout(user: User)
    func getCurrentUser(login: String, password: String) -> User

    // Films methods
    func getFavouritesFilms() -> [Int]
    func addFavouriteFilm(filmId: Int, user: User)
    func removeFavouriteFilm(filmId: Int, user: User)

    // Edit user profile methods
    func dataEditing(tuple: (nickName: String, email: String, password: String)) -> User
    func updateUserImage(data: Data)
}

class UserService: UserServiceProtocol {
    var userStorage: DataBaseManager
    var user: User

    init(userStotage: DataBaseManager, user: User) {
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

    func registration(user: User) -> Bool {
        if userStorage.getUserForKey(key: user.login) == nil {
            userStorage.saveNewUser(user: user)
            userStorage.saveCurrentUser(user: user)
            return true
        }
        return false
    }

    func logout(user: User) {
        userStorage.saveCurrentUser(user: user)
        userStorage.removeCurrentUser()
    }

    func getCurrentUser(login: String, password: String) -> User {
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

    func addFavouriteFilm(filmId: Int, user: User) {
        self.user.favouriteFilms.append(NSNumber(value: filmId))
        userStorage.saveCurrentUser(user: user)
    }

    func removeFavouriteFilm(filmId: Int, user: User) {
        self.user.favouriteFilms.remove(at: user.favouriteFilms.firstIndex(of: NSNumber(value: filmId))!)
        userStorage.saveCurrentUser(user: user)
    }

    // Edit user profile methods
    func dataEditing(tuple: (nickName: String, email: String, password: String)) -> User {
        if tuple.nickName != "" {
            user.nickname = tuple.nickName
        }

        if tuple.email != "" {
            user.email = tuple.email
        }

        if tuple.password != "" {
            user.password = tuple.password
        }
        return user
    }

    func updateUserImage(data: Data) {
        user.userImage = data
    }
}
