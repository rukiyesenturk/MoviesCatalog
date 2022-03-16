//
//  SearchViewController.swift
//  MoviesCatalog
//
//  Created by Macbook on 12.03.2022.
//

import UIKit

class SearchViewController: UIViewController, MoviesManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    var helperTools = HelperTools()
    var searchResults : [DataCarrier] = []
    var moviesManager = MoviesManager()
    var typedText : String?
    var indexNo : Int?
    var refresh : UIRefreshControl {
        let ref = UIRefreshControl ()
        ref.addTarget(self, action: #selector (clearTextbox(_:)), for: .valueChanged)
        return ref
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesManager.delegate = self
        moviesManager.getMoviesData()
        // Do any additional setup after loading the view.
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        searchBar.delegate = self
        helperTools.tableViewSeparator(tableView: moviesTableView) // to rid from tableview separator lines.
        moviesTableView.addSubview(refresh) // related with refresh of tableview to pull down gesturecognizer
        
    }
    func getMovies(_ modelManager: MoviesManager, _ moviesModel: [MoviesModel]) {
        DispatchQueue.main.async { //when async situation finish. reload tableView otherwise every time we see white screen :) this mean never tableView will be load.
            self.helperTools.addToDataCarrier(moviesModel: moviesModel)
            DataCarrier.shared.sort(by: {$0.original_title < $1.original_title}) //this code line provides displays the list of countries in alphabetical order.
            self.moviesTableView.reloadData() // i have refreshed tableView Screen
            
        }
    }

}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typedText == nil || typedText == ""{ //i have arranged from where search bar or normal to count of tableView row
            return DataCarrier.shared.count
        }else {
            return searchResults.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        
    
        if typedText == nil || typedText == "" { //i have arranged from where search bar or normal
            

            cell.moviesLabel.text = DataCarrier.shared[indexPath.row].original_title + (" - ") + DataCarrier.shared[indexPath.row].release_date
            
            
        }else { // if i were came form search bar so below code lines will be work.
            
            cell.moviesLabel.text = searchResults[indexPath.row].original_title
        }
        
        return cell
    }
    
    @objc func clearTextbox(_ control : UIRefreshControl) { //pullDown gesture working here to clean entire main page.
        typedText?.removeAll()
        searchBar.text?.removeAll()
        searchResults.removeAll()
        moviesTableView.reloadData()
        control.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexNo =  indexPath.row //i have catched index number here.
        performSegue(withIdentifier: "goToDetails", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let destinationPage = segue.destination as? DetailsViewController {
            
                destinationPage.indexNo = indexNo // we need index number to fallow right cauntry is added favorite.
            }
        }
    }
    
}

extension SearchViewController : UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // i am getting here writed text from searchBar
        typedText?.removeAll()
        typedText = searchText
        searchResults = DataCarrier.shared.filter({$0.original_title.contains(typedText!)})
        moviesTableView.reloadData()
        
    }
}
