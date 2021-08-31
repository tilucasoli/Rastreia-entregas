//
//  AddPackageView.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 16/08/21.
//

import UIKit
import REUIKit

protocol AddPackageViewDelegate: AnyObject {
    var name: String { get set }
    var code: String { get set }

    func savePackage()
    func checkIfPackageWorks(code: String)
}

class AddPackageView: UIView {

    // MARK: Properties
    weak var delegate: AddPackageViewDelegate?

    var dismiss: (() -> Void)?
    var presentAlert: (() -> Void)?

    // MARK: UI Elements
    lazy var closeButton = REButton(style: .ghost, size: .medium)
    lazy var titleLabel = UILabel(fontStyle: .heading5, textColor: .REGray1)
    lazy var interactablePackageCard = InteractablePackageCard()
    lazy var subtitleLabel = UILabel(fontStyle: .heading6, textColor: .REGray1)
    lazy var nameTextField = RETextField(style: .standard)
    lazy var codeTextField = RETextField(style: .standard)
    lazy var continueButton = RELargeButton(style: .primary)

    // MARK: Initializer
    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        interactablePackageCard.packageCard.title = nameTextField.text
    }

    // MARK: Layout
    func configureViews() {
        backgroundColor = .REGray4
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)

        closeButton.setImage(.icExit, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)

        titleLabel.text = "Rastreando pacote"
        subtitleLabel.text = "Informações"

        nameTextField.placeholder = "Nome"
        nameTextField.delegate = self
        codeTextField.placeholder = "Código"
        codeTextField.delegate = self

        continueButton.setTitle("Rastrear", for: .normal)
        continueButton.addTarget(self, action: #selector(loading), for: .touchUpInside)
        continueButton.isEnabled = false
    }

    func buildHierarchy() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(interactablePackageCard)
        addSubview(subtitleLabel)
        addSubview(nameTextField)
        addSubview(codeTextField)
        addSubview(continueButton)
    }

    func setupConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        interactablePackageCard.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false

        closeButton.snp.makeConstraints { make in
            make.right.topMargin.equalTo(self).inset(8)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.centerX.equalTo(self)
        }

        interactablePackageCard.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-24)
            make.centerX.equalTo(self)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(interactablePackageCard.snp.bottom).inset(-32)
            make.left.equalTo(self).inset(36)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).inset(-16)
            make.left.right.equalTo(self).inset(36)
        }

        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(-24)
            make.left.right.equalTo(self).inset(36)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottomMargin)
            make.left.right.equalTo(self).inset(36)
        }
    }

    // MARK: Actions
    @objc private func dismissAction() {
        dismiss?()
    }

    @objc private func loading() {
        guard let codeText = codeTextField.text,
              let nameText = nameTextField.text else { return }

        delegate?.code = codeText
        delegate?.name = nameText

        presentAlert?()
        delegate?.checkIfPackageWorks(code: codeText)
    }

    @objc func savePackage() {

        delegate?.savePackage()
        dismiss?()
    }

    @objc private func dismissKeyboard() {
        endEditing(true)
    }

}

extension AddPackageView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let codeText = codeTextField.text,
              let nameText = nameTextField.text else {
            continueButton.isEnabled = false
            return
        }
        continueButton.isEnabled = codeText.count > 0 && nameText.count > 0
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if textField.text?.count == 1 && string == "" {
            textField.text = ""
        }

        return true
    }
}
