//
//  DetailsViewController.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import UIKit
import Foundation
import Kingfisher
import Firebase

class DetailsViewController: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var modelImageManager = MoviesManager()
    var helperTools = HelperTools()
    var detailResult : [DataCarrier] = []
    
    var indexNo : Int?
    var baseUrl = "https://image.tmdb.org/t/p/w500"
    var moviesName: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesName = DataCarrier.shared[indexNo!].original_title
        titleLabel.text = moviesName
        overviewLabel.text  = DataCarrier.shared[indexNo!].overview
        let imageUrl = URL(string: (baseUrl)+(DataCarrier.shared[indexNo!].poster_path))
        print(imageUrl!)
        imageView.kf.setImage(with: imageUrl)

    }
 
    @IBAction func watchListPressed(_ sender: Any) {
        saveMovie(Post: "WatchPost")
    }
    @IBAction func facoritesPressed(_ sender: Any) {
       saveMovie(Post: "FavoritePost")
    }
    func saveMovie(Post:  String){
        let storage = Storage.storage()
        let storageReferance = storage.reference()

        let mediaFolder = storageReferance.child("Movies")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { StorageMetadata, error in
                if error != nil{
                    self.errorMessageShow(title: "Error!", message: error?.localizedDescription ?? "You got an error, please try again")
                }else{
                    imageReferance.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            //verilerimizi firestore'a kaydedelim.
                            if let imageUrl = imageUrl {

                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageUrl": imageUrl, "moviesName": self.moviesName] as [String: Any]
                                
                                firestoreDatabase.collection(Post).addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.errorMessageShow(title: "Error!", message: error?.localizedDescription ?? "You got an error, please try again")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    @IBAction func backSearchPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func errorMessageShow(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

