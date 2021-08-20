//
//  HomeView.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 12/08/21.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func pushViewController()
}

class HomeView: UIView {

    // MARK: Properties
    weak var delegate: HomeViewDelegate?

    // MARK: UI Elements
    private lazy var largeTitle = UILabel(fontStyle: .heading4, textColor: .REGray1)

    private lazy var button: REButton = {
        let button = REButton(style: .ghost, size: .medium)
        let icon = UIImage.icAdd?.withTintColor(.REBlue)
        button.setImage(icon, for: .normal)
        button.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        return button
    }()

    private lazy var stackview = UIStackView()
    private lazy var searchBar = RESearchBar()
    private lazy var segmentControl = RESegmentControl(segments: ["A caminho", "Arquivados"])

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(PackageTableViewCell.self,
                           forCellReuseIdentifier: PackageTableViewCell.reuseId)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: Haptics
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        configureLayout()

        buildHierarchy()
        setupConstraints()
        configureTapGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: layout
    private func configureLayout() {
        backgroundColor = .REGray4
        largeTitle.text = "Entregas"

        searchBar.isHighlighted = true
        segmentControl.style = .compacted
    }

    private func buildHierarchy() {
        addSubview(largeTitle)
        addSubview(button)
        addSubview(searchBar)
        addSubview(segmentControl)
        addSubview(tableView)
    }

    private func setupConstraints() {
        largeTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).inset(36)
            make.left.equalToSuperview().inset(24)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).inset(32)
            make.right.equalToSuperview().inset(13)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(largeTitle.snp.bottom).inset(-31)
            make.left.equalToSuperview().inset(24)
        }

        segmentControl.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchBar)
            make.left.equalTo(searchBar.snp.right).inset(-16)
            make.right.equalToSuperview().inset(24)
        }

        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).inset(-24)
        }
    }

    // MARK: Gestures
    private func configureTapGestures() {
        let segmentControlTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(segmentControlAction))
        let searchBarTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchBarAction))

        self.segmentControl.addGestureRecognizer(segmentControlTapRecognizer)
        self.searchBar.addGestureRecognizer(searchBarTapRecognizer)
    }

    @objc private func segmentControlAction() {
        switch segmentControl.style {
        case .compacted:
            impactFeedback.impactOccurred()

            segmentControl.applyStyle(.expanded)
            searchBar.isHighlighted = false
            searchBar.clearText()

        case .expanded: break
        }
    }

    @objc private func searchBarAction() {
        if !searchBar.isHighlighted {
            impactFeedback.impactOccurred()

            segmentControl.applyStyle(.compacted)
            searchBar.isHighlighted = true
        }
    }

    // MARK: Delegate
    @objc func pushViewController() {
        delegate?.pushViewController()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.reuseId,
                                                       for: indexPath) as? PackageTableViewCell else {
            return UITableViewCell()
        }

        let packageCard = PackageCard(icon: .delivered)
        packageCard.title = "Teste"
        packageCard.subtitle = "Godofredo Maciel"

        cell.configurePackageCard(packageCard: packageCard)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RETableViewHeader()
        headerView.title = "A caminho"
        return headerView
    }

}
