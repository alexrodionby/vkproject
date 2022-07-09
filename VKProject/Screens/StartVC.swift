//
//  StartVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.06.22.
//

import UIKit

class StartVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let twoLineButton = TwoLinedButton(frame: CGRect(x: 0, y: 0, width: 300, height: 65))
        view.addSubview(twoLineButton)
        twoLineButton.center = view.center
        twoLineButton.configure(with: TwoLinedButtonViewModel(
            primaryText: "Хочешь стать программистом?",
            secondaryText: "Ныряй глубже ->"))
        twoLineButton.addTarget(self, action: #selector(tappTwoLineButton), for: .touchUpInside)
        
        let iconButton = IconTextButton(frame: CGRect(x: (view.frame.size.width - 300) / 2, y: (view.frame.height / 2) + 50, width: 300, height: 65))
        view.addSubview(iconButton)
        iconButton.configure(with: IconTextButtonViewModel(text: "Или на завод?", image: UIImage(systemName: "wrench.and.screwdriver"), backgroundColor: .systemRed))
        iconButton.addTarget(self, action: #selector(tappTwoIconButton), for: .touchUpInside)
    }
    
    @objc func tappTwoLineButton() {
        print("Нажали на зеленую кнопку")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AuthorizationVC = storyboard.instantiateViewController(withIdentifier: "AuthorizationVC")
        self.navigationController?.pushViewController(AuthorizationVC, animated: false)
    }
    
    @objc func tappTwoIconButton() {
        print("Нажали на красную кнопку")
        view.backgroundColor = .red
    }
}
