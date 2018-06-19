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
        
        
        button.wantsLayer = true
        
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
        
        button.isBordered = false
        
        
    }
    
    
    override func mouseEntered(with event: NSEvent) {
        
        button.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        
        button.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override func viewWillAppear() {
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        
        var vidId: String!
        
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCSJ4gkVC6NrvII8umztf0Ow&eventType=live&maxResults=1&type=video&key=" + (keys.object(forKey: "youtubeApiKey") as? String)!
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                    
                    if let items = json["items"] as? [[String:Any]] {
                        vidId = ((items[0] as NSDictionary).object(forKey: "id") as! NSDictionary).object(forKey: "videoId") as! String
                        
                        
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.loadVideoWith(videoId:vidId)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
        
        
        
        
        
        
        
    }
    
    override func viewDidLayout() {
        
        let area = NSTrackingArea.init(rect: button.frame,
                                       options: [.mouseEnteredAndExited, .activeAlways],
                                       owner: self,
                                       userInfo: nil)
        
        print(area)
        button.addTrackingArea(area)
        
    }
    
    
    func loadVideoWith(videoId: String){
        let theURL = URL(string:"https://www.youtube-nocookie.com/embed/\(videoId)?rel=0&controls=0&modestbranding=1&iv_load_policy=3")
        print(theURL)
        let myRequest = URLRequest(url: theURL!)
        self.webView.load(myRequest)
    }
    
    @objc func quit(){
        NSApplication.shared.terminate(self)
    }
    
}

    







