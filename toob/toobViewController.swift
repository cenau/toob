//
//  toobViewController.swift
//  toob
//
//  Created by Geraint Jones on 15/06/2018.
//  Copyright © 2018 Geraint Jones. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation
import WebKit
import AppKit

class toobViewController: NSViewController, WKUIDelegate  {
    
    
    
    var webView: toobWebView!
    var button: NSButton!
    var keys: NSDictionary!
    
    override func loadView() {
        view = toobView()
        NSLayoutConstraint.activate([
           view.widthAnchor.constraint(equalToConstant: 224),
            view.heightAnchor.constraint(equalToConstant: 158),
            ])
        
       let webConfiguration = WKWebViewConfiguration()
        webView = toobWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalToConstant: 224),
            webView.heightAnchor.constraint(equalToConstant: 126),
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            ])
        
       button = NSButton()
        
        
        button.frame = .zero
        self.view.addSubview(button)
        
        button.target = self
        button.action = #selector(self.quit)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 32),
           button.widthAnchor.constraint(equalTo: self.view.widthAnchor),
           // button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           // button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        
        
        button.attributedTitle = NSMutableAttributedString(string: " Quit Toob", attributes: [NSAttributedStringKey.foregroundColor: NSColor.black, NSAttributedStringKey.font: NSFont.systemFont(ofSize: 14)])
        
        
        button.showsBorderOnlyWhileMouseInside = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        print(keys)
        
        let myURL = URL(string:"https://www.youtube-nocookie.com/embed/-FlxM_0S2lA?rel=0&controls=0&modestbranding=1&iv_load_policy=3")
      //  let myRequest = URLRequest(url: myURL!)
      //  webView.load(myRequest)
        
        
        
    }
    
    
    
    @objc func quit(){
        NSApplication.shared.terminate(self)
    }
    
}

    
    






