//
//  Gui.swift
//  Cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.01.2019.
//  Copyright © 2019 Dr. Kerem Koseoglu. All rights reserved.
//

import Foundation
import UIKit

class Gui {
	
	static func is_email_valid(email: String) -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
		return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
	}
	
	static func show_error_popup(error: Error, parent: UIViewController) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		parent.present(alert, animated: true, completion: nil)
	}
	
	static func show_popup(title: String, message: String, parent: UIViewController) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		parent.present(alert, animated: true, completion: nil)
	}
	
}
