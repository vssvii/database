//
//  InfoViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 12.01.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        
        let buttonInfo = UIButton(frame: CGRect(x: 130, y: 200, width: 100, height: 50))
        buttonInfo.backgroundColor = .systemGreen
        buttonInfo.setTitle("Info", for: .normal)
        buttonInfo.addTarget(self, action: #selector(buttonInfoAction), for: .touchUpInside)
        self.view.addSubview(buttonInfo)
    }
    
    @objc func buttonInfoAction(sender: UIButton!) {
        let alertController = UIAlertController(title: "Cообщение!", message: "Прошу нажать один из вариантов!", preferredStyle: .alert)
        let messageAction = UIAlertAction(title: "Вывести сообщение!", style: .default, handler: { action in
            self.showMessage()})
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(messageAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        }
    
    func showMessage() {
        let alertMessage = UIAlertController(title: "Внимание!", message: "Сообщение выявлено!", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(alertAction)
        present(alertMessage, animated: true, completion: nil)
    }
}
