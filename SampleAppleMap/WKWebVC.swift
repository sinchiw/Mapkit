//
//  WKWebVC.swift
//  SampleAppleMap
//
//  Created by Wilmer sinchi on 6/13/18.
//  Copyright © 2018 TurnToTech. All rights reserved.
//

import WebKit

class WebViewController: UIViewController{
    var url: URL!
    var wKWebView: WKWebView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        wKWebView = WKWebView(frame:  view.frame.size);)
        containerView.addSubview(wKWebView)
        wKWebView.navigationDelegate = self as? WKNavigationDelegate
        wKWebView.uiDelegate = self as? WKUIDelegate
        let request = URLRequest(url: url)
        wKWebView.load(request)
    }
    
    
}
