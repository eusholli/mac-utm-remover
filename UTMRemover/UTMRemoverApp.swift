//
//  UTMRemoverApp.swift
//  UTMRemover
//
//  Created by Geoffrey Hollingworth on 10/9/24.
//

import AppKit

// Menu bar app delegate
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    private var lastChangeCount: Int = 0
    private var clipboardTimer: Timer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusBar()
        setupClipboardMonitoring()
    }
    
    func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "link", accessibilityDescription: "UTM Remover")
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "UTM Remover Active", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func setupClipboardMonitoring() {
        // Initialize the last change count
        lastChangeCount = NSPasteboard.general.changeCount
        
        // Set up a timer to check the clipboard regularly
        clipboardTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkClipboardChanges()
        }
    }
    
    func checkClipboardChanges() {
        let pasteboard = NSPasteboard.general
        if pasteboard.changeCount != lastChangeCount {
            lastChangeCount = pasteboard.changeCount
            checkClipboardForUTM()
        }
    }
    
    func checkClipboardForUTM() {
        let pasteboard = NSPasteboard.general
        if let urlString = pasteboard.string(forType: .string), 
           (urlString.contains("utm_") || urlString.contains("rcm") || urlString.contains("trackingId")) {
            if let cleanURL = removeTrackingParameters(from: urlString) {
                pasteboard.clearContents()
                pasteboard.setString(cleanURL, forType: .string)
            }
        }
    }
    
    func removeTrackingParameters(from urlString: String) -> String? {
        guard let url = URL(string: urlString),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        components.queryItems = components.queryItems?.filter { item in
            !item.name.lowercased().hasPrefix("utm_") && 
            !item.name.lowercased().hasPrefix("rcm") && 
            !item.name.lowercased().hasPrefix("trackingid")
        }
        
        if components.queryItems?.isEmpty == true {
            components.queryItems = nil
        }
        
        return components.url?.absoluteString
    }
}
