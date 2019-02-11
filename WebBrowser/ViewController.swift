//
//  ViewController.swift
//  WebBrowser
//
//  Created by Allan Shivji on 2/6/19.
//  Copyright © 2019 Allan Shivji. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            webView.navigationDelegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if !CheckInternet.Connection() {
            self.Alert(Message: "Make sure you device is connected to the Wi-Fi or Cellular network")
        }
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        if !CheckInternet.Connection(){
            self.Alert(Message: "Make sure you device is connected to the Wi-Fi or Cellular network")
        }
            let urlString = "http://www.apple.com"
            let url:URL = URL(string: urlString)!
            let urlRequest:URLRequest = URLRequest(url: url)
            webView.load(urlRequest)
            textField.text = urlString


    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !CheckInternet.Connection(){
            self.Alert(Message: "Make sure you device is connected to the Wi-Fi or Cellular network")
        }
        
        let urlString:String = textField.text!
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        textField.text = urlString
        textField.resignFirstResponder()
        return true
    }
    
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "No Internet Connection", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        if !CheckInternet.Connection(){
            self.Alert(Message: "Make sure you device is connected to the Wi-Fi or Cellular network")
        }else {
            if webView.canGoBack{
                webView.goBack()
            }
        }
        
        
    }
    @IBAction func forwardButtonTapped(_ sender: Any) {
        
        if !CheckInternet.Connection(){
            self.Alert(Message: "Make sure you device is connected to the Wi-Fi or Cellular network")
        } else {
            if webView.canGoForward{
                webView.goForward()
            }
        }
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        textField.text = webView.url?.absoluteString
    }

    
}

