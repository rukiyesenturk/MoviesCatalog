//
//  FavoritesViewController.swift
//  MoviesCatalog
//
//  Created by Macbook on 12.03.2022.
//

import UIKit
import Firebase
import Kingfisher

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
 
    @IBOutlet weak var tableView: UITableView!
    var postDizisi = [FavoritePost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseGetData()
    }
    func firebaseGetData(){
        let firesoreDatabase = Firestore.firestore()
        firesoreDatabase.collection("FavoritePost").addSnapshotListener{(snapshot, error) in
            if error != nil{
                print (error?.localizedDescription as Any)
            } else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                       
                        if let imageUrl = document.get("imageUrl") as? String{
                            if let moviesName = document.get("moviesName") as? String{
                                let post  = FavoritePost(moviesName: moviesName, imageUrl: imageUrl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCell
        cell.movieNameLabel.text = postDizisi[indexPath.row].moviesName
        cell.imageFavorite.kf.setImage(with: URL(string: self.postDizisi[indexPath.row].imageUrl)
)
        return cell
    }
}
