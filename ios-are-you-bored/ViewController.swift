//
//  ViewController.swift
//  ios-are-you-bored
//
//  Created by Оля Галягина on 02.02.2023.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var activityLbl: UILabel!
    
    let storage = Storage()
    
    var currentActivity: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialSetup()
        
    }
    
    private func getActivityWithAlamofire(completionHandler: @escaping (String?, AFError?) -> Void) {
        guard let url = URL(string: APIClient.shared.getActivityURL()) else {
            print("could not form url")
            return
        }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    if let activity = json["activity"] {
                        completionHandler(activity as? String, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    func initialSetup() {
        
        setupActivity()
        
        let coverLayer = CALayer()
        
        backgroundImage.image = UIImage(named: "background_image")!
        
        coverLayer.frame = CGRect(x: 0, y: 0, width: backgroundImage.image?.size.width ?? 0, height: backgroundImage.image?.size.height ?? 0)
        
        coverLayer.backgroundColor = UIColor.black.cgColor
        
        coverLayer.opacity = 0.7
        
        backgroundImage.layer.addSublayer(coverLayer)
        
    }
    
    func setupActivity() {
        
        getActivityWithAlamofire(completionHandler: {response, error in
            if let activity = response {
                self.activityLbl.text = activity
                self.currentActivity = activity
            }
        })
        
    }
    
    @IBAction func yesBtnDidTouch(_ sender: Any) {
        storage.saveActivity(currentActivity)
        setupActivity()
    }
    
    @IBAction func noBtnDidTouch(_ sender: Any) {
        setupActivity()
    }
    
    @IBAction func stopBtnDidTouch(_ sender: Any) {
        showResult()
        storage.resetActivities()
    }
    
    func showResult() {
        
        var alert = UIAlertController()
        
        var finalAlertAction = UIAlertAction()
        
        if storage.checkActivities() {
            alert = UIAlertController(title: "result", message: "You should \(storage.getRandomActivity())", preferredStyle: .alert)
            finalAlertAction = UIAlertAction(title: "ok", style: .default) {(action) in
                self.setupActivity()
                alert.dismiss(animated: true, completion: nil)
            }
        } else {
            alert = UIAlertController(title: "result", message: storage.getRandomActivity(), preferredStyle: .alert)
            finalAlertAction = UIAlertAction(title: "ok", style: .default) {(action) in
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
        alert.addAction(finalAlertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
