//
//  HelpVC.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import UIKit
import WebKit

class HelpVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Help"
        
        loadWebView()
    }
    
    func loadWebView(){
        
        guard let url = URL(string: "https://www.mobiquity.com")  else { return }  // Adding this url as URL for the app help is not avaialble
        let request = URLRequest(url: url)
        webView?.load(request)
    }

}
