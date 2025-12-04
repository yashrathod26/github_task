//
//  ViewController.swift
//  github_task
//
//  Created by Yash Rathod on 12/4/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSearch:UIButton!
    @IBOutlet weak var imgUser:UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrepos:UILabel!
    @IBOutlet weak var actView:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initView()
    }
    
    func initView() {
        self.actView.isHidden = true
        self.txtUsername.delegate = self
        
        self.imgUser.layer.cornerRadius = self.imgUser.frame.height / 2
        self.imgUser.clipsToBounds = true
    }

    func getData() {
        if(self.txtUsername.text == "") {
            showAlert(on: self, title: "Message", message: "Please Enter Username")
            return
        }
        self.startLoading()
        APIService.shared.request(url: Constants.baseUrl + self.txtUsername.text!) { result in
            switch result {
            case .success(let usr):
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.updateData(usr: usr)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopLoading()
                    showAlert(on: self, title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func updateData(usr:GitHubUser) {
        self.lblName.text = "Name: " + (usr.name ?? "No Username")
        self.lblrepos.text = "Public Repos: " + String(usr.public_repos ?? 0)
        self.imgUser.loadImage(from: usr.avatar_url ?? "No URL")
    }
    
    func startLoading() {
        self.actView.isHidden = false
        self.actView.startAnimating()
    }
    
    func stopLoading() {
        self.actView.isHidden = true
        self.actView.stopAnimating()
    }
 
    @IBAction func searchData(_ sender:UIButton) {
        self.getData()
        self.txtUsername.text = ""
        self.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.getData()
        self.resignFirstResponder()
        return true
    }
}

