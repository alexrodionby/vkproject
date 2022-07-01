//
//  ViewController.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import UIKit
import WebKit

class AuthorizationVC: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: UIScreen.main.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupViews()
        

        // Срабатывает только после первого включения
        

//        if Session.isValid {
//            
//            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
//            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC")
//            self.navigationController?.pushViewController(tabbarVC, animated: false)
//            
//            return
//        }

        
        AuthorizationToVK()
        
        
        //        if Session.shared.showLoginScreen {
        //            setupViews()
        //            AuthorizationToVK()
        //        } else {
        //            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        //            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC")
        //            self.navigationController?.pushViewController(tabbarVC, animated: false)
        //        }
        
        
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(webView)
    }
    
    private func AuthorizationToVK() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8178545"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
//MARK: - End of main AuthorizationVC

extension AuthorizationVC: WKNavigationDelegate {
    
    /*
     https: - scheme
     //oauth.vk.com - host
     /blank.html - path
     
     # - fragment (кусок url после #)
     */
    //http://REDIRECT_URI#access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&expires_in=86400&user_id=8492&state=123456
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            print("Observe URL ->", navigationResponse.response.url ?? "defaul value")
            decisionHandler(.allow)
            return
        }
        
        /*access_token,
         533bacf01e11f55b536a565b57531ad114461ae8736d6506a3,
         expires_in,
         86400,
         user_id,
         8492&state=123456,
         */
        
        let params: Dictionary<String, String> = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce(Dictionary<String, String>()) { partialResult, param in
                var dictionary = partialResult
                let key = param[0]
                let value = param[1]
                dictionary[key] = value
                return dictionary
            }
        
        guard let token = params["access_token"], let userId = params["user_id"], let expiresIn = params["expires_in"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = Int(userId)
        Session.shared.expiresIn = Int(expiresIn)
        
        print("Session.shared.token ", Session.shared.token)
        print("Session.shared.userId ", Session.shared.userId)
        print("Session.shared.expiresIn ", Session.shared.expiresIn)
        
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC")
        self.navigationController?.pushViewController(tabbarVC, animated: false)
        
        decisionHandler(.cancel)
        
    }
}
