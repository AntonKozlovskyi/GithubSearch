//
//  WebViewView.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/16/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import WebKit

class WebViewView: UIView {
    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var closeButton: UIButton?
    @IBOutlet weak var spinner: UIActivityIndicatorView?
}
