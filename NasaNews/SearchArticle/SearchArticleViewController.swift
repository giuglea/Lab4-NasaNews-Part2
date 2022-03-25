//
//  SearchArticleViewController.swift
//  NasaNews
//
//  Created by Tzy on 25.03.2022.
//

import UIKit

//MVP
// FACADE

// singleton

// colletionview


final class SearchArticleViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField?
    @IBOutlet var tableView: UITableView?
    
    @IBOutlet weak var toAnimateView: UIView!
    private var model: [RatingEntity] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllModels()
    }
    @IBAction func animate(_ sender: UIButton) {
        toAnimateView.sizeTransform()
    }
    
    private func configure() {
        searchTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SearchArticleTableViewCell.self, forCellReuseIdentifier: SearchArticleTableViewCell.cellId)
    }
    
    private func getAllModels(searchString: String = String()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = RatingEntity.fetchRequest()
        if !searchString.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", searchString)
        }
        
        do {
            model = try managedContext.fetch(fetchRequest)
        } catch {
            print("here::", error.localizedDescription)
        }
    }
    
    @objc
    private func textFieldDidChange() {
        let searchString = searchTextField?.text ?? String()
        getAllModels(searchString: searchString)
    }
    private func navigate(item: Item) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController")
                as? ArticleViewController else { return }
        viewController.item = item
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension SearchArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchArticleTableViewCell.cellId, for: indexPath)
                as? SearchArticleTableViewCell else { return UITableViewCell() }
        let cellModel = model[indexPath.row]
        cell.setup(ratingEntity: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = model[indexPath.row]
        
        let item = Item(title: model.name ?? String(),
                        date: "",
                        body: model.body ?? String(),
                        itemName: "")
        
        navigate(item: item)
    }
    
    
}


extension UIView {
    func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        self.layer.add(rotation, forKey: "rotateAnimation")
        
    }
    
    func sizeTransform() {
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.5
        self.layer.add(animation, forKey: "sclaeAnimation")
    }
}
