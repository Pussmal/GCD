//
//  SecondViewController.swift
//  GCD
//
//  Created by Алексей Моторин on 25.07.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var image: UIImage {
        get {
            self.image
        }
        set {
            imageView.image = newValue
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        showAlert(delay: 2) {
            self.creatAlert()
        }
        fetchImage()
    }
    
    private func fetchImage() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        let url = "https://sun9-9.userapi.com/impg/ALqZi5UsgyIh_GkXHyBMDwZSNOgvY-RbReDK-g/72x1aehXMRM.jpg?size=1439x2160&quality=95&sign=9bd052fb7554c9e590d4af7a799a70fe&type=album"
       
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: url) else { return }
            guard let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else { return}
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    private func showAlert(delay: Int,  completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
           completion()
        }
    }
    
    private func creatAlert() {
        let alert = UIAlertController(title: "Enter login and password", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter login"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
        }
        present(alert, animated: true)
    }
}
