//
//  toobWebView.swift
//  toob
//
//  Created by Geraint Jones on 19/06/2018.
//  Copyright © 2018 Geraint Jones. All rights reserved.
//

import Cocoa
import WebKit

class toobWebView: WKWebView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
}
