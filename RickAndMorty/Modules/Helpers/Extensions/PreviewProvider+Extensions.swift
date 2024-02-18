import SwiftUI

extension PreviewProvider {
    static func characterListViewModel() -> CharactersListViewModel {
        let network = CharactersListServiceManagerStub()
        let storage = CharactersListStorageManager(networkManager: network)
        let viewModel = CharactersListViewModel(storageManager: storage)
        return viewModel
    }
}
