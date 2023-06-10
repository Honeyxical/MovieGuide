import UIKit

class ActorCell: UICollectionViewCell {
    
    var person: Person? {
        didSet{
            guard let unwrPerson = person else {
                return
            }
            
            let attributedString = NSMutableAttributedString(string: (unwrPerson.enName ?? unwrPerson.name)!, attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
            
            attributedString.append(NSAttributedString(string: "\n" + (unwrPerson.enProfession ?? unwrPerson.profession)!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .thin), NSAttributedString.Key.foregroundColor : UIColor.gray]))
            
            nameTextView.attributedText = attributedString
            getImage()
        }
    }
    
    private let photoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: "Jastin Royland", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributedString.append(NSAttributedString(string: "\nRick Sanchez / Morty Sanchez", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .thin),
            NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
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
        
        URLCache.shared = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024)
    }
    
    private func setupLayout() {
        addSubview(photoImageView)
        addSubview(nameTextView)
        
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
    func getImage(){
        guard let photoUrl = person?.photo else { return }
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: photoUrl)!)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [self] in
                photoImageView.image = image
            }
        }.resume()
    }
}

