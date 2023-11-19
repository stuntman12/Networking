//
//  AddViewController.swift
//  collectionView
//
//  Created by Даниил on 18.11.2023.
//

import UIKit

class AddViewController: UIViewController {
    
    weak var delegate: NewWelcomViewControllerDelegate?

    private let titleTf = UITextField()
    private let urlTf = UITextField()
    
    private var save = UIBarButtonItem()
    
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
    }
    //MARK: - @obj action

    @objc
    func savePost() {
        let welcomAdd = WelcomeElement(
            title: titleTf.text ?? "No title",
            url: urlTf.text ?? "1",
            thumbnailUrl: "2332"
        )
        delegate?.sendPostRequest(with: welcomAdd)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Settings View
private extension AddViewController {
    func setupView() {
        addAction()
        addSubViews()
        setupLayout()
        setupStackView()
        setupTextField()
    }
}

//MARK: - Setting
private extension AddViewController {
    func addSubViews() {
        [stackView].forEach {
            subView in view.addSubview(subView)
        }
        
        navigationItem.rightBarButtonItem = save
    }
    
    func addAction() {
        save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePost))
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 50
        

        stackView.addArrangedSubview(titleTf)
        stackView.addArrangedSubview(urlTf)
    }
    
    func setupTextField() {
        let textFeild = [titleTf, urlTf]
        
        textFeild.forEach { feild in
            feild.borderStyle = .line
            feild.layer.borderWidth = 1       
        }

        titleTf.placeholder = "Название"
        urlTf.placeholder = "URL фото"
    }
}

//MARK: - Layout
private extension AddViewController {
    
    func setupLayout() {
        [stackView,
         titleTf,
         urlTf
        ].forEach {
            subView in subView.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // тут ширина стека зависит от
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)

        ])
    }
}

