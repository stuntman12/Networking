
import UIKit
import Alamofire

protocol NewWelcomViewControllerDelegate: AnyObject {
    func sendPostRequest(with data: WelcomeElement)
}

final class MainViewController: UIViewController {
    
    private lazy var collection = UICollectionView()
    private var addButton =  UIBarButtonItem()
    
    private var welcomsElement = [WelcomeElement]()
    private var networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupView()
        
    }
    //MARK: - setup collection

    func setupCollectionView() {
        collection = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "\(CollectionCell.self)")
        collection.dataSource = self
        collection.delegate = self
    }
    
    //MARK: - setup flow layout

    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 40
        layout.sectionInset = .init(top: 10, left: 30, bottom: 10, right: 30)
        return layout
    }
    //MARK: - @obj action

    @objc
    func add() {
        let addVC = AddViewController()
        addVC.delegate = self
        addVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addVC, animated: true)
    }
}

//MARK: - Setting View
private extension MainViewController {
    func setupView() {
        addAction()
        setupNav()
        addSubView()
        setupLayout()
        fetchData()
        
        
    }
}

//MARK: - Setting
private extension MainViewController {
    func addSubView() {
        [collection].forEach { view in
            self.view.addSubview(view)
        }
        navigationItem.rightBarButtonItem = addButton
    }
    
    func addAction() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    func setupNav() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Home"
    }
    
}

//MARK: - Layout
private extension MainViewController {
    
    func setupLayout() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - NETWORK

private extension MainViewController {
    
    func fetchData() {
        let id = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        var element = [WelcomeElement]()
        let group = DispatchGroup()
        
        id.forEach {
            group.enter()
            networkManager.fetch(id: $0) { welcom in
                switch welcom {
                case .success(let welcom):
                    element.append(welcom)
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.welcomsElement = element
                self.collection.reloadData()
            }
            
        }
    }
}

//MARK: - Datasourse


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        welcomsElement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "\(CollectionCell.self)",
            for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        
        let oneElement = welcomsElement[indexPath.item]
        cell.configur(with: oneElement)
        return cell
    }
}

//MARK: - Delegat

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoVC = InfoViewController()
        let welcom = welcomsElement[indexPath.item]
        
        infoVC.configur(with: welcom)
        
        navigationController?.pushViewController(infoVC, animated: true)
    }
}

//MARK: - NewWelcomViewControllerDelegate

extension MainViewController: NewWelcomViewControllerDelegate {
    func sendPostRequest(with data: WelcomeElement) {
        
        networkManager.sendPost(to: Link.post.url, width: data) { [unowned self] result in
            switch result {
            case .success(let element):
                welcomsElement.append(element)
                print(welcomsElement)
                let newIndexPath = IndexPath(item: welcomsElement.count - 1, section: 0)
                collection.insertItems(at: [newIndexPath])
                collection.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


