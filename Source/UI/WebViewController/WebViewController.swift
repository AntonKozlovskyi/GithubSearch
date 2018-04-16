//
//  WebViewController.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/16/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, RootViewGettable {
    typealias RootViewType = WebViewView
    
    var URLString: String? {
        didSet {
            self.load()
        }
    }
    
    //MARK: -
    //MARK: View Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.webView?.navigationDelegate = self
        self.load()
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onClose(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: -
    //MARK: Private
    
    private func load() {
        let view = self.rootView
        let webView = view?.webView
        if let urlString = self.URLString, let URL = URL(string: urlString) {
            if webView?.isLoading == false {
                view?.spinner?.startAnimating()
                webView?.load(URLRequest(url: URL))
            }
        }
    }
}

//MARK:-
//MARK: WKNavigation delegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        self.rootView?.spinner?.stopAnimating()
    }
}
