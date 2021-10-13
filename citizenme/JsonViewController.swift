//
//  JsonViewController.swift
//  citizenme
//
//  Created by Furkan Karakoc on 12.10.2021.
//

import UIKit

class JsonViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleBodyLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var nameBodyLbl: UILabel!
    
    var detailPage:Post?
  
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let url = URL(string: "https://media-exp1.licdn.com/dms/image/C560BAQFfXU-PCeCVRg/company-logo_200_200/0/1519909996723?e=1642032000&v=beta&t=hYA9bAyUtTvp5dzacpnZdiiy2gDmd4UUUVN2qrwaBi8")!
            downloadImage(from: url)
            print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        nameLbl.text = detailPage?.body
        nameLbl.adjustsFontSizeToFitWidth = true
        
        nameBodyLbl.text = detailPage?.body
       // nameBodyLbl.adjustsFontSizeToFitWidth = true
        
        titleBodyLbl.text = detailPage?.title
        titleBodyLbl.adjustsFontSizeToFitWidth = true
        
        
        
       
      
    }
    
    
}
