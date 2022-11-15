//
//  ActorSearchViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 14/11/22.
//

import UIKit

class ActorSearchViewController: UIViewController {

    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var network = NetworkManager()
    var nameHolder:String = ""
    var titleHolder:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchTitle.text = "Search: \(titleHolder)"
        network.fetchSearchActor(searchResult: nameHolder) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}


extension ActorSearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ActorDetail") as? ActorDetailViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            vc.idHolder = network.ActorListArray[indexPath.row].person.id
            vc.nameHolder = network.ActorListArray[indexPath.row].person.name
            if let age = network.ActorListArray[indexPath.row].person.birthday{
                vc.ageHolder = "\(age)"
            }else{
                vc.ageHolder = "-"
            }
            if let gender = network.ActorListArray[indexPath.row].person.gender{
                vc.genderHolder = gender
            }else{
                vc.genderHolder = "None"
            }
            vc.imageHolder = network.ActorListArray[indexPath.row].person.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png"
            if let nationality = network.ActorListArray[indexPath.row].person.country?.name{

                vc.nationHolder = nationality
            }else{
                vc.nationHolder = "None"
            }
            
        }
    }
}

extension ActorSearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.ActorListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActorSearchTableViewCell
        cell.actorImage.loadImage(urlString: network.ActorListArray[indexPath.row].person.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        cell.actorName.text = network.ActorListArray[indexPath.row].person.name
        cell.actorAge.text = network.ActorListArray[indexPath.row].person.birthday
        cell.actorGender.text = network.ActorListArray[indexPath.row].person.gender
        
        return cell
    }
    
    
}
