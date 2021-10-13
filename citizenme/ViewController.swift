//
//  ViewController.swift
//  citizenme
//
//  Created by Furkan Karakoc on 12.10.2021.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonParse =  [Post]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        downloadJSON {
            self.tableView.reloadData()
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "POSTS"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonParse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = jsonParse[indexPath.row].body.capitalized
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? JsonViewController {
            destination.detailPage =
                jsonParse[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
            if error == nil {
                
                do {
                    self.jsonParse = try JSONDecoder().decode([Post].self, from :data!)
                    
                    DispatchQueue.main.sync {
                        completed()
                    }
                }catch {
                    print("JSON Error")
                }
            }
            
        }.resume()
    }
}

