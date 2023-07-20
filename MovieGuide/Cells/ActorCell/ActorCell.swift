import UIKit
import Kingfisher

class ActorCell: UICollectionViewCell {

    var person: Person?

    private let photoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()

    private let nameTextView: UITextView = {
        let textView = UITextView()

        let attributedString = NSMutableAttributedString(string: "Jastin Royland", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributedString.append(NSAttributedString(string: "\nRick Sanchez / Morty Sanchez", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .thin),
            NSAttributedString.Key.foregroundColor: UIColor.gray]))

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedText = attributedString
        textView.textContainer.maximumNumberOfLines = 3
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }

    private func setData() {
        guard let unwrPerson = person else {
            return
        }
        let attributedString = NSMutableAttributedString(string: (unwrPerson.enName ?? unwrPerson.name)!,
                                                         attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributedString.append(NSAttributedString(string: "\n" + (unwrPerson.enProfession ?? unwrPerson.profession)!,
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .thin), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        nameTextView.attributedText = attributedString
        getImage()
    }

    func setupLayout() {
        addSubview(photoImageView)
        addSubview(nameTextView)
        setData()

        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            nameTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTextView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActorCell {
    func getImage() {
        guard let photoUrl = person?.photo else { return }
        photoImageView.kf.setImage(with: URL(string: photoUrl))
    }
}
