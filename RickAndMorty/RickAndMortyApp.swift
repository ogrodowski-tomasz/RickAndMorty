import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject private var characterListViewModel: CharactersListViewModel

    init() {
        let network = CharactersListServiceManager()
        let storage = CharactersListStorageManager(networkManager: network)
        let viewModel = CharactersListViewModel(storageManager: storage)
        _characterListViewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some Scene {
        WindowGroup {
            CharactersListView(viewModel: characterListViewModel)
        }
    }
}
