//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Cole Turner on 1/24/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let emojiChoices = [
        "Sports": ["🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","⛸","⛷","🏹"],
        "Animals": ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"],
        "Faces": ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","😇","🙂"],
        "Food": ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑"],
        "Flags": ["🏳️","🏴","🏁","🏳️‍🌈","🇦🇫","🇦🇽","🇩🇿","🇦🇸","🇧🇿","🇦🇮","🇦🇶","🇺🇸"],
        "Challenge": ["➡️","⬅️","⬆️","⬇️","↗️","↘️","↙️","↖️","⏺","⏹","🔀","🔁"]]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewContoller: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
        if let cvc = secondaryViewContoller as? ConcentrationGameViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = emojiChoices[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = emojiChoices[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationGameViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationGameViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationGameViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = emojiChoices[themeName] {
                if let cvc = segue.destination as? ConcentrationGameViewController {
                    cvc.theme = theme
                }
            }
        }
    }

}
