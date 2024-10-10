//
//  UTMRemoverApp.swift
//  UTMRemover
//
//  Created by Geoffrey Hollingworth on 10/9/24.
//

import SwiftUI
import AppKit

@main
struct UTMRemoverApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "link", accessibilityDescription: "UTM Remover")
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "UTM Remover Active", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
        
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp) { [weak self] _ in
            self?.checkClipboardForUTM()
        }
    }
    
    func checkClipboardForUTM() {
        let pasteboard = NSPasteboard.general
        if let urlString = pasteboard.string(forType: .string), urlString.contains("utm_") {
            if let cleanURL = removeUTMParameters(from: urlString) {
                pasteboard.clearContents()
                pasteboard.setString(cleanURL, forType: .string)
            }
        }
    }
    
    func removeUTMParameters(from urlString: String) -> String? {
        guard let url = URL(string: urlString),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        components.queryItems = components.queryItems?.filter { !$0.name.lowercased().hasPrefix("utm_") }
        
        if components.queryItems?.isEmpty == true {
            components.queryItems = nil
        }
        
        return components.url?.absoluteString
    }
}
