import UIKit
final class InfoViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private let buttonBack = UIButton()
    private let imageOne = UIImageView()
    private let labelOne = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
    }

    //MARK: - @obj action
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Configur cell
    
    func configur(with welcom: WelcomeElement) {
        
        self.labelOne.text = welcom.title
        
        networkManager.loadImage(for: welcom.url) { response in
            switch response {
            case .success(let imageData):
                self.imageOne.image = UIImage(data: imageData)
            case .failure(_):
                print("Не удалось")
            }
        }
    }
}
    
    //MARK: - Setup
    
    private extension InfoViewController {
        func setup() {
            setupView()
            setupLayout()
            addAction()
        }
    }

    //MARK: - Settings View
    
    private extension InfoViewController {
        func setupView() {
            
            buttonBack.setTitle("Back", for: .normal)
            buttonBack.backgroundColor = .systemBlue
            buttonBack.layer.cornerRadius = 15
            labelOne.numberOfLines = 0
            labelOne.font = UIFont.systemFont(ofSize: 30)
            labelOne.textAlignment = .center
        }
        
        func addAction() {
            buttonBack.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
    }

    
    
    //MARK: - Setup layout
    
    private extension InfoViewController {
        func setupLayout() {
            
            [buttonBack, imageOne, labelOne].forEach { view in
                self.view.addSubview(view)
            }
            
            [buttonBack, imageOne, labelOne].forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
                buttonBack.widthAnchor.constraint(equalToConstant: 250),
                buttonBack.heightAnchor.constraint(equalToConstant: 50),
                buttonBack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                buttonBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                imageOne.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
                imageOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                imageOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                imageOne.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
                
                labelOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelOne.topAnchor.constraint(equalTo: imageOne.bottomAnchor, constant: 10),
                labelOne.widthAnchor.constraint(equalTo: imageOne.widthAnchor),
                labelOne.heightAnchor.constraint(equalTo: imageOne.heightAnchor, multiplier: 0.6)
            ])
            
        }
    }


