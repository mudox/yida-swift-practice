//
//  LoginFormViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 03/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class LoginFormViewController: UIViewController {
	let disposeBag = DisposeBag()

	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var scrollView: UIScrollView!

	// tracking active text field to scroll above keyboard interface
	var activeTextField: UITextField?

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		for name: Notification.Name in [.UIKeyboardDidShow, .UIKeyboardDidHide] {
			NotificationCenter.default.addObserver(
				self,
				selector: #selector(handleKeyboardNotification),
				name: name,
				object: nil
			)
		}

		// Rx
		inspectKeybaordNotifications()
		configureBackButton()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

	func handleKeyboardNotification(notify: Notification) {
		switch notify.name {
		case Notification.Name.UIKeyboardDidShow:
			if let activeTextField = activeTextField,
				let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
			{
				// add bottom insets
				self.scrollView.contentInset.bottom += keyboardSize.height
				self.scrollView.scrollIndicatorInsets = self.scrollView.scrollIndicatorInsets

				// Note: active text field's super view may not be the scroll view. using .superview is a safe way
				var rootViewVisibleFrame = self.view.frame
				rootViewVisibleFrame.size.height -= keyboardSize.size.height
				let activeTextFieldFrameInRootView = view.convert(activeTextField.frame, from: activeTextField.superview)

				if (rootViewVisibleFrame.contains(activeTextFieldFrameInRootView)) {
					self.scrollView.scrollRectToVisible(activeTextField.frame, animated: true)
				}
			}
		case Notification.Name.UIKeyboardDidHide:
			scrollView.contentInset = .zero
			scrollView.scrollIndicatorInsets = .zero
		default:
			fatalError()
		}
	}

}

extension LoginFormViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		activeTextField = textField
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		activeTextField = nil
	}
}

// Using RxSwift
extension LoginFormViewController {
	func inspectKeybaordNotifications() {
		for name: Notification.Name in [
				.UIKeyboardWillShow, .UIKeyboardDidShow,
				.UIKeyboardWillChangeFrame, .UIKeyboardDidChangeFrame,
				.UIKeyboardWillHide, .UIKeyboardDidHide
		] {
			theNotificationCenter.rx
				.notification(name)
				.subscribe(onNext: { notify in
					if let beginFrame = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
						let endFrame = (notify.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
							let text = "\n\(beginFrame.shortDescription) -> \(endFrame.shortDescription)"
							jack.debug(text, withPrefix: .text("\(name.rawValue)"))
					}
			}).addDisposableTo(disposeBag)
		}
	}

	func configureBackButton() {
		backButton.tintColor = .darkGray
		backButton.rx.tap.subscribe(onNext: { [weak self] in
			self?.dismiss(animated: true, completion: nil)
		}).addDisposableTo(disposeBag)
	}
}
