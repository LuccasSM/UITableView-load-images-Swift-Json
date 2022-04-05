//
//  ViewTwo.swift
//  UITableView-load-images-Swift-Json
//
//  Created by Luccas Santana Marinho on 04/04/22.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ViewTwo: UIViewController {
    
    var hero: HeroStats?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        insertView()
        
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        
        image.downloaded(from: url!)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 25),
            button.heightAnchor.constraint(equalToConstant: 25),
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            image.widthAnchor.constraint(equalToConstant: 250),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.topAnchor.constraint(equalTo: self.button.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            label1.widthAnchor.constraint(equalToConstant: 200),
            label1.heightAnchor.constraint(equalToConstant: 50),
            label1.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10),
            label1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            label2.widthAnchor.constraint(equalToConstant: 200),
            label2.heightAnchor.constraint(equalToConstant: 50),
            label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 0),
            label2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            label3.widthAnchor.constraint(equalToConstant: 200),
            label3.heightAnchor.constraint(equalToConstant: 50),
            label3.topAnchor.constraint(equalTo: self.label2.bottomAnchor, constant: 0),
            label3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            label4.widthAnchor.constraint(equalToConstant: 200),
            label4.heightAnchor.constraint(equalToConstant: 50),
            label4.topAnchor.constraint(equalTo: self.label3.bottomAnchor, constant: 0),
            label4.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
        ])
    }
    
    func insertView() {
        self.view.addSubview(button)
        self.view.addSubview(image)
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
    }
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(returnButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label1: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = hero?.localized_name
        label.textColor = .white
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = hero?.primary_attr
        label.textColor = .white
        return label
    }()
    
    private lazy var label3: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = hero?.attack_type
        label.textColor = .white
        return label
    }()
    
    private lazy var label4: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\((hero?.legs)!)"
        label.textColor = .white
        return label
    }()
    
    @objc func returnButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
