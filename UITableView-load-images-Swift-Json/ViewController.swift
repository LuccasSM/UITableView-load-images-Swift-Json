//
//  ViewController.swift
//  UITableView-load-images-Swift-Json
//
//  Created by Luccas Santana Marinho on 04/04/22.
//

import UIKit

struct listData {
    var name: String
    var description: String
    var image: UIImage
}

class ViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView(frame: .zero)
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = true
        
        tv.register(TableViewCell.self, forCellReuseIdentifier: "listCell")
        
        return tv
    }()
    
    var heroes = [HeroStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupConstraint()
        
        downloadJSON {
            self.tableView.reloadData()
        }
    }

    @objc func viewTwoNavigation() {
        let viewController = ViewTwo()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    func setupConstraint() {
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewController = ViewTwo()
        viewController.hero = heroes[indexPath.row]
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
