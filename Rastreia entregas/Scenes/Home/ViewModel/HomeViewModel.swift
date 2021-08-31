//
//  HomeViewModel.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation
import CoreData
import Services

class HomeViewModel {

    private enum SemaphoreState {
        case initial
        case wait
        case next
        case complete
        case failed
    }

    private var state: SemaphoreState = .initial {
        didSet {
            semaphoreIndex += state == .next ? 1 : 0
            if state == .next && semaphoreIndex < packageCodes.count {
                getPackagesTracked(packageCode: packageCodes[semaphoreIndex])

            } else if semaphoreIndex == packageCodes.count {
                state = .complete
            }

            if state == .complete || state == .failed {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.refreshTableViewData?(self.packagesTracked)
                }
            }
        }
    }

    public var refreshTableViewData: (([PackageTracking]) -> Void)?

    private var semaphoreIndex = 0

    private var packageCodes: [String] = []
    private var packagesStored: [Package] = []

    private var packagesTracked: [PackageTracking] = []

    private let timer = Timer()
    private let service: PackageProviding

    init(service: PackageProviding) {
        self.service = service
        self.packagesStored = getPackagesStored()

        packageCodes = packagesStored.compactMap {$0.code}
        if packageCodes.count > 0 {
            startSemaphore()
        }
    }

    private func startSemaphore() {
        getPackagesTracked(packageCode: packageCodes[semaphoreIndex])
    }
}

// MARK: - CoreDataManager
extension HomeViewModel {
    private func getPackagesStored() -> [Package] {
        let repository = PackageRepository.shared
        let packages = repository.get(predicate: .wasDelivered(bool: false))
        switch packages {
        case .success(let packagesFetched):
            return packagesFetched
        default:
            return []
        }
    }
}

// MARK: - Service
extension HomeViewModel {
    private func getPackagesTracked(packageCode: String) {
        state = .wait
        service.getPackage(code: packageCode) {[weak self] result in
            guard let self = self else { return }
            do {
                self.packagesTracked += [try result.get()]
                self.state = .next
                print(self.packagesTracked)
            } catch {
                self.state = .failed
                print(error)
            }
        }
    }
}
