//
//  CreateNoteView.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import SwiftUI
import Combine

struct CreateNoteView: View {
    @Environment(\.presentationMode) var presntationMode
    @ObservedObject var viewModel: CreateNoteViewModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                TextField("title", text: $viewModel.title)
                Text("Note")
                    .font(.headline)
                TextField("note", text: $viewModel.note)
                Text("Mood")
                    .font(.subheadline)
                TextField("mood", text: $viewModel.mood)
                Spacer()
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarTitle("AddNote")
            .navigationBarItems(trailing: trailingButton)
        }
        .onReceive(presenterPublisher) { value in
            if !value {
                self.presntationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
    var presenterPublisher: AnyPublisher<Bool, Never> {
        viewModel.$isPresented.map { $0 }.eraseToAnyPublisher()
    }
    var trailingButton: some View {
        Button(action: viewModel.add) {
            Text("Save")
        }
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView(viewModel: CreateNoteViewModel())
    }
}

class CreateNoteViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var note: String = ""
    @Published var mood: String = ""
    @Published var isPresented: Bool = true
    
    let repository = Repository()
    var store = Set<AnyCancellable>()
    
    func add() {
        let request = CreateNoteRequest(mood: mood, notes: note, title: title, creatorPID: CreatorPID())
        repository
            .createNote(request: request)
            .map { $0 }
            .sink(receiveCompletion: { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished: break
                }
            }) { (response) in
                self.isPresented = false
        }.store(in: &store)
    }
}
