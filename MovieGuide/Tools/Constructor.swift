import UIKit

func getRatingArray(rating: Rating) -> [UIView] {
    var resultArray: [UIView] = []

    if rating.kp != nil, rating.kp != 0 {
        resultArray.append(getRating(rating: String(rating.kp!), nameRating: "Kinopoisk"))
    }
    if rating.imdb != nil, rating.imdb != 0 {
        resultArray.append(getRating(rating: String(rating.imdb!), nameRating: "IMDb"))
    }
    if rating.filmCritics != nil, rating.filmCritics != 0 {
        resultArray.append(getRating(rating: String(rating.filmCritics!), nameRating: "Film critics"))
    }
    if rating.russianFilmCritics != nil, rating.russianFilmCritics != 0 {
        resultArray.append(getRating(rating: String(rating.russianFilmCritics!), nameRating: "Russian film critics"))
    }
    if rating.await != nil, rating.await != 0 {
        resultArray.append(getRating(rating: String(rating.await!), nameRating: "Await"))
    }

    return resultArray
}

func getAttributedString(mainText: String, secondaryText: String) -> NSMutableAttributedString {
    let attributedTextString = NSMutableAttributedString(string: mainText, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
    attributedTextString.append(NSAttributedString(string: "\n" + secondaryText,
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .thin), NSAttributedString.Key.foregroundColor: UIColor.gray]))
    return attributedTextString
}

private func getRating(rating: String, nameRating: String) -> UIView {
    let container = UIView()
    let numLabel = UILabel()
    let descLabel = UILabel()

    container.addSubview(numLabel)
    container.addSubview(descLabel)

    container.translatesAutoresizingMaskIntoConstraints = false
    numLabel.translatesAutoresizingMaskIntoConstraints = false
    descLabel.translatesAutoresizingMaskIntoConstraints = false

    numLabel.text = String(rating.prefix(4))
    numLabel.font = .boldSystemFont(ofSize: 30)
    numLabel.textAlignment = .center
    numLabel.backgroundColor = .mainGray

    descLabel.text = nameRating
    descLabel.font = .systemFont(ofSize: 18)
    descLabel.numberOfLines = 2
    descLabel.backgroundColor = .mainGray

    NSLayoutConstraint.activate([
        container.widthAnchor.constraint(equalToConstant: 230),

        numLabel.topAnchor.constraint(equalTo: container.topAnchor),
        numLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        numLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        numLabel.widthAnchor.constraint(equalToConstant: 100),

        descLabel.topAnchor.constraint(equalTo: container.topAnchor),
        descLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor),
        descLabel.widthAnchor.constraint(equalToConstant: 130),
        descLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
    return container
}
