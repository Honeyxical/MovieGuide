import UIKit

class EditController: UIViewController {
    let user: User
    let userService: UserServiceProtocol

    init(user: User, userService: UserServiceProtocol) {
        self.user = user
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(nil, action: #selector(backButtonHandler), for: .touchUpInside)
        
        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Edit profile"
        title.textColor = .black
        
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    @objc private func backButtonHandler() {
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(data: user.userImage))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.clipsToBounds = true
        return image
    }()
    
    private let imagePickerBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .lightGray.withAlphaComponent(0.1)
        btn.addTarget(nil, action: #selector(imagePickerHandler), for: .touchUpInside)
        btn.layer.cornerRadius = 100
        btn.setImage(UIImage(named: "Upload"), for: .normal)
        return btn
    }()
    
    @objc private func imagePickerHandler() {
        showImagePickerOptions()
    }
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePickerOptions() {
        let alertVC = UIAlertController(title: "Pick a photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ [weak self] (_) in
            guard let self = self else {
                return
            }
            
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            self.present(cameraImagePicker, animated: true){
                cameraImagePicker.delegate = self
            }
        }
        
        let libraryPicker = UIAlertAction(title: "Library", style: .default){ [weak self] (_) in
            guard let self = self else {
                return
            }
            
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            self.present(libraryImagePicker, animated: true){
                libraryImagePicker.delegate = self
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryPicker)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
    
    private lazy var editNicknameField = getField(placeholder: "Nickname")
    
    private lazy var editEmailField = getField(placeholder: "Email")
    
    private lazy var editPasswordField = getField(placeholder: "Password")
   
    private lazy var repeatPasswordField = getField(placeholder: "Repeat password")
    
    private lazy var stackFiled: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [editNicknameField, editEmailField, editPasswordField, repeatPasswordField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }()
    
    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.addTarget(nil, action: #selector(saveHandler), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    @objc private func saveHandler() {
        if editPasswordField.text == repeatPasswordField.text || (editPasswordField.text == "" && repeatPasswordField.text == "") {
            let editedUser = userService.dataEditing(tuple: (nickName: editNicknameField.text!, email: editEmailField.text!, password: editPasswordField.text!))
            userService.userStorage.saveCurrentUser(user: editedUser)
            navigationController?.popViewController(animated: true)
        } else {
            self.present(getAllert(message: "Passwords don't match "), animated: true)
        }
    }
    
    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cancel", for: .normal)
        btn.addTarget(nil, action: #selector(backButtonHandler), for: .touchUpInside)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1.5
        btn.layer.cornerRadius = 30
        btn.tintColor = .black
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(image)
        view.addSubview(imagePickerBtn)
        view.addSubview(stackFiled)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),
            
            image.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            imagePickerBtn.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            imagePickerBtn.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            imagePickerBtn.heightAnchor.constraint(equalToConstant: 200),
            imagePickerBtn.widthAnchor.constraint(equalToConstant: 200),
            
            stackFiled.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
            stackFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cancelButton.heightAnchor.constraint(equalToConstant: 70),
            cancelButton.widthAnchor.constraint(equalToConstant: 170),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 70),
            saveButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func getField(placeholder: String) -> UITextField{
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 15
        let textPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textField.leftView = textPaddingView
        textField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        
        return textField
    }
}

extension EditController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.image.image = image
        if let imagePng = image.pngData(){
            userService.updateUserImage(data: imagePng)
        }
        self.dismiss(animated: true)
    }
}
