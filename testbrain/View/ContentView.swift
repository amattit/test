//
//  ContentView.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    
    @ObservedObject var viewModel: ContentViewModel
    @State var presentAddNote: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if UserDefaults.standard
                    .string(forKey: .sessionKey)?
                    .isEmpty ?? true {
                    Button(action: self.viewModel.auth) {
                        HStack {
                            Spacer()
                            Text("login")
                            Spacer()
                        }
                    }
                }
                List {
                    ForEach(viewModel.moments, id: \.self) { moment in
                        NoteViewRow(data: moment)
                    }
                    .onDelete(perform: deleteNote(_:))
                }
                .onAppear(perform: self.viewModel.getMoments)
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(leading: leadingButton, trailing: trailingButton)
            .sheet(isPresented: $presentAddNote, onDismiss: self.viewModel.getMoments, content: {
                CreateNoteView(viewModel: CreateNoteViewModel())
            })
        }
    }
    
    var leadingButton: some View {
        Button(action: {
            self.viewModel.getMoments()
        }) {
            Text("Обновить")
        }
    }
    
    var trailingButton: some View {
        Button(action: {
            self.presentAddNote.toggle()
        }) {
            Text("Добавить")
        }
    }
    
    func deleteNote(_ indexSet: IndexSet) {
        let moment = self.viewModel.moments[indexSet.first!]
        self.viewModel.deleteMoment(moment)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
