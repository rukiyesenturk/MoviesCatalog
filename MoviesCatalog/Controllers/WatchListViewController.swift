//
//  WatchListViewController.swift
//  MoviesCatalog
//
//  Created by Macbook on 12.03.2022.
//

import UIKit
import Firebase
import Kingfisher

class WatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var postDizisi = [WatchPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseGetData()
    }
    func firebaseGetData(){
        let firesoreDatabase = Firestore.firestore()
        firesoreDatabase.collection("WatchPost").addSnapshotListener{(snapshot, error) in
            if error != nil{
                print (error?.localizedDescription as Any)
            } else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.postDizisi.removeAll(keepingCapacity: false)//clear
                    
                    for document in snapshot!.documents {
                        
                        if let imageUrl = document.get("imageUrl") as? String{
                            if let moviesName = document.get("moviesName") as? String{
                            let post  = WatchPost(moviesName: moviesName, imageUrl: imageUrl)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCell", for: indexPath) as! WatchCell
        cell.movieNameLabel.text = postDizisi[indexPath.row].moviesName
        cell.imageWatch.kf.setImage(with: URL(string: self.postDizisi[indexPath.row].imageUrl))

        return cell
    }

}

