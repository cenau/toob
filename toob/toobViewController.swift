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
    
    
    
    var webView: WKWebView!
    var button: NSButton!
    
    override func loadView() {
        view = NSView()
       let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            webView.heightAnchor.constraint(equalTo: self.view.heightAnchor ,multiplier: 0.79),
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
            button.heightAnchor.constraint(equalTo: self.view.heightAnchor ,multiplier: 0.21),
           button.widthAnchor.constraint(equalTo: self.view.widthAnchor),
           // button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           // button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        
        
        button.title = "Quit Toob"
        print(button.font = NSFont(name: ".AppleSystemUIFont", size:24))
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://www.youtube-nocookie.com/embed/-FlxM_0S2lA?rel=0&controls=0&showinfo=0")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
        
    }
    
    
    
    @objc func quit(){
        NSApplication.shared.terminate(self)
    }
    
}

extension toobViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> toobViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "toobViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? toobViewController else {
            fatalError("Can't find find toobViewController")
        }
        viewcontroller.preferredContentSize = CGSize(width: 256, height: 180)
        return viewcontroller
    }
    
    
}





