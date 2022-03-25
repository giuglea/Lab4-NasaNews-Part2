//
//  ArticleViewController.swift
//  NasaNews
//
//  Created by Tzy on 18.03.2022.
//

import UIKit
import WebKit
import CoreData

final class ArticleViewController: UIViewController {
    
    var item: Item?
    
    
    var rating: Int = 0
    
    @IBOutlet var webView: WKWebView?
    
    @IBOutlet weak var starButton1: UIButton!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var starButton3: UIButton!
    @IBOutlet weak var starButton4: UIButton!
    @IBOutlet weak var starButton5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        guard let item = item else {
            return
        }

        title = item.title
        webView?.loadHTMLString(item.body, baseURL: nil)
        configureStars()
    }
    
    private func configureStars() {
        starButton1.tag = 1
        starButton2.tag = 2
        starButton3.tag = 3
        starButton4.tag = 4
        starButton5.tag = 5
    }
    
    @IBAction func didRateArticle(_ sender: UIButton) {
        rating = sender.tag
        addRating()
    }
    
    
    
    private func addRating() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "RatingEntity", in: managedContext),
        let item = item else { return }
        let ratingEntity = RatingEntity(entity: entity, insertInto: managedContext)
        ratingEntity.rating = Int64(rating)
        ratingEntity.name = item.title
        ratingEntity.body = item.body
        
        do {
            try managedContext.save()
            print("here:: Saved!")
        } catch {
            print("here::", error.localizedDescription)
        }
    }
    
}


