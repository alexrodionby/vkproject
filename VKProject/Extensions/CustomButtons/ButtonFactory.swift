//
//  ButtonFactory.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 12.07.22.
//

import UIKit

protocol Button {
    func setTitle(_ title: String?)
    func show()
}

class MacOSButton: Button {
    var title: String?
    
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func show() {
        print("show macos button with title \(self.title ?? "")")
    }
}

class WindowsButton: Button {
    var title: String?
    
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func show() {
        print("show windows button with title \(self.title ?? "")")
    }
}

class MobileButton: Button {
    var title: String?
    
    func setTitle(_ title: String?) {
        self.title = title
    }
    
    func show() {
        print("show mobile button with title \(self.title ?? "")")
    }
}

enum ButtonType {
    case macos
    case windows
    case mobile
}


class ButtonFactory {
    
    func button(with type: ButtonType) -> Button {
        
        switch type {
        case .macos:
            return MacOSButton()
        case .windows:
            return WindowsButton()
        case .mobile:
            return MobileButton()
        }
    }
}
