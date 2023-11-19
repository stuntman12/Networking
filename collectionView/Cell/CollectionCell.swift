import UIKit
import Alamofire

final class CollectionCell: UICollectionViewCell {
    
    private let nameLabel = UILabel()
    private let photoView = UIImageView()
    
    private let networkManager = NetworkManager.shared
    
    private let height: CGFloat = 150
    private let wight: CGFloat = 150
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configur(with welcom: WelcomeElement) {
        nameLabel.text = welcom.title
        
        networkManager.loadImage(for: welcom.url) { response in
            switch response {
            case .success(let imageData):
                self.photoView.image = UIImage(data: imageData)
            case .failure(_):
                print("Не удалось")
            }
        }
        
    }
}

//MARK: - Setting sell
private extension CollectionCell {
    func setupCell() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(photoView)
        
        [photoView,nameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        photoView.contentMode = .scaleAspectFit
        
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = height / 2
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.heightAnchor.constraint(equalToConstant: height),
            photoView.widthAnchor.constraint(equalToConstant: wight),
            
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalTo: photoView.heightAnchor, multiplier: 0.3),
            nameLabel.widthAnchor.constraint(equalToConstant: height)
        ])
        
    }
    
}

