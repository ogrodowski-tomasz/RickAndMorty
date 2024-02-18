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
    static var previews: some View {
        CharactersListView(viewModel: characterListViewModel())
    }
}

