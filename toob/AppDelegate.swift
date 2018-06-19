//
//  AppDelegate.swift
//  toob
//
//  Created by Geraint Jones on 15/06/2018.
//  Copyright © 2018 Geraint Jones. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    let popover = NSPopover()
    
    var detector: Any?
    
    var debug: Bool!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = toobViewController()
        popover.animates = false;
        
        detector = NSEvent.addGlobalMonitorForEvents(matching:[NSEvent.EventTypeMask.leftMouseDown, NSEvent.EventTypeMask.rightMouseDown], handler: { [weak self] event in
            self?.closePopover(sender: event)
        })
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        let build = Bundle.main.infoDictionary!["CFBundleVersion"]!
        
        print("toob v\(version) \(build)")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func test(_ sender: Any?) {
    }
    
    
    
    @objc func togglePopover(_ sender: Any?) {
        debug = false
        let event = NSApp.currentEvent!
        if (event.modifierFlags.contains(.option) ) //alt is pressed
        {
            debug = true
        }
        
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender, debug:debug)
            
        }
            
    }
    
    
    func showPopover(sender: Any?, debug:Bool) {
        
        
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
}

