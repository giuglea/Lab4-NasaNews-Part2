//
//  ViewController.swift
//  NasaNews
//
//  Created by Tzy on 18.03.2022.
//

import UIKit

final class NasaViewController: UIViewController {
    
    private var model = NasaNewsModel()
    private let pageSize: Int = 10
    private var page: Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestItems()
        // Do any additional setup after loading the view.
    }
    
    private func requestItems() {
        let pathString = "https://mars.nasa.gov/api/v1/news_items/?page=\(page)&per_page=\(pageSize)&order=publish_date+desc,created_at+desc"
        let url = URL(string: pathString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let _ = error {
                return
            }

            let jsonDecoder = JSONDecoder()
            guard let data = data,
                  let welf = self else { return }

            guard let items = try? jsonDecoder.decode(NasaNewsModel.self, from: data) else { return }
            welf.model.items.append(contentsOf: items.items)

            DispatchQueue.main.async {
                welf.tableView.reloadData()
            }
        }

        task.resume()
    }
    
    private func requestNewItems() {
        page += 1
        requestItems()
    }
    
    private func configure() {
        title = "Nasa News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NasaNewTableViewCell.self, forCellReuseIdentifier: NasaNewTableViewCell.cellId)
    }
    
    private func navigate(item: Item) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController")
                as? ArticleViewController else { return }
        viewController.item = item
        navigationController?.pushViewController(viewController, animated: true)
    }


}


extension NasaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaNewTableViewCell.cellId, for: indexPath)
                as? NasaNewTableViewCell else { return  UITableViewCell() }
        
        let cellModel = model.items[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = model.items[indexPath.row]
        navigate(item: item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = model.items.count - 1
        if indexPath.row == count {
            requestNewItems()
        }
    }
    
}

