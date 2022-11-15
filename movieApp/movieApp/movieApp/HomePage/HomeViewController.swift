//
//  HomeViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 13/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
   
    @IBOutlet weak var searchTextField: UITextField!
    var nameHolder:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func movieBtn(_ sender: UIButton) {

            if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieList") as? MovieListViewController{
                self.navigationController?.pushViewController(vc, animated: true)
               
            }
        }
 
    
    @IBAction func actionBtn(_ sender: UIButton) {
       
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ActorList") as? ActorListViewController{
                self.navigationController?.pushViewController(vc, animated: true)
               
            }
        }


}
