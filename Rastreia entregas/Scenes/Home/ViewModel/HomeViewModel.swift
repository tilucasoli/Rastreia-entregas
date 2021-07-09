//
//  HomeViewModel.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation

class HomeViewModel {
    var packageCodes: [String]
    var packagesStored: [PackageStoredInfos] = []
    var packagesTracked: [PackageTracking] = []

    let service: PackageProviding

    init(service: PackageProviding) {
        self.service = service
        packageCodes = packagesStored.map {$0.code}
    }

    func getCellContents(in index: Int) -> (status: String,
                                            title: String,
                                            subtitle: String) {
        
        let title = packagesStored[index].title
        let subtitle = packagesTracked[index].eventos.first!.status

        let packageInfos = (status: "", title: title, subtitle: subtitle)

        return packageInfos
    }
}

// MARK: - CoreDataManager
extension HomeViewModel {
    private func getPackagesStored() -> [PackageStoredInfos] {

        return []
    }
}

// MARK: - Service
extension HomeViewModel {
    private func getPackagesTracked(packageCodes: [String]) {
        service.getPackage(code: packageCodes.first!) { result in
            do {
                self.packagesTracked = [try result.get()]
                print(self.packagesTracked)
            } catch {
                print(error)
            }

        }
    }
}
