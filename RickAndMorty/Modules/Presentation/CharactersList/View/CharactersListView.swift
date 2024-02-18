import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel
    var body: some View {
        List(viewModel.characters) { character in
            Text(character.name)
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    
    static func viewModel() -> CharactersListViewModel {
        let network = CharactersListServiceManager()
        let storage = CharactersListStorageManager(networkManager: network)
        let viewModel = CharactersListViewModel(storageManager: storage)
        return viewModel
    }

    static var previews: some View {
        CharactersListView(viewModel: viewModel())
    }
}

