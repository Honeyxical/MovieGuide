import Foundation

//func getMocksForFilmsList() -> [Docs]{
//    return [Docs(id: 191654, name: "Title film", shortDescription: "Some short description | Some short description | Some short description | ", description: " Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description |", poster: nil, genres: [Generes(name: "Dramma")], rating: Rating(kinopoisk: nil, imdb: 4.8, filmCritics: nil, russianFilmCritics: nil, await: nil), type: "Film", year: 1992, movieLength: 182)]
//}
//
//func getMocksForFilmDescription() -> Docs{
//    return Docs(id: 191654, name: "Title film", shortDescription: "Some short description | Some short description | Some short description | ", description: "Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description | Some long description |", poster: nil, genres: [Generes(name: "Dramma")], rating: Rating(kinopoisk: nil, imdb: 4.8, filmCritics: nil, russianFilmCritics: nil, await: nil), type: "Film", year: 1992, movieLength: 182)
//}

func getFilmMocks() -> FilmFullInfo{
    return FilmFullInfo(id: 685246,
                        name: "Рик и морти",
                        alternativeName: "Rick and Morty",
                        enName: "Rick and Morty",
                        description: "В центре сюжета - школьник по имени Морти и его дедушка Рик. Морти - самый обычный мальчик, который ничем не отличается от своих сверстников. А вот его дедуля занимается необычными научными исследованиями и зачастую полностью неадекватен. Он может в любое время дня и ночи схватить внука и отправиться вместе с ним в безумные приключения с помощью построенной из разного хлама летающей тарелки, которая способна перемещаться сквозь межпространственный тоннель. Каждый раз эта парочка оказывается в самых неожиданных местах и самых нелепых ситуациях.",
                        shortDescription: "Гениальный ученый втягивает внука в безумные авантюры. Выдающийся анимационный сериал Дэна Хармона",
                        slogan: "Science makes sense, family doesn't.",
                        year: 2013,
                        ageRating: 18,
                        movieLength: 23,
                        rating: Rating(kinopoisk: 8.983,
                                       imdb: 9.1,
                                       filmCritics: 0,
                                       russianFilmCritics: 87.5,
                                       await: 0),
                        genres: [
                            Generes(name: "мультфильм"),
                            Generes(name: "комедия"),
                            Generes(name: "фантастика"),
                            Generes(name: "приключения")
                        ],
                        countries: [Countries(name: "США")],
                        persons: [
                            Person(id: 1305967,
                                    photo: "https://st.kp.yandex.net/images/actor_iphone/iphone360_1305967.jpg",
                                    name: "Джастин Ройланд",
                                    enName: "Justin Roiland",
                                    profession: "актеры",
                                    enProfession: "actor"),
                            Person(id: 31778,
                                    photo: "https://st.kp.yandex.net/images/actor_iphone/iphone360_31778.jpg",
                                    name: "Крис Парнелл",
                                    enName: "Chris Parnell",
                                    profession:  "актеры",
                                    enProfession: "actor"),
                            Person(id: 547725,
                                    photo: "https://st.kp.yandex.net/images/actor_iphone/iphone360_547725.jpg",
                                    name: "Спенсер Грэммер",
                                    enName: "Spencer Grammer",
                                    profession: "актеры",
                                    enProfession: "actor"),
                            Person(id: 53538,
                                    photo: "https://st.kp.yandex.net/images/actor_iphone/iphone360_53538.jpg",
                                    name: "Сара Чок",
                                    enName: "Sarah Chalke",
                                    profession: "актеры",
                                    enProfession: "actor"),
                            Person(id: 229539,
                                    photo: "https://st.kp.yandex.net/images/actor_iphone/iphone360_229539.jpg",
                                    name: "Кари Уолгрен",
                                    enName: "Kari Wahlgren",
                                    profession: "актеры",
                                    enProfession: "actor")
                        ],
                        similarMovies: [
                            SimilarMovies(id: 591929,
                                          name: "Гравити Фолз",
                                          enName: nil,
                                          alternativeName: "Gravity Falls",
                                          type: "animated-series",
                                          poster: Poster(url: "https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/04954219-061a-4646-a7d6-054fdc34b053/orig",
                                                         previewUrl: "https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/04954219-061a-4646-a7d6-054fdc34b053/x1000")),
                            SimilarMovies(id: 79920,
                                          name: "Футурама",
                                          enName: "Futurama",
                                          alternativeName: "Futurama",
                                          type: "animated-series",
                                          poster: Poster(url: "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/44e4b345-2500-48f9-aaf1-b7e7918279d6/orig",
                                                         previewUrl: "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/44e4b345-2500-48f9-aaf1-b7e7918279d6/x1000")),
                            SimilarMovies(id: 476,
                                          name: "Назад в будущее",
                                          enName: "Back to the Future",
                                          alternativeName: "Back to the Future",
                                          type: "movie",
                                          poster: Poster(url: "https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/73cf2ed0-fd52-47a2-9e26-74104360786a/orig",
                                                         previewUrl: "https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/73cf2ed0-fd52-47a2-9e26-74104360786a/x1000")),
                            SimilarMovies(id: 602284,
                                          name: "Время приключений",
                                          enName: "Adventure Time with Finn & Jake",
                                          alternativeName: "Adventure Time with Finn & Jake",
                                          type: "animated-series",
                                          poster: Poster(url: "https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/8997def3-7896-48c4-85db-b600eca3f983/orig",
                                                         previewUrl: "https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/8997def3-7896-48c4-85db-b600eca3f983/x1000"))
                        ],
                        logo: Logo(url: "https://avatars.mds.yandex.net/get-ott/1672343/2a0000017e4094aa8e5de73d2e865255c24d/orig"))
}
