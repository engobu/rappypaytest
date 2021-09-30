//
//  PlayerViewController.swift
//  rappypaytest
//
//  Created by Enar GoMez on 29/09/21.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var webView : WKWebView!
    var oVideo : Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.frame = containerView.frame
        webView.frame.origin.x = 0
        webView.frame.origin.y = 0
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        containerView.addSubview(self.webView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let request = URLRequest(url: oVideo.youtubeURL!)
        webView.load(request)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerViewController: WKUIDelegate, WKNavigationDelegate {

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        return WKWebView(frame: webView.frame, configuration: configuration)
    }
    
   
}
