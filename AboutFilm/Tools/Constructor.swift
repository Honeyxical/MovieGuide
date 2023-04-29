import UIKit

func getMoviesArray(array: [SimilarMovies]) -> [UIView] {
    var resultArray: [UIView] = []
    
    for i in 0...array.count - 1 {
        resultArray.append(getMovie(filmTitle: array[i].enName ?? array[i].name!, filmType: array[i].type!))
    }
    return resultArray
}

func getRatingArray(rating: Rating) -> [UIView] {
    var resultArray: [UIView] = []
    
    if rating.kinopoisk != 0 {
        resultArray.append(getRating(rating: String(rating.kinopoisk!), nameRating: "Kinopoisk"))
    }
    if rating.imdb != 0 {
        resultArray.append(getRating(rating: String(rating.imdb!), nameRating: "IMDb"))
    }
    if rating.filmCritics != 0 {
        resultArray.append(getRating(rating: String(rating.filmCritics!), nameRating: "Film critics"))
    }
    if rating.russianFilmCritics != 0 {
        resultArray.append(getRating(rating: String(rating.russianFilmCritics!), nameRating: "Russian film critics"))
    }
    if rating.await != 0 {
        resultArray.append(getRating(rating: String(rating.await!), nameRating: "Await"))
    }
    
    return resultArray
}

func getAttributedString(mainText: String, secondaryText: String) -> NSMutableAttributedString {
    let attributedTextString = NSMutableAttributedString(string: mainText, attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
    attributedTextString.append(NSAttributedString(string: "\n" + secondaryText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .thin), NSAttributedString.Key.foregroundColor : UIColor.gray]))
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
    
    numLabel.text = rating
    numLabel.font = .boldSystemFont(ofSize: 30)
    numLabel.textAlignment = .center
    numLabel.backgroundColor = .mainGray
    numLabel.contentMode = .scaleAspectFit
    
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

private func getMovie(filmTitle: String, filmType: String) -> UIView {
    let container = UIView()
    let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
    let textView = UITextView()
    
    container.translatesAutoresizingMaskIntoConstraints = false
    image.translatesAutoresizingMaskIntoConstraints = false
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    container.addSubview(image)
    container.addSubview(textView)
    
    image.contentMode = .scaleToFill
    
    textView.attributedText = getAttributedString(mainText: filmTitle, secondaryText: filmType)
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = false
    textView.textContainer.maximumNumberOfLines = 4
    
    NSLayoutConstraint.activate([
        container.widthAnchor .constraint(equalToConstant: 150),
        
        image.topAnchor.constraint(equalTo: container.topAnchor),
        image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        image.heightAnchor.constraint(equalToConstant: 225),
        
        textView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
        textView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        textView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        textView.widthAnchor.constraint(equalToConstant: 150)
    ])
    
    return container
}

